/*
 * htmltest.c — teste de fumaça do motor HTML (mshtml -> Wine Gecko).
 *
 * Carrega um HTML num HTMLDocument, espera o readyState "complete" e lê o
 * texto do <body>. Só o Gecko faz o parse, então o texto certo prova que o
 * mshtml achou o Gecko do runtime (share/wine/gecko) sem baixar nada.
 * Instaladores e lançadores que mostram páginas embutidas dependem disso.
 */
#define COBJMACROS
#define WIN32_LEAN_AND_MEAN
#include <windows.h>
#include <ole2.h>
#include <mshtml.h>
#include <stdio.h>

/* A libuuid do mingw-w64 não exporta este. */
static const CLSID clsid_htmldocument =
    {0x25336920, 0x03f9, 0x11cf, {0x8f, 0xd0, 0x00, 0xaa, 0x00, 0x68, 0x6f, 0x13}};

static int fail(const char *step, HRESULT hr)
{
    printf("FAIL %s hr=0x%08lx\n", step, (unsigned long)hr);
    fflush(stdout);
    return 1;
}

int main(void)
{
    static const char html[] = "<html><body><p>gecko <b>ok</b></p></body></html>";
    IHTMLDocument2 *doc;
    IPersistStreamInit *init;
    IHTMLElement *body = NULL;
    IStream *stream;
    HGLOBAL mem;
    BSTR state = NULL, text = NULL;
    DWORD start;
    HRESULT hr;
    BOOL complete = FALSE;

    CoInitialize(NULL);
    hr = CoCreateInstance(&clsid_htmldocument, NULL, CLSCTX_INPROC_SERVER | CLSCTX_INPROC_HANDLER,
                          &IID_IHTMLDocument2, (void **)&doc);
    if (FAILED(hr)) return fail("CoCreateInstance(HTMLDocument)", hr);

    mem = GlobalAlloc(0, sizeof(html) - 1);
    memcpy(mem, html, sizeof(html) - 1);
    hr = CreateStreamOnHGlobal(mem, TRUE, &stream);
    if (FAILED(hr)) return fail("CreateStreamOnHGlobal", hr);
    hr = IHTMLDocument2_QueryInterface(doc, &IID_IPersistStreamInit, (void **)&init);
    if (FAILED(hr)) return fail("QueryInterface(IPersistStreamInit)", hr);
    hr = IPersistStreamInit_Load(init, stream);
    IPersistStreamInit_Release(init);
    IStream_Release(stream);
    if (FAILED(hr)) return fail("IPersistStreamInit::Load", hr);

    /* O parse é assíncrono: roda o laço de mensagens até o documento terminar. */
    for (start = GetTickCount(); GetTickCount() - start < 30000;)
    {
        MSG msg;
        while (PeekMessageW(&msg, NULL, 0, 0, PM_REMOVE)) DispatchMessageW(&msg);
        if (SUCCEEDED(IHTMLDocument2_get_readyState(doc, &state)) && state)
        {
            complete = !lstrcmpW(state, L"complete");
            SysFreeString(state);
            if (complete) break;
        }
        Sleep(10);
    }
    if (!complete) return fail("readyState complete", E_FAIL);

    hr = IHTMLDocument2_get_body(doc, &body);
    if (FAILED(hr) || !body) return fail("get_body", hr);
    hr = IHTMLElement_get_innerText(body, &text);
    if (FAILED(hr) || !text) return fail("get_innerText", hr);
    printf("innerText: %ls\n", text);
    if (lstrcmpW(text, L"gecko ok")) return fail("texto", E_FAIL);

    SysFreeString(text);
    IHTMLElement_Release(body);
    IHTMLDocument2_Release(doc);
    CoUninitialize();
    printf("OK\n");
    return 0;
}
