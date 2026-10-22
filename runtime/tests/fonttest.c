/*
 * fonttest.c — teste de fumaça das fontes (win32u -> FreeType).
 *
 * Seleciona a Tahoma (que o Wine traz em share/wine/fonts), exige métricas de
 * contorno — que só existem para fontes escaláveis, ou seja, carregadas pelo
 * FreeType — e desenha texto num DC de memória, contando os pixels pintados.
 * Sem o libfreetype do runtime, o Wine fica sem fontes TrueType e isto falha.
 */
#define WIN32_LEAN_AND_MEAN
#include <windows.h>
#include <stdio.h>

static int fail(const char *step)
{
    printf("FAIL %s (erro %lu)\n", step, GetLastError());
    fflush(stdout);
    return 1;
}

int main(void)
{
    enum { W = 200, H = 40 };
    BITMAPINFO bi = {{ sizeof(BITMAPINFOHEADER), W, -H, 1, 32, BI_RGB }};
    OUTLINETEXTMETRICW otm;
    WCHAR face[LF_FACESIZE];
    unsigned int *bits;
    HBITMAP bmp;
    HFONT font;
    HDC dc;
    int i, painted = 0;

    dc = CreateCompatibleDC(NULL);
    bmp = CreateDIBSection(dc, &bi, DIB_RGB_COLORS, (void **)&bits, NULL, 0);
    if (!dc || !bmp) return fail("DC/DIB");
    SelectObject(dc, bmp);
    font = CreateFontW(-24, 0, 0, 0, FW_NORMAL, FALSE, FALSE, FALSE, DEFAULT_CHARSET,
                       OUT_TT_ONLY_PRECIS, CLIP_DEFAULT_PRECIS, ANTIALIASED_QUALITY,
                       DEFAULT_PITCH, L"Tahoma");
    if (!font) return fail("CreateFont");
    SelectObject(dc, font);

    GetTextFaceW(dc, LF_FACESIZE, face);
    printf("fonte: %ls\n", face);
    otm.otmSize = sizeof(otm);
    if (!GetOutlineTextMetricsW(dc, sizeof(otm), &otm)) return fail("GetOutlineTextMetrics");
    printf("em: %u unidades, ascent %d\n", otm.otmEMSquare, otm.otmAscent);

    for (i = 0; i < W * H; i++) bits[i] = 0x00ffffff;
    SetTextColor(dc, RGB(0, 0, 0));
    SetBkMode(dc, TRANSPARENT);
    if (!TextOutW(dc, 4, 4, L"CrossThrough", 12)) return fail("TextOut");
    GdiFlush();
    for (i = 0; i < W * H; i++) painted += (bits[i] & 0x00ffffff) != 0x00ffffff;
    printf("pixels pintados: %d\n", painted);

    if (lstrcmpiW(face, L"Tahoma")) { printf("FAIL fonte errada\n"); return 1; }
    if (painted < 100) { printf("FAIL texto não foi desenhado\n"); return 1; }
    printf("OK\n");
    return 0;
}
