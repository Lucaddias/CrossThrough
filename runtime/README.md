# Runtime do CrossThrough

O runtime é o Wine e tudo o que ele carrega para rodar programas Windows no macOS. Ele é compilado aqui, do código-fonte, só com componentes open source. Nenhuma parte proprietária entra nele: nem o D3DMetal da Apple nem as ferramentas e bibliotecas do CrossOver.

Um `./build.sh` baixa cada fonte fixado em [`components.lock`](components.lock) e confere o SHA-256. Depois compila, monta o runtime em `out/CrossThroughRuntime` e prova com testes que ele funciona sozinho, inclusive depois de movido para outro lugar.

## Componentes

| Componente | Versão | Licença | Papel |
|---|---|---|---|
| Wine (árvore LGPL da CodeWeavers, com msync) | 11.0 | LGPL-2.1+ | o próprio Windows: loader, DLLs, servidor |
| GnuTLS + Nettle + GMP | 3.8.3 / 3.10.2 / 6.3.0 | LGPL | TLS e criptografia (schannel, bcrypt, crypt32) |
| FreeType | 2.13.3 | FTL ou GPL-2 | fontes TrueType |
| MoltenVK (+ SPIRV-Cross, cereal, Vulkan-Headers) | 1.2.10 | Apache-2.0 | Vulkan sobre Metal |
| DXVK (série para macOS) | 1.10.3 | zlib | Direct3D 9/10/11 → Vulkan |
| DXMT | 0.80 | MIT | Direct3D 10/11 → Metal |
| Wine Gecko | 2.47.4 | MPL-2.0 | motor HTML (mshtml) |
| Wine Mono | 10.4.1 | MIT, LGPL e outras | .NET Framework |
| winetricks | 20260125 | LGPL-2.1+ | instala dependências numa bottle (vcrun, dotnet, fontes, d3dx…) |
| cabextract (+ libmspack) | 1.9.1 | GPL-2+ (libmspack: LGPL-2.1) | extrai os `.cab`/`.exe` da Microsoft para o winetricks |

O fonte do Wine, das bibliotecas TLS, do MoltenVK, do DXVK e do cabextract vem do tarball LGPL que a CodeWeavers publica, a mesma base do Wine que o CrossOver usa. O Nettle e o FreeType vêm dos lançamentos oficiais, porque as cópias do tarball estão incompletas. O DXMT, o Gecko e o Mono vêm dos binários oficiais de cada projeto, e o winetricks, do script do lançamento. As licenças vão junto, em `share/licenses/<componente>`.

### O que ficou de fora, e por quê

| Item | Motivo |
|---|---|
| D3DMetal (Game Porting Toolkit) | proprietário da Apple, sem licença de redistribuição |
| CrossTie, cxcompatdb, ferramentas `cx*` | proprietários da CodeWeavers; o Wine só registra um aviso inofensivo quando o `cxcompatdb.so` não existe |
| GStreamer/FFmpeg | ainda não empacotados: vídeo e áudio via Media Foundation/DirectShow ainda não tocam |
| SDL | ainda não empacotado; controles continuam funcionando pelo IOHID do macOS |
| Bibliotecas Unix 32-bit | não existem no macOS atual; os programas 32-bit rodam pelo WoW64 novo do Wine |

## Compilar

Requisitos:
- Apple Silicon com Rosetta 2;
- Xcode completo, porque o MoltenVK usa `xcodebuild`;
- Homebrew, só para ferramentas de build. Nenhuma biblioteca do Homebrew entra no runtime, que é x86_64, enquanto as dele são arm64.

```bash
brew install bison mingw-w64 pkgconf meson ninja autoconf automake libtool gettext glslang cmake
```

```bash
./build.sh
```

| Opção | Efeito |
|---|---|
| `--clean` | apaga tudo, menos os downloads, e compila do zero |
| `--no-test` | não roda os testes no final |

Cada etapa é retomável: se uma falhar, rodar de novo continua de onde parou. Num M5, o build do zero com os testes levou 2h45: 3 minutos nas bibliotecas, 36 no MoltenVK, 1h45 no Wine e o restante em DXVK, montagem e testes.

| Etapa | Script | Faz |
|---|---|---|
| 1 | `scripts/prereqs.sh` | confere as ferramentas |
| 2 | `scripts/deps.sh` | GMP, Nettle, GnuTLS, FreeType e cabextract (x86_64) |
| 3 | `scripts/moltenvk.sh` | MoltenVK. As dependências externas são clonadas do GitHub nas revisões fixadas em `ExternalRevisions/` |
| 4 | `scripts/wine.sh` | Wine 11.0 com WoW64 (`--enable-archs=i386,x86_64`) |
| 5 | `scripts/dxvk.sh` | DXVK 32 e 64-bit (mingw-w64) |
| 6 | `scripts/assemble.sh` | monta `out/CrossThroughRuntime` e o manifesto |
| 7 | `scripts/smoke.sh` | testes no runtime montado |
| 8 | `scripts/relocation.sh` | os mesmos testes com o runtime movido para um caminho no limite |

O compilador é o clang nativo (arm64) gerando x86_64 com `-arch x86_64`. Só os programas de teste do `configure` rodam no Rosetta.

### Patches

Correções aplicadas sobre os fontes, numa cópia; o fonte extraído nunca é alterado. Cada patch explica o problema no cabeçalho.

| Patch | Corrige |
|---|---|
| `patches/wine/0001-mscoree-bound-mono-path-buffers.patch` | estouro de pilha no mscoree com o runtime num caminho longo (o `wineboot` caía no primeiro boot da bottle) |
| `patches/dxvk/0001-d3d9-mingw-w64-define-d3ddevinfo.patch` | redefinição de tipo com o mingw-w64 14 |
| `patches/dxvk/0002-d3d10-mingw-w64-declares-stateblock-uuid.patch` | redefinição de UUID com o mingw-w64 14 |

## Layout

```
CrossThroughRuntime/
  bin/wine, bin/wineserver, bin/cabextract
  lib/*.dylib                      gnutls, nettle, hogweed, gmp, freetype, MoltenVK
  lib/wine/{x86_64,i386}-windows   DLLs do Wine (PE) + winemetal (DXMT)
  lib/wine/x86_64-unix             módulos Unix do Wine + winemetal.so
  lib/dxvk/{x86_64,i386}-windows   DXVK, instalado por bottle
  lib/dxmt/{x86_64,i386}-windows   DXMT, instalado por bottle
  share/wine/{gecko,mono}          Gecko e Mono já descompactados
  share/winetricks/winetricks      o script do winetricks
  share/licenses/                  licença de cada componente
  runtime.json                     versões, origens, SHA-256 e limites
```

O runtime é relocável: binários e bibliotecas se acham por `@rpath`/`@loader_path`, e o `assemble.sh` falha se algum Mach-O ainda apontar para o diretório de build.

## Contrato com o app

O que o app precisa respeitar para usar o runtime. O [`smoke.sh`](scripts/smoke.sh) é a referência executável de cada item.

- **Ambiente.** Basta `WINEPREFIX` apontando para a bottle. Nenhuma variável `DYLD_*` é necessária: os testes rodam com `env -i` justamente para provar isso. `WINEDEBUG=-all` silencia o log.
- **Backend gráfico por bottle.** O padrão é o wined3d (OpenGL), sem nada a fazer.
  - **DXVK:** copie `lib/dxvk/<arch>-windows/*.dll` para `system32` (x86_64) e `syswow64` (i386) da bottle e defina `WINEDLLOVERRIDES="d3d9,d3d10,d3d10_1,d3d10core,d3d11,dxgi=n,b"`.
  - **DXMT:** o mesmo com `lib/dxmt`, para `d3d10core,d3d11,dxgi`.
  - **Voltar ao padrão:** copie de volta as DLLs de `lib/wine`, a função `use_backend` faz exatamente isso.
- **Caminho de instalação.** No máximo `maxInstallPathLength` caracteres (150), conforme o `runtime.json`. O Wine monta caminhos de DOS em buffers de 260 caracteres a partir do caminho do runtime; acima de cerca de 195 o Mono deixa de ser encontrado. Por isso o limite tem folga, e o `relocation.sh` testa exatamente nele, num caminho com espaços. O caminho da bottle não tem esse limite: dentro dela tudo é `C:\`.
- **Diretório atual.** O programa roda com o diretório atual no dele, como no Windows. O DXVK grava ali o log (`<exe>_d3d11.log`) e o cache de shaders (`<exe>.dxvk-cache`).
- **Gecko e Mono** são usados direto de `share/wine`, sem download e sem cópia para a bottle. O `wineboot --init` instala o suporte .NET (`Microsoft.NET`) a partir dali.
- **winetricks.** Rode `share/winetricks/winetricks -q <verbo>` com o ambiente da bottle mais `WINE=bin/wine`, `WINESERVER=bin/wineserver` e `bin/` no começo do `PATH`, para ele achar o `cabextract`. O `curl`, o `unzip` e o `shasum` são os do macOS. Sem `7z`, ele instala o 7-Zip do Windows na bottle quando um verbo precisa. Aponte `XDG_CACHE_HOME` para o cache do app (os downloads ficam em `<cache>/winetricks`) e defina `WINETRICKS_LATEST_VERSION_CHECK=disabled`, porque a versão é a fixada aqui. A função `winetricks_env` do smoke.sh monta esse ambiente.

## Testes

O `smoke.sh` cria uma bottle descartável e verifica cada parte do runtime de verdade, não só a presença de arquivos:

| Teste | Prova |
|---|---|
| `wineboot --init`, `cmd /c ver` | a bottle nasce e o Windows responde |
| `tlstest.exe` | HTTPS aceita um certificado válido e recusa um inválido (e funciona ignorando a validação, prova de que a recusa é do certificado). As conexões que têm de funcionar são tentadas até 3 vezes, para uma queda de rede não reprovar o runtime |
| `fonttest.exe` | Tahoma carregada pelo FreeType, com métricas de contorno, e texto desenhado |
| `htmltest.exe` (64 e 32-bit) | o mshtml faz o parse de HTML com o Gecko e devolve o texto |
| `dotnettest.cs` | compilado pelo `csc.exe` da bottle e executado no Mono (LINQ, texto, P/Invoke) |
| `vktest.exe` | Vulkan enumera a GPU via MoltenVK |
| `cabarc` + `cabextract` | um `.cab` criado pelo Wine é extraído pelo cabextract do runtime, com o conteúdo conferido |
| `winetricks -q fontsmooth=bgr` | o winetricks reconhece o Wine do runtime (WoW64 novo, win64) e grava o registro da bottle |
| `d3d11test.exe` (64 e 32-bit) × wined3d, DXVK, DXMT | dispositivo D3D11, limpeza de tela lida de volta pixel a pixel e 10 quadros apresentados; o teste confere qual backend de fato rodou |

Em um M5, os 21 passam no lugar e realocados.
