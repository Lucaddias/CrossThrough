# Proveniência do backend (Fase 2 da independência)

Mapa de origem de cada componente do backend que hoje vem do app de referência
(`SharedSupport/CrossOver`), para a Fase 2: obter cada parte **do upstream, não
do host**. As versões abaixo foram lidas diretamente do app instalado (CrossOver
26.3); a evidência está na coluna "lido de".

## Oferta de fonte da CodeWeavers

O próprio `SharedSupport/CrossOver/license.txt` declara que o código-fonte de
todos os componentes open-source do CrossOver é publicado em:

> https://www.codeweavers.com/crossover/source

Esse tarball é o upstream **autoritativo e fiel** para Wine, DXVK, DXMT e as
bibliotecas LGPL/MIT — é o fonte exato a partir do qual este build foi gerado.
Preferir essa fonte à vanilla upstream quando a fidelidade importa.

## Componentes

| Componente | Versão | Licença | Lido de | Upstream | Como obter |
|---|---|---|---|---|---|
| **Wine** (`lib/wine`, `lib64`, `share/wine`, `bin/wine*`) | **11.0** | LGPL 2.1 | `share/wine/wine.inf` (`;; Version: Wine 11.0`) | codeweavers.com/crossover/source · winehq.org | Compilar do fonte do CrossOver 26.3 (fiel) ou do WineHQ 11.0 |
| **wine-gecko** | **2.47.4** (x86 + x86_64) | MPL 2.0 | nomes em `share/wine/gecko/` | dl.winehq.org | **Redistribuível pré-compilado** (download direto) |
| **wine-mono** | **10.4.1** | MIT / LGPL | nome em `share/wine/mono/` | github.com/wine-mono/wine-mono | **Redistribuível pré-compilado** (download direto) |
| **DXVK** (`lib/dxvk/*`) | (tag não exposta nos binários) | zlib | DLLs PE em `lib/dxvk/` | github.com/doitsujin/dxvk · fonte CodeWeavers | Compilar (mingw) ou pegar do tarball CodeWeavers |
| **DXMT / winemetal** (`lib/dxmt/*`) | símbolos `dxmt::*`, shaders `v8.x` | open (patrocínio CodeWeavers) | strings de `lib/dxmt/x86_64-unix/winemetal.so` | github.com/3Shain/dxmt · fonte CodeWeavers | Compilar (toolchain Metal) ou pegar do tarball CodeWeavers |
| Little-CMS, FreeType, etc. | — | várias | `license.txt` | respectivos projetos / fonte CodeWeavers | Dentro do tarball CodeWeavers |

### URLs verificadas (HTTP 200, em 2026-10-21)

- Gecko x86 — `https://dl.winehq.org/wine/wine-gecko/2.47.4/wine-gecko-2.47.4-x86.tar.xz` (~43 MB)
- Gecko x86_64 — `https://dl.winehq.org/wine/wine-gecko/2.47.4/wine-gecko-2.47.4-x86_64.tar.xz` (~42 MB)
- Mono — `https://github.com/wine-mono/wine-mono/releases/download/wine-mono-10.4.1/wine-mono-10.4.1-x86.tar.xz` (~39 MB)
- Fonte CodeWeavers — `https://www.codeweavers.com/crossover/source`

## Faseamento da obtenção por upstream

Em ordem de esforço, do mais fácil ao mais pesado:

1. **Dados redistribuíveis (Gecko + Mono).** São pré-compilados e baixáveis
   direto do upstream, sem toolchain. `vendor/setup.sh` já sabe buscá-los
   (`VENDOR_UPSTREAM_DATA=1`); eles substituem as cópias do host em
   `vendor/SharedSupport/share/wine/{gecko,mono}` quando o SharedSupport é um
   snapshot copiado (`VENDOR_SHAREDSUPPORT_MODE=copy`).

2. **Wine 11.0.** `vendor/build-wine.sh` automatiza: baixa o fonte do CrossOver
   26.3 (`crossover-sources-26.3.0.tar.gz`, LGPL), compila o Wine (WoW64
   `i386,x86_64`) e mescla `lib/wine`/`share/wine` em `vendor/SharedSupport`
   (modo `copy`). `bash vendor/build-wine.sh --check` confere pré-requisitos
   (Xcode CLT + Homebrew: bison, flex, mingw-w64, pkgconf, gnutls) e a fonte sem
   compilar. Heavy (toolchain + dezenas de minutos); fora do `make` normal.

3. **DXVK e DXMT.** Compilar os PE (DXVK via mingw; DXMT com o pipeline Metal)
   ou extrair do tarball CodeWeavers. Depende do item 2 para a árvore de destino.

Enquanto 2 e 3 não estão feitos, o `SharedSupport` continua vindo do host
(symlink, padrão da Fase 1). A independência total do backend é a conclusão
desta fase.
