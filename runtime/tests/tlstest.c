/*
 * tlstest.c — teste de fumaça do TLS (WinHTTP -> schannel -> GnuTLS).
 *
 * Exercita a cadeia que instaladores usam para baixar arquivos: secur32/
 * schannel com GnuTLS e a validação do certificado pelas raízes do sistema
 * (crypt32 lê as do macOS). Os dois sentidos importam: um certificado válido
 * tem de ser aceito e um inválido, recusado — senão a validação poderia estar
 * simplesmente desligada.
 *
 * Uso: tlstest.exe [--reject] host caminho
 *   sem --reject: GET https://host/caminho tem de responder 200
 *   com --reject: o GET tem de falhar com a validação normal e funcionar com
 *                 SECURITY_FLAG_IGNORE_*; assim a falha é comprovadamente do
 *                 certificado, não do handshake (o Wine devolve o mesmo
 *                 ERROR_WINHTTP_SECURE_CHANNEL_ERROR para os dois casos)
 */
#define WIN32_LEAN_AND_MEAN
#include <windows.h>
#include <winhttp.h>
#include <stdio.h>

/* GET https://host/path; devolve 0 e o status HTTP, ou o erro do WinHTTP. */
static DWORD get(const WCHAR *host, const WCHAR *path, DWORD security_flags, DWORD *status)
{
    HINTERNET session = NULL, conn = NULL, req = NULL;
    DWORD size = sizeof(*status), err = 0;

    *status = 0;
    if (!(session = WinHttpOpen(L"CrossThrough-tlstest/1.0", WINHTTP_ACCESS_TYPE_DEFAULT_PROXY,
                                WINHTTP_NO_PROXY_NAME, WINHTTP_NO_PROXY_BYPASS, 0))
        || !(conn = WinHttpConnect(session, host, INTERNET_DEFAULT_HTTPS_PORT, 0))
        || !(req = WinHttpOpenRequest(conn, L"GET", path, NULL, WINHTTP_NO_REFERER,
                                      WINHTTP_DEFAULT_ACCEPT_TYPES, WINHTTP_FLAG_SECURE))
        || (security_flags && !WinHttpSetOption(req, WINHTTP_OPTION_SECURITY_FLAGS,
                                                &security_flags, sizeof(security_flags)))
        || !WinHttpSendRequest(req, WINHTTP_NO_ADDITIONAL_HEADERS, 0, WINHTTP_NO_REQUEST_DATA, 0, 0, 0)
        || !WinHttpReceiveResponse(req, NULL)
        || !WinHttpQueryHeaders(req, WINHTTP_QUERY_STATUS_CODE | WINHTTP_QUERY_FLAG_NUMBER,
                                WINHTTP_HEADER_NAME_BY_INDEX, status, &size, WINHTTP_NO_HEADER_INDEX))
        err = GetLastError();
    if (req) WinHttpCloseHandle(req);
    if (conn) WinHttpCloseHandle(conn);
    if (session) WinHttpCloseHandle(session);
    return err;
}

int wmain(int argc, WCHAR **argv)
{
    const DWORD ignore = SECURITY_FLAG_IGNORE_UNKNOWN_CA | SECURITY_FLAG_IGNORE_CERT_DATE_INVALID
                       | SECURITY_FLAG_IGNORE_CERT_CN_INVALID | SECURITY_FLAG_IGNORE_CERT_WRONG_USAGE;
    BOOL reject = argc > 1 && !lstrcmpW(argv[1], L"--reject");
    const WCHAR *host, *path;
    DWORD status, err;

    if (argc != (reject ? 4 : 3))
    {
        printf("uso: tlstest.exe [--reject] host caminho\n");
        return 2;
    }
    host = argv[reject ? 2 : 1];
    path = argv[reject ? 3 : 2];

    if (!reject)
    {
        if ((err = get(host, path, 0, &status))) { printf("FAIL erro %lu\n", err); return 1; }
        printf("https://%ls%ls -> %lu\n", host, path, status);
        if (status != 200) { printf("FAIL status\n"); return 1; }
        printf("OK\n");
        return 0;
    }

    if (!(err = get(host, path, 0, &status)))
    {
        printf("FAIL https://%ls%ls aceitou um certificado inválido (status %lu)\n", host, path, status);
        return 1;
    }
    printf("https://%ls%ls -> recusado (erro %lu)\n", host, path, err);
    if ((err = get(host, path, ignore, &status)))
    {
        printf("FAIL nem ignorando a validação conectou (erro %lu): a falha não é do certificado\n", err);
        return 1;
    }
    printf("ignorando a validação -> %lu\nOK\n", status);
    return 0;
}
