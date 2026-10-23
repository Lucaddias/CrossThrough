/*
 * ctlaunch.exe — abre um programa numa bottle e acompanha a árvore de
 * processos dele até o último fechar.
 *
 * Launchers (o EALauncher do EA app, por exemplo) abrem o programa de verdade
 * e saem na hora. Quem acompanha só o processo que abriu acha que o programa
 * fechou. O ctlaunch acompanha também os filhos, os netos e assim por diante,
 * inclusive depois que o pai sai. No lado do macOS isso não dá para saber,
 * porque o Wine solta cada processo (o pai Unix de todos vira o launchd).
 *
 *   ctlaunch.exe run <id> <diretório> <aplicação> <linha de comando>
 *       CreateProcess da aplicação (caminho do Windows) com a linha de comando
 *       exata, no diretório (vazio: o atual). A aplicação vazia deixa o
 *       Windows tirá-la da linha de comando.
 *   ctlaunch.exe shell <id> <diretório> <arquivo> [parâmetros]
 *       ShellExecuteEx: atalhos .lnk (inclusive os do Windows Installer, que
 *       não têm caminho), documentos e o que mais o Windows souber abrir.
 *   ctlaunch.exe stop <id>
 *       encerra a árvore aberta por "run" ou "shell" com o mesmo <id>.
 *
 * Como a árvore é achada: o ctlaunch entra num job object antes de abrir o
 * programa, e todo processo que nasce dele herda o job, por mais rápido que
 * saia (um "cmd /c start" no meio do caminho, por exemplo); o job avisa cada
 * entrada pela porta de conclusão. Quem pede para sair do job
 * (CREATE_BREAKAWAY_FROM_JOB) pode sair, para nenhum programa falhar por
 * isso, e é achado pelo PID do pai que o Windows guarda (lista do Toolhelp,
 * a cada segundo).
 *
 * Sai quando não sobra nenhum processo da árvore. O código de saída é o do
 * último processo a fechar (o do programa, quando ele é o único); depois de
 * um "stop", é 0. Se o programa não abre, a explicação vai para a saída de
 * erro e o código é 127.
 *
 * Os processos de fundo do Wine (explorer.exe, conhost.exe...) não contam: o
 * primeiro programa com janela numa bottle inicia o explorer da área de
 * trabalho, mas ele é da bottle, não do programa.
 *
 * Compilado pelo runtime/scripts/helpers.sh (mingw-w64, x86_64). Um processo
 * de 64 bits abre e enxerga os de 32 bits também.
 */
#define WIN32_LEAN_AND_MEAN
#include <windows.h>
#include <shellapi.h>
#include <objbase.h>
#include <tlhelp32.h>
#include <stdarg.h>
#include <stdio.h>
#include <stdlib.h>
#include <wchar.h>

#define EXIT_NOT_OPENED 127
#define MAX_TRACKED 4096
/* Por quantas varreduras um processo que saiu ainda conta como pai: um filho
 * que saiu do job logo antes de o pai fechar aparece na varredura seguinte. */
#define PARENT_GRACE 2
#define SCAN_INTERVAL 1000
/* Chaves dos pacotes da porta de conclusão. */
#define KEY_JOB 1
#define KEY_STOP 2

typedef struct {
    DWORD pid;
    HANDLE handle;   /* NULL depois que o processo saiu */
    int dead_rounds; /* varreduras desde que saiu */
    BOOL named;      /* o nome já foi conferido (ver classify) */
} tracked_t;

static tracked_t tracked[MAX_TRACKED];
static int ntracked;
static DWORD self_pid;
static DWORD root_pid;
static DWORD last_exit;
static HANDLE port;

static const wchar_t *background[] = {
    L"services.exe", L"winedevice.exe", L"plugplay.exe", L"svchost.exe", L"rpcss.exe",
    L"explorer.exe", L"conhost.exe", L"wineboot.exe", L"winemenubuilder.exe", NULL,
};

/* Mensagem em UTF-8 na saída de erro (o log do app). O fwprintf converteria
 * para a página de código do Windows, e os acentos sairiam trocados. */
static void say(const wchar_t *format, ...)
{
    wchar_t text[1024];
    char utf8[4096];
    va_list args;
    DWORD written;
    int n;

    va_start(args, format);
    vswprintf(text, ARRAYSIZE(text), format, args);
    va_end(args);
    n = WideCharToMultiByte(CP_UTF8, 0, text, -1, utf8, sizeof(utf8), NULL, NULL);
    if (n > 1) WriteFile(GetStdHandle(STD_ERROR_HANDLE), utf8, n - 1, &written, NULL);
}

static BOOL is_background(const wchar_t *name)
{
    for (int i = 0; background[i]; i++)
        if (!_wcsicmp(name, background[i])) return TRUE;
    return FALSE;
}

static tracked_t *find(DWORD pid)
{
    for (int i = 0; i < ntracked; i++)
        if (tracked[i].pid == pid) return &tracked[i];
    return NULL;
}

static BOOL is_alive_entry(DWORD pid)
{
    tracked_t *t = find(pid);
    return t && t->handle;
}

static BOOL is_known_parent(DWORD pid)
{
    tracked_t *t;
    if (pid == self_pid) return TRUE;
    t = find(pid);
    return t && t->dead_rounds <= PARENT_GRACE;
}

static void add(DWORD pid, HANDLE handle)
{
    tracked_t *t = find(pid);
    if (t && t->handle) { CloseHandle(handle); return; }
    if (!t)
    {
        if (ntracked == MAX_TRACKED) { CloseHandle(handle); return; }
        t = &tracked[ntracked++];
    }
    /* Um registro de processo que já saiu é reaproveitado: o PID foi reusado. */
    t->pid = pid;
    t->handle = handle;
    t->dead_rounds = 0;
    t->named = FALSE;
}

static HANDLE open_tracked(DWORD pid)
{
    return OpenProcess(SYNCHRONIZE | PROCESS_TERMINATE | PROCESS_QUERY_LIMITED_INFORMATION, FALSE, pid);
}

/* Um processo que entrou no job. */
static void add_from_job(DWORD pid)
{
    HANDLE handle;
    if (pid == self_pid || is_alive_entry(pid)) return;
    if ((handle = open_tracked(pid))) add(pid, handle); /* sem handle: já saiu */
}

/* Tira da árvore os processos de fundo. O nome de um processo só existe
 * depois que ele carrega o executável, e o aviso do job chega antes disso:
 * quem ainda não tem nome conta como aberto e é conferido na volta seguinte.
 * O programa aberto pelo ctlaunch nunca sai, mesmo que seja um explorer.exe. */
static void classify(void)
{
    int i = 0;
    while (i < ntracked)
    {
        tracked_t *t = &tracked[i];
        wchar_t path[MAX_PATH];
        DWORD size = ARRAYSIZE(path);
        const wchar_t *name;

        if (t->named || !t->handle || !QueryFullProcessImageNameW(t->handle, 0, path, &size)) { i++; continue; }
        t->named = TRUE;
        name = wcsrchr(path, L'\\');
        if (t->pid != root_pid && is_background(name ? name + 1 : path))
        {
            CloseHandle(t->handle);
            tracked[i] = tracked[--ntracked];
            continue;
        }
        i++;
    }
}

/* Acrescenta os processos cujo pai é da árvore: os que saíram do job. */
static void scan(void)
{
    PROCESSENTRY32W entry = { 0 };
    HANDLE snapshot = CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
    BOOL ok;

    if (snapshot == INVALID_HANDLE_VALUE) return;
    entry.dwSize = sizeof(entry);
    for (ok = Process32FirstW(snapshot, &entry); ok; ok = Process32NextW(snapshot, &entry))
    {
        HANDLE handle;
        if (entry.th32ProcessID == self_pid || is_alive_entry(entry.th32ProcessID)) continue;
        if (!is_known_parent(entry.th32ParentProcessID) || is_background(entry.szExeFile)) continue;
        if ((handle = open_tracked(entry.th32ProcessID))) add(entry.th32ProcessID, handle);
    }
    CloseHandle(snapshot);
}

/* Marca os que saíram, guardando o código, e esquece (se `scanned`) os que
 * saíram há mais de PARENT_GRACE varreduras. Devolve quantos seguem abertos. */
static int reap(BOOL scanned)
{
    int alive = 0, i = 0;
    BOOL root_exited = FALSE;
    DWORD root_code = 0;

    while (i < ntracked)
    {
        tracked_t *t = &tracked[i];
        if (t->handle && WaitForSingleObject(t->handle, 0) == WAIT_OBJECT_0)
        {
            DWORD code = 0;
            GetExitCodeProcess(t->handle, &code);
            last_exit = code;
            if (t->pid == root_pid) { root_exited = TRUE; root_code = code; }
            CloseHandle(t->handle);
            t->handle = NULL;
        }
        if (t->handle) { alive++; i++; continue; }
        if (scanned && ++t->dead_rounds > PARENT_GRACE) { tracked[i] = tracked[--ntracked]; continue; }
        i++;
    }
    /* Se o programa e outros saíram juntos, vale o código do programa. */
    if (root_exited) last_exit = root_code;
    return alive;
}

/* Trata os pacotes da porta, esperando até `timeout` pelo primeiro. Devolve
 * TRUE se um deles é o "stop". */
static BOOL drain(DWORD timeout)
{
    DWORD message;
    ULONG_PTR key;
    LPOVERLAPPED data;

    while (GetQueuedCompletionStatus(port, &message, &key, &data, timeout))
    {
        if (key == KEY_STOP) return TRUE;
        if (key == KEY_JOB && message == JOB_OBJECT_MSG_NEW_PROCESS) add_from_job((DWORD)(ULONG_PTR)data);
        timeout = 0;
    }
    return FALSE;
}

/* Encerra a árvore. Quem acabou de nascer e ainda não tem nome espera a
 * volta seguinte: pode ser o explorer da bottle, que não é para fechar. */
static void terminate_tree(void)
{
    for (int round = 0; round < 20; round++)
    {
        int killed = 0, pending = 0;
        drain(0);
        scan();
        classify();
        for (int i = 0; i < ntracked; i++)
        {
            if (!tracked[i].handle) continue;
            if (!tracked[i].named) { pending++; continue; }
            TerminateProcess(tracked[i].handle, 1);
            killed++;
        }
        for (int i = 0; i < ntracked; i++)
            if (tracked[i].handle && tracked[i].named) WaitForSingleObject(tracked[i].handle, 2000);
        reap(FALSE);
        if (!killed && !pending) break;
        if (!killed) Sleep(100);
    }
}

/* Acompanha a árvore. Devolve TRUE se terminou pelo "stop". */
static BOOL track(void)
{
    DWORD last_scan = GetTickCount() - SCAN_INTERVAL;
    for (;;)
    {
        BOOL scanned = FALSE;
        if (drain(0)) break;
        if (GetTickCount() - last_scan >= SCAN_INTERVAL)
        {
            scan();
            last_scan = GetTickCount();
            scanned = TRUE;
        }
        classify();
        if (reap(scanned) == 0) return FALSE;
        /* Acorda com o próximo aviso do job (um processo que entra ou sai) ou
         * na hora da próxima varredura. */
        if (drain(SCAN_INTERVAL)) break;
    }
    terminate_tree();
    return TRUE;
}

/* O job em que o ctlaunch entra, ligado à porta. Sem ele (se o Windows não
 * deixar), a árvore é achada só pelas varreduras. */
static void join_job(void)
{
    JOBOBJECT_EXTENDED_LIMIT_INFORMATION limits = { 0 };
    JOBOBJECT_ASSOCIATE_COMPLETION_PORT association = { 0 };
    HANDLE job = CreateJobObjectW(NULL, NULL);

    if (!job) return;
    limits.BasicLimitInformation.LimitFlags = JOB_OBJECT_LIMIT_BREAKAWAY_OK;
    association.CompletionKey = (PVOID)KEY_JOB;
    association.CompletionPort = port;
    if (!SetInformationJobObject(job, JobObjectExtendedLimitInformation, &limits, sizeof(limits))
        || !SetInformationJobObject(job, JobObjectAssociateCompletionPortInformation,
                                    &association, sizeof(association))
        || !AssignProcessToJobObject(job, GetCurrentProcess()))
    {
        say(L"ctlaunch: sem job object (erro %lu); acompanhando só pelas varreduras\n", GetLastError());
        CloseHandle(job);
    }
}

static DWORD WINAPI wait_for_stop(void *event)
{
    WaitForSingleObject(event, INFINITE);
    PostQueuedCompletionStatus(port, 0, KEY_STOP, NULL);
    return 0;
}

static BOOL valid_id(const wchar_t *id)
{
    size_t n = wcslen(id);
    if (n == 0 || n > 64) return FALSE;
    for (size_t i = 0; i < n; i++)
        if (!iswalnum(id[i]) && id[i] != L'-') return FALSE;
    return TRUE;
}

static void event_name(wchar_t *buffer, size_t size, const wchar_t *id)
{
    swprintf(buffer, size, L"Local\\CrossThroughStop-%ls", id);
}

static int usage(void)
{
    say(L"uso: ctlaunch.exe run <id> <diretório> <aplicação> <linha de comando>\n"
        L"     ctlaunch.exe shell <id> <diretório> <arquivo> [parâmetros]\n"
        L"     ctlaunch.exe stop <id>\n");
    return 2;
}

static int stop_command(const wchar_t *id)
{
    wchar_t name[128];
    HANDLE event;
    event_name(name, ARRAYSIZE(name), id);
    event = OpenEventW(EVENT_MODIFY_STATE, FALSE, name);
    if (!event) return 1; /* já fechou */
    SetEvent(event);
    CloseHandle(event);
    return 0;
}

static const wchar_t *or_null(const wchar_t *s)
{
    return s && *s ? s : NULL;
}

/* Os filhos escrevem na mesma saída do ctlaunch (o log do app). */
static void inherit_std_handles(STARTUPINFOW *si)
{
    DWORD which[3] = { STD_INPUT_HANDLE, STD_OUTPUT_HANDLE, STD_ERROR_HANDLE };
    HANDLE *field[3] = { &si->hStdInput, &si->hStdOutput, &si->hStdError };
    for (int i = 0; i < 3; i++)
    {
        HANDLE h = GetStdHandle(which[i]);
        if (h && h != INVALID_HANDLE_VALUE) SetHandleInformation(h, HANDLE_FLAG_INHERIT, HANDLE_FLAG_INHERIT);
        *field[i] = h;
    }
    si->dwFlags |= STARTF_USESTDHANDLES;
}

static BOOL open_run(const wchar_t *dir, const wchar_t *application, const wchar_t *command_line)
{
    STARTUPINFOW si = { 0 };
    PROCESS_INFORMATION pi;
    wchar_t *line = _wcsdup(command_line);

    si.cb = sizeof(si);
    inherit_std_handles(&si);
    if (!CreateProcessW(or_null(application), line, NULL, NULL, TRUE, 0, NULL, or_null(dir), &si, &pi))
    {
        say(L"ctlaunch: não foi possível abrir %ls (erro %lu)\n",
            *application ? application : command_line, GetLastError());
        free(line);
        return FALSE;
    }
    free(line);
    CloseHandle(pi.hThread);
    root_pid = pi.dwProcessId;
    add(pi.dwProcessId, pi.hProcess);
    return TRUE;
}

static BOOL open_shell(const wchar_t *dir, const wchar_t *file, const wchar_t *parameters)
{
    SHELLEXECUTEINFOW sei = { 0 };

    sei.cbSize = sizeof(sei);
    CoInitializeEx(NULL, COINIT_APARTMENTTHREADED | COINIT_DISABLE_OLE1DDE);
    sei.fMask = SEE_MASK_NOCLOSEPROCESS | SEE_MASK_FLAG_NO_UI | SEE_MASK_NOASYNC;
    sei.lpFile = file;
    sei.lpParameters = or_null(parameters);
    sei.lpDirectory = or_null(dir);
    sei.nShow = SW_SHOWNORMAL;
    if (!ShellExecuteExW(&sei))
    {
        say(L"ctlaunch: não foi possível abrir %ls (erro %lu)\n", file, GetLastError());
        return FALSE;
    }
    if (sei.hProcess)
    {
        root_pid = GetProcessId(sei.hProcess);
        add(root_pid, sei.hProcess);
    }
    return TRUE;
}

int wmain(int argc, wchar_t **argv)
{
    wchar_t name[128];
    HANDLE stop;
    BOOL opened;

    if (argc < 3 || !valid_id(argv[2])) return usage();
    if (!wcscmp(argv[1], L"stop")) return stop_command(argv[2]);
    if (!(!wcscmp(argv[1], L"run") && argc == 6) && !(!wcscmp(argv[1], L"shell") && (argc == 5 || argc == 6)))
        return usage();

    self_pid = GetCurrentProcessId();
    event_name(name, ARRAYSIZE(name), argv[2]);
    stop = CreateEventW(NULL, TRUE, FALSE, name);
    if (!stop || GetLastError() == ERROR_ALREADY_EXISTS)
    {
        say(L"ctlaunch: o id %ls já está em uso\n", argv[2]);
        return EXIT_NOT_OPENED;
    }
    if (!(port = CreateIoCompletionPort(INVALID_HANDLE_VALUE, NULL, 0, 1)))
    {
        say(L"ctlaunch: sem porta de conclusão (erro %lu)\n", GetLastError());
        return EXIT_NOT_OPENED;
    }
    CloseHandle(CreateThread(NULL, 0, wait_for_stop, stop, 0, NULL));
    join_job();

    if (!wcscmp(argv[1], L"run")) opened = open_run(argv[3], argv[4], argv[5]);
    else opened = open_shell(argv[3], argv[4], argc == 6 ? argv[5] : NULL);
    if (!opened) return EXIT_NOT_OPENED;

    return track() ? 0 : (int)last_exit;
}
