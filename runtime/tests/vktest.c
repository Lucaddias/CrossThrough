/*
 * vktest.c — teste de fumaça do Vulkan (winevulkan -> MoltenVK -> Metal).
 *
 * Carrega vulkan-1.dll em tempo de execução (o mingw não traz o loader nem os
 * headers do Vulkan), cria uma instância e lista os dispositivos físicos.
 * Saída: 0 se houver pelo menos um dispositivo.
 */
#define WIN32_LEAN_AND_MEAN
#include <windows.h>
#include <stdio.h>
#include <stdint.h>

#define VK_SUCCESS 0
#define VK_STRUCTURE_TYPE_APPLICATION_INFO 0
#define VK_STRUCTURE_TYPE_INSTANCE_CREATE_INFO 1
#define VK_API_VERSION_1_1 ((1u << 22) | (1u << 12))

typedef int32_t VkResult;
typedef struct VkInstance_T *VkInstance;
typedef struct VkPhysicalDevice_T *VkPhysicalDevice;
typedef void (__stdcall *PFN_vkVoidFunction)(void);

typedef struct {
    int sType; const void *pNext; const char *pApplicationName; uint32_t applicationVersion;
    const char *pEngineName; uint32_t engineVersion; uint32_t apiVersion;
} VkApplicationInfo;

typedef struct {
    int sType; const void *pNext; uint32_t flags; const VkApplicationInfo *pApplicationInfo;
    uint32_t enabledLayerCount; const char *const *ppEnabledLayerNames;
    uint32_t enabledExtensionCount; const char *const *ppEnabledExtensionNames;
} VkInstanceCreateInfo;

typedef struct {
    uint32_t apiVersion, driverVersion, vendorID, deviceID;
    int deviceType;
    char deviceName[256];
    uint8_t pipelineCacheUUID[16];
    uint8_t rest[1024]; /* limites e propriedades esparsas: não lidos aqui */
} VkPhysicalDeviceProperties;

typedef PFN_vkVoidFunction (__stdcall *PFN_vkGetInstanceProcAddr)(VkInstance, const char *);
typedef VkResult (__stdcall *PFN_vkCreateInstance)(const VkInstanceCreateInfo *, const void *, VkInstance *);
typedef VkResult (__stdcall *PFN_vkEnumeratePhysicalDevices)(VkInstance, uint32_t *, VkPhysicalDevice *);
typedef void (__stdcall *PFN_vkGetPhysicalDeviceProperties)(VkPhysicalDevice, VkPhysicalDeviceProperties *);

int main(void)
{
    VkApplicationInfo app = {VK_STRUCTURE_TYPE_APPLICATION_INFO, NULL, "vktest", 1, "none", 1, VK_API_VERSION_1_1};
    VkInstanceCreateInfo info = {VK_STRUCTURE_TYPE_INSTANCE_CREATE_INFO, NULL, 0, &app, 0, NULL, 0, NULL};
    PFN_vkGetInstanceProcAddr gipa;
    PFN_vkCreateInstance create;
    PFN_vkEnumeratePhysicalDevices enumerate;
    PFN_vkGetPhysicalDeviceProperties props;
    VkPhysicalDevice devices[8];
    VkPhysicalDeviceProperties p;
    VkInstance instance;
    uint32_t count = 8, i;
    HMODULE vk;
    VkResult r;

    vk = LoadLibraryA("vulkan-1.dll");
    if (!vk) { printf("FAIL LoadLibrary(vulkan-1.dll)\n"); return 1; }
    gipa = (PFN_vkGetInstanceProcAddr)(void *)GetProcAddress(vk, "vkGetInstanceProcAddr");
    if (!gipa) { printf("FAIL vkGetInstanceProcAddr\n"); return 1; }
    create = (PFN_vkCreateInstance)(void *)gipa(NULL, "vkCreateInstance");
    if ((r = create(&info, NULL, &instance)) != VK_SUCCESS) { printf("FAIL vkCreateInstance %d\n", (int)r); return 1; }
    enumerate = (PFN_vkEnumeratePhysicalDevices)(void *)gipa(instance, "vkEnumeratePhysicalDevices");
    props = (PFN_vkGetPhysicalDeviceProperties)(void *)gipa(instance, "vkGetPhysicalDeviceProperties");
    r = enumerate(instance, &count, devices);
    if ((r != VK_SUCCESS && r != 5 /* VK_INCOMPLETE */) || !count) { printf("FAIL vkEnumeratePhysicalDevices %d count=%u\n", (int)r, count); return 1; }
    for (i = 0; i < count; i++)
    {
        props(devices[i], &p);
        printf("device %u: %s (Vulkan %u.%u.%u)\n", i, p.deviceName,
               p.apiVersion >> 22, (p.apiVersion >> 12) & 0x3ff, p.apiVersion & 0xfff);
    }
    printf("OK\n");
    return 0;
}
