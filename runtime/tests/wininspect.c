/*
 * wininspect.c — confere que um programa da bottle abriu e montou a interface.
 *
 * Roda na mesma bottle que o programa e lê a janela dele de fora: título,
 * tamanho, menu e os controles filhos, com o conteúdo de listas, árvores e
 * barras de ferramentas. Funciona sem permissão de gravação de tela no macOS.
 * (Capturar os pixels não dá: o PrintWindow do Wine manda um WM_PRINT com um
 * HDC, que só vale dentro do processo que o criou.)
 *
 * Uso: wininspect.exe <parte do título>
 *   Espera até 30 s por uma janela visível de nível superior com o texto no
 *   título. Termina com OK se ela tiver tamanho e pelo menos um controle
 *   visível.
 */
#define WIN32_LEAN_AND_MEAN
#include <windows.h>
#include <commctrl.h>
#include <stdio.h>

struct search { const WCHAR *needle; HWND found; };

static BOOL CALLBACK find_window(HWND hwnd, LPARAM lparam)
{
    struct search *s = (struct search *)lparam;
    WCHAR title[256];
    if (!IsWindowVisible(hwnd) || !GetWindowTextW(hwnd, title, ARRAYSIZE(title))) return TRUE;
    if (!wcsstr(title, s->needle)) return TRUE;
    s->found = hwnd;
    return FALSE;
}

static int visible_controls;

static BOOL CALLBACK show_child(HWND hwnd, LPARAM depth)
{
    WCHAR cls[64], text[128];
    LRESULT items = -1;
    RECT rc;

    if (!IsWindowVisible(hwnd)) return TRUE;
    GetClassNameW(hwnd, cls, ARRAYSIZE(cls));
    text[0] = 0;
    /* WM_GETTEXT entre processos: o Wine copia o texto de volta. */
    SendMessageTimeoutW(hwnd, WM_GETTEXT, ARRAYSIZE(text), (LPARAM)text, SMTO_ABORTIFHUNG, 2000, NULL);
    GetWindowRect(hwnd, &rc);
    if (!wcscmp(cls, WC_LISTVIEWW))
        SendMessageTimeoutW(hwnd, LVM_GETITEMCOUNT, 0, 0, SMTO_ABORTIFHUNG, 2000, (DWORD_PTR *)&items);
    else if (!wcscmp(cls, WC_TREEVIEWW))
        SendMessageTimeoutW(hwnd, TVM_GETCOUNT, 0, 0, SMTO_ABORTIFHUNG, 2000, (DWORD_PTR *)&items);
    else if (!wcscmp(cls, TOOLBARCLASSNAMEW))
        SendMessageTimeoutW(hwnd, TB_BUTTONCOUNT, 0, 0, SMTO_ABORTIFHUNG, 2000, (DWORD_PTR *)&items);
    else if (!wcscmp(cls, WC_COMBOBOXW) || !wcscmp(cls, WC_COMBOBOXEXW))
        SendMessageTimeoutW(hwnd, CB_GETCOUNT, 0, 0, SMTO_ABORTIFHUNG, 2000, (DWORD_PTR *)&items);

    printf("%*s%ls \"%ls\" %ldx%ld", (int)depth * 2, "", cls, text, rc.right - rc.left, rc.bottom - rc.top);
    if (items >= 0) printf(" itens=%ld", (long)items);
    printf("\n");
    if (rc.right > rc.left && rc.bottom > rc.top) visible_controls++;
    return TRUE;
}

int wmain(int argc, WCHAR **argv)
{
    struct search s = {0};
    WCHAR title[256];
    HMENU menu;
    RECT rc;
    int waited, i, count;

    if (argc != 2) { printf("uso: wininspect.exe <parte do título>\n"); return 2; }
    s.needle = argv[1];
    for (waited = 0; waited < 300 && !s.found; waited++)
    {
        EnumWindows(find_window, (LPARAM)&s);
        if (!s.found) Sleep(100);
    }
    if (!s.found) { printf("FAIL nenhuma janela com \"%ls\" no título\n", s.needle); return 1; }
    Sleep(1000); /* deixa o programa terminar de montar a janela */

    GetWindowTextW(s.found, title, ARRAYSIZE(title));
    GetWindowRect(s.found, &rc);
    printf("janela: \"%ls\" %ldx%ld\n", title, rc.right - rc.left, rc.bottom - rc.top);
    if ((menu = GetMenu(s.found)) && (count = GetMenuItemCount(menu)) > 0)
    {
        printf("menu:");
        for (i = 0; i < count; i++)
        {
            WCHAR item[64];
            if (GetMenuStringW(menu, i, item, ARRAYSIZE(item), MF_BYPOSITION)) printf(" [%ls]", item);
        }
        printf("\n");
    }
    /* EnumChildWindows já percorre todos os descendentes. */
    EnumChildWindows(s.found, show_child, 1);

    if (rc.right <= rc.left || rc.bottom <= rc.top) { printf("FAIL janela sem tamanho\n"); return 1; }
    if (!visible_controls) { printf("FAIL a janela não tem nenhum controle visível\n"); return 1; }
    printf("OK %d controles visíveis\n", visible_controls);
    return 0;
}
