/*
 * d3d11test.c — teste de fumaça do caminho Direct3D 11 do runtime.
 *
 * Cria uma janela, um dispositivo D3D11 com swap chain, limpa o back buffer
 * com uma cor conhecida, lê o pixel de volta por uma textura de staging e
 * apresenta alguns quadros. Imprime o adaptador, o nível de recurso e qual
 * d3d11.dll foi carregada (Wine/wined3d, DXVK ou DXMT), para o script saber
 * que o backend pedido é o que de fato rodou.
 *
 * Saída: 0 se o pixel lido é a cor limpa; != 0 com a etapa que falhou.
 */
#define COBJMACROS
#define WIN32_LEAN_AND_MEAN
#include <windows.h>
#include <d3d11.h>
#include <dxgi.h>
#include <stdio.h>
#include <string.h>

static LRESULT CALLBACK wndproc(HWND hwnd, UINT msg, WPARAM wp, LPARAM lp)
{
    return DefWindowProcW(hwnd, msg, wp, lp);
}

static int fail(const char *step, HRESULT hr)
{
    printf("FAIL %s hr=0x%08lx\n", step, (unsigned long)hr);
    fflush(stdout);
    return 1;
}

int main(void)
{
    WNDCLASSW wc = {0};
    DXGI_SWAP_CHAIN_DESC sd = {0};
    D3D_FEATURE_LEVEL level;
    ID3D11Device *device = NULL;
    ID3D11DeviceContext *ctx = NULL;
    IDXGISwapChain *swap = NULL;
    ID3D11Texture2D *back = NULL, *staging = NULL;
    ID3D11RenderTargetView *rtv = NULL;
    IDXGIDevice *dxgi_device = NULL;
    IDXGIAdapter *adapter = NULL;
    DXGI_ADAPTER_DESC ad;
    D3D11_TEXTURE2D_DESC td;
    D3D11_MAPPED_SUBRESOURCE map;
    const float color[4] = {0.0f, 1.0f, 0.0f, 1.0f}; /* verde */
    WCHAR module_path[MAX_PATH];
    HMODULE d3d11;
    unsigned int pixel;
    HRESULT hr;
    HWND hwnd;
    int i;

    wc.lpfnWndProc = wndproc;
    wc.hInstance = GetModuleHandleW(NULL);
    wc.lpszClassName = L"d3d11test";
    RegisterClassW(&wc);
    hwnd = CreateWindowW(L"d3d11test", L"d3d11test", WS_OVERLAPPEDWINDOW | WS_VISIBLE,
                         100, 100, 256, 256, NULL, NULL, wc.hInstance, NULL);
    if (!hwnd) return fail("CreateWindow", HRESULT_FROM_WIN32(GetLastError()));

    sd.BufferCount = 2;
    sd.BufferDesc.Width = 256;
    sd.BufferDesc.Height = 256;
    sd.BufferDesc.Format = DXGI_FORMAT_R8G8B8A8_UNORM;
    sd.BufferUsage = DXGI_USAGE_RENDER_TARGET_OUTPUT;
    sd.OutputWindow = hwnd;
    sd.SampleDesc.Count = 1;
    sd.Windowed = TRUE;
    sd.SwapEffect = DXGI_SWAP_EFFECT_FLIP_DISCARD;

    hr = D3D11CreateDeviceAndSwapChain(NULL, D3D_DRIVER_TYPE_HARDWARE, NULL, 0, NULL, 0,
                                       D3D11_SDK_VERSION, &sd, &swap, &device, &level, &ctx);
    if (FAILED(hr)) return fail("D3D11CreateDeviceAndSwapChain", hr);

    d3d11 = GetModuleHandleW(L"d3d11.dll");
    GetModuleFileNameW(d3d11, module_path, MAX_PATH);
    printf("d3d11.dll: %ls\n", module_path);
    /* O caminho é o mesmo (system32) para todos; o que distingue o backend é
     * o que ele carregou: wined3d.dll (Wine), winemetal.dll (DXMT) ou o
     * Vulkan (DXVK). A marca "Wine builtin DLL" no cabeçalho em memória diz
     * se a d3d11.dll é a do próprio Wine. */
    printf("backend: %s\n",
           !memcmp((const char *)d3d11 + 0x40, "Wine builtin DLL", 16) && GetModuleHandleW(L"wined3d.dll") ? "wined3d"
           : GetModuleHandleW(L"winemetal.dll") ? "dxmt"
           : GetModuleHandleW(L"winevulkan.dll") || GetModuleHandleW(L"vulkan-1.dll") ? "dxvk"
           : "desconhecido");

    if (SUCCEEDED(ID3D11Device_QueryInterface(device, &IID_IDXGIDevice, (void **)&dxgi_device))
        && SUCCEEDED(IDXGIDevice_GetAdapter(dxgi_device, &adapter))
        && SUCCEEDED(IDXGIAdapter_GetDesc(adapter, &ad)))
        printf("adapter: %ls (vendor 0x%04x)\n", ad.Description, ad.VendorId);
    printf("feature level: 0x%x\n", (unsigned)level);

    hr = IDXGISwapChain_GetBuffer(swap, 0, &IID_ID3D11Texture2D, (void **)&back);
    if (FAILED(hr)) return fail("GetBuffer", hr);
    hr = ID3D11Device_CreateRenderTargetView(device, (ID3D11Resource *)back, NULL, &rtv);
    if (FAILED(hr)) return fail("CreateRenderTargetView", hr);

    ID3D11Texture2D_GetDesc(back, &td);
    td.Usage = D3D11_USAGE_STAGING;
    td.BindFlags = 0;
    td.CPUAccessFlags = D3D11_CPU_ACCESS_READ;
    td.MiscFlags = 0;
    hr = ID3D11Device_CreateTexture2D(device, &td, NULL, &staging);
    if (FAILED(hr)) return fail("CreateTexture2D(staging)", hr);

    ID3D11DeviceContext_ClearRenderTargetView(ctx, rtv, color);
    ID3D11DeviceContext_CopyResource(ctx, (ID3D11Resource *)staging, (ID3D11Resource *)back);
    hr = ID3D11DeviceContext_Map(ctx, (ID3D11Resource *)staging, 0, D3D11_MAP_READ, 0, &map);
    if (FAILED(hr)) return fail("Map", hr);
    pixel = *(const unsigned int *)map.pData;
    ID3D11DeviceContext_Unmap(ctx, (ID3D11Resource *)staging, 0);
    printf("pixel: 0x%08x\n", pixel);

    for (i = 0; i < 10; i++)
    {
        MSG msg;
        while (PeekMessageW(&msg, NULL, 0, 0, PM_REMOVE)) DispatchMessageW(&msg);
        ID3D11DeviceContext_ClearRenderTargetView(ctx, rtv, color);
        hr = IDXGISwapChain_Present(swap, 1, 0);
        if (FAILED(hr)) return fail("Present", hr);
    }

    /* R8G8B8A8: verde opaco = 0xff00ff00 em little-endian. */
    if (pixel != 0xff00ff00) return fail("pixel", E_FAIL);
    printf("OK\n");
    fflush(stdout);
    DestroyWindow(hwnd);
    return 0;
}
