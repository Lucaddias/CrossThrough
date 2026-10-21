/*
 * cxbounce.c — reconstrução compilável do bin/cxbounce do CrossOver 26.3.
 *
 * Alvo: Contents/SharedSupport/CrossOver/CrossOver-Hosted Application/cxbounce
 *   Mach-O 64-bit executable x86_64
 *   SHA-256 dab9f75ad6ff62d7947084de4d6818eb45cab2f2f4ac230d69ba4459855f500d
 *
 * Antes a arquitetura (ARCHITECTURE.md §3.3) descrevia o cxbounce só por
 * inferência a partir dos imports. Esta reconstrução vem do disassembly do
 * __text (uma única função _main), então o comportamento agora é lido, não
 * inferido. Imports usados: strlen, malloc, dirname, sprintf, printf, setuid,
 * execv. Strings: "%s/%s", "arg0: %s\n", "Out of memory!".
 *
 * O cxbounce é o caminho de privilégio das bottles gerenciadas: a GUI o roda
 * via AuthorizationExecuteWithPrivileges (BottleMenuHandler, PublishController,
 * UpdateController), e ele faz setuid(0) e executa o script irmão no mesmo
 * diretório bin/, para a ferramenta rodar com UID real 0.
 *
 * Uso: cxbounce <ferramenta> [args...]
 *   argv[0] = caminho do próprio cxbounce
 *   argv[1] = nome da ferramenta irmã (ex.: "cxbottle", "wine")
 *   argv[2..] = argumentos da ferramenta
 *
 * Observação fiel ao binário: ele monta o caminho em dirname(argv[0]) e
 * escreve esse caminho em argv[0], mas passa &argv[1] como vetor de argumentos
 * para o execv. Ou seja, o processo filho recebe argv = { argv[1], argv[2], … }:
 * o nome da ferramenta vira o argv[0] do filho. A escrita em argv[0] não entra
 * no vetor passado ao execv (que começa em &argv[1]); fica reproduzida aqui tal
 * como no original.
 *
 * Correspondência com o disassembly (__text, _main @ 0x100000e50):
 *   r15 = argv[0]; rax = strlen(argv[0]); rbx = malloc(rax + 0x100)
 *   if (!rbx) { puts("Out of memory!"); return 1; }
 *   rax = dirname(argv[0]); sprintf(rbx, "%s/%s", rax, argv[1])
 *   argv[0] = rbx; printf("arg0: %s\n", rbx)
 *   setuid(0); execv(rbx, &argv[1])
 */

#include <libgen.h>   /* dirname */
#include <stdio.h>    /* sprintf, printf, puts */
#include <stdlib.h>   /* malloc */
#include <string.h>   /* strlen */
#include <unistd.h>   /* setuid, execv */

int main(int argc, char **argv)
{
    /* malloc(strlen(argv[0]) + 256): espaço para dirname + "/" + ferramenta. */
    char *path = (char *)malloc(strlen(argv[0]) + 0x100);
    if (path == NULL) {
        puts("Out of memory!");
        return 1;
    }

    /* path = "<dir de cxbounce>/<argv[1]>" */
    sprintf(path, "%s/%s", dirname(argv[0]), argv[1]);

    /* O original sobrescreve argv[0] com o caminho resolvido. */
    argv[0] = path;

    printf("arg0: %s\n", path);

    /* Vira UID real 0 (não só efetivo, como faria o AEWP sozinho). */
    setuid(0);

    /* Executa a ferramenta irmã; o filho recebe argv começando em argv[1]. */
    execv(path, &argv[1]);

    /* execv só retorna em erro. O binário original não trata esse retorno;
     * seguimos iguais e caímos no retorno implícito. */
    return 0;
}
