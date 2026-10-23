/*
 * launchtest.exe — uma árvore de processos como a de um launcher, para o
 * ctlaunch.exe acompanhar (smoke.sh e os testes de integração do app).
 *
 *   launchtest.exe launcher <n>  abre "cmd /c start" do filho e sai na hora,
 *                                com 0 (o cmd e o start também saem logo)
 *   launchtest.exe child <n>     abre o neto, espera 1 s e sai com 7
 *   launchtest.exe grandchild <n>  espera n segundos e sai com 5
 *   launchtest.exe exit <código>   sai na hora com o código
 *
 * Quem acompanha a árvore inteira termina depois de n segundos, com o código
 * do neto (5), que é o último a fechar.
 */
#include <windows.h>
#include <stdio.h>
#include <stdlib.h>
#include <wchar.h>

static int spawn(const wchar_t *format, const wchar_t *self, int n)
{
    wchar_t command[1024];
    STARTUPINFOW si = { 0 };
    PROCESS_INFORMATION pi;

    si.cb = sizeof(si);
    swprintf(command, ARRAYSIZE(command), format, self, n);
    if (!CreateProcessW(NULL, command, NULL, NULL, FALSE, 0, NULL, NULL, &si, &pi))
    {
        fwprintf(stderr, L"launchtest: CreateProcess falhou (%lu): %ls\n", GetLastError(), command);
        return 3;
    }
    CloseHandle(pi.hThread);
    CloseHandle(pi.hProcess);
    return 0;
}

int wmain(int argc, wchar_t **argv)
{
    wchar_t self[MAX_PATH];
    int n = argc > 2 ? _wtoi(argv[2]) : 3;

    GetModuleFileNameW(NULL, self, MAX_PATH);
    if (argc < 2) return 2;
    if (!wcscmp(argv[1], L"launcher"))
        return spawn(L"cmd.exe /c start \"\" \"%ls\" child %d", self, n);
    if (!wcscmp(argv[1], L"child"))
    {
        int rc = spawn(L"\"%ls\" grandchild %d", self, n);
        if (rc) return rc;
        Sleep(1000);
        return 7;
    }
    if (!wcscmp(argv[1], L"grandchild"))
    {
        Sleep(n * 1000);
        return 5;
    }
    if (!wcscmp(argv[1], L"exit")) return n;
    return 2;
}
