# Como o CrossThrough funciona

Este documento acompanha cada operação desde o clique no app até o Wine: as
camadas, a inicialização e o caminho percorrido em cada caso. A lista de
tipos e funções fica em [API.md](API.md).

## Camadas

```
┌────────────────────────────────────────────────────────────┐
│ CrossThroughApp (SwiftUI)          crossthrough (CLI)      │  interface
│   AppModel: estado, tarefas, alertas   um comando por vez  │
├────────────────────────────────────────────────────────────┤
│ CrossThroughKit                                            │  toda a lógica
│   BottleStore · Bottle · Wine · Installer · Catalog        │
│   ProgramScanner · ShellLink · ReparsePoint · IconExtractor│
│   GraphicsBackend · Winetricks · Downloader · adoção       │
├────────────────────────────────────────────────────────────┤
│ Runtime (Contents/SharedSupport/CrossThroughRuntime)       │  compilado do fonte
│   Wine 11 x86_64 · DXMT · DXVK + MoltenVK · Gecko · Mono   │  em runtime/
│   winetricks · cabextract                                  │
├────────────────────────────────────────────────────────────┤
│ Rosetta 2 → macOS (Metal, Vulkan via MoltenVK, OpenGL)     │
└────────────────────────────────────────────────────────────┘
```

O app e o CLI não falam com o Wine diretamente: tudo passa pelo Kit, que roda
os executáveis do runtime (`bin/wine`, `bin/wineserver`) como processos
filhos, com um ambiente montado do zero. Não há biblioteca Python, ferramenta
Perl nem framework de terceiros no meio.

## Inicialização do app

1. `CrossThroughApp` cria o `AppModel`. Ele faz três coisas:
   - acha o runtime com `Runtime.locate()`, que procura nesta ordem:
     `CROSSTHROUGH_RUNTIME`, `Contents/SharedSupport` do app e
     `runtime/out/` do repositório;
   - carrega o catálogo com `Catalog.locate()`;
   - passa a observar o diretório das bottles com o FSEvents
     (`DirectoryWatcher`).
2. A janela abre e chama `reload()`. `BottleStore.scan()` separa o conteúdo de
   `~/Library/Application Support/CrossThrough/Bottles` em três grupos:
   - **bottles**: têm um `crossthrough.json` válido;
   - **danificadas**: têm um `crossthrough.json` ilegível;
   - **de outro programa**: não têm `crossthrough.json`, mas têm `system.reg` e
     `drive_c/`.
3. Quando uma bottle é selecionada, `ProgramScanner.scan` monta a lista de
   programas dela, fora da thread principal.
4. Daí em diante, um evento do FSEvents vira um `StoreChanges`:
   - uma bottle criada, apagada ou renomeada relê a lista de bottles;
   - um atalho novo no Menu Iniciar relê só os programas daquela bottle.

   Assim, uma instalação feita pelo CLI aparece no app sozinha.

Sem runtime, o app abre do mesmo jeito: o catálogo e as bottles aparecem, e as
ações que precisam do Wine ficam desligadas, com a explicação na tela.

## Tarefas

Toda operação longa (criar, adotar, instalar, winetricks, renomear, apagar) é
uma `Job` do `AppModel`. O rodapé da barra lateral mostra o título, a fase atual
e, no download, a fração concluída. Um erro vira um alerta com um botão para o
log. Cancelar interrompe a tarefa, e uma criação interrompida não deixa nada no
disco. Uma bottle com uma tarefa em andamento recusa outra.

## Criar uma bottle

`BottleStore.create(name:windowsVersion:graphics:runtime:)`:

1. cria o diretório, que falha se outro processo já o tiver criado;
2. roda `wine wineboot --init`, que monta o registro, o `system32`, o
   `syswow64`, o Mono e o Gecko;
3. espera com `wineserver -w` e confere se `kernel32.dll` existe nas duas
   arquiteturas;
4. roda `winecfg /v <versão>` se a versão pedida não for o Windows 10 padrão;
5. instala o backend gráfico (veja abaixo);
6. grava o `crossthrough.json`.

Qualquer falha encerra a bottle (`wineserver -k`) e apaga o diretório. O log da
tentativa fica em `~/Library/Logs/CrossThrough/<bottle>/`.

## O ambiente do Wine

`Wine.environment()` não herda nada de quem chamou; é o equivalente a um
`env -i`. Ele contém:

- `HOME`, `USER`, `LOGNAME`, `TMPDIR` e `LANG`;
- `PATH`, com o `bin/` do runtime e o sistema;
- `WINEPREFIX`, apontando para a bottle;
- `WINEDEBUG=-all`, ou um nível de log detalhado se o log detalhado estiver
  ligado nos Ajustes;
- `WINEDLLOVERRIDES`. Tem `winemenubuilder.exe=d`, para o Wine não criar
  atalhos fora da bottle, depois as DLLs do backend gráfico e por fim os
  overrides da bottle, cada um com precedência sobre o anterior;
- `WINEMSYNC=1`, quando o msync está ligado;
- os níveis de log do DXVK e do MoltenVK;
- as variáveis da bottle.

A saída de cada processo vai para um arquivo de log, nunca para um pipe: o
`wineserver` e os serviços que ficam vivos segurariam o pipe aberto, e quem lê
esperaria para sempre.

## Backend gráfico

| Backend | DLLs nativas em `system32`/`syswow64` | Override |
|---|---|---|
| DXMT | `d3d10core`, `d3d11`, `dxgi` (de `lib/dxmt`) | `d3d10core,d3d11,dxgi=n,b` |
| DXVK | `d3d9`, `d3d10`, `d3d10_1`, `d3d10core`, `d3d11`, `dxgi` (de `lib/dxvk`) | as seis `=n,b` |
| Wine (OpenGL) | nenhuma: as seis voltam a ser as do Wine (`lib/wine`) | nenhum |

Trocar de backend sempre restaura antes as DLLs do Wine, então uma bottle só
pode estar em um desses três estados. Cada arquivo é trocado de forma atômica.
Os programas abertos continuam com o backend antigo até serem reabertos.

`GraphicsBackend.advice(for:)` olha os programas da bottle e recomenda um
backend quando algum deles não abre com o padrão. Hoje o único caso é o EA app,
que precisa do Wine (OpenGL).

## Programas e atalhos

`ProgramScanner.scan` lê os `.lnk` destes lugares:

- o Menu Iniciar de todos os usuários (`ProgramData`);
- o Menu Iniciar de cada usuário (`AppData/Roaming`);
- as Áreas de Trabalho.

O `ShellLink` lê cada atalho sem usar o Windows: a lista de IDs, o LinkInfo, o
caminho relativo, o diretório de trabalho, os argumentos, o ícone e o bloco de
ambiente. Ficam de fora:

- os desinstaladores;
- os atalhos para pastas e documentos;
- as repetições: o mesmo alvo com os mesmos argumentos vale como um programa só.

Para achar o alvo no Mac, `Bottle.existingUnixPath(forWindowsPath:)` faz três
coisas:

- expande `%VARIÁVEIS%` com o ambiente do Windows da bottle;
- percorre o caminho sem diferenciar maiúsculas de minúsculas, como o NTFS;
- atravessa os links simbólicos e as junções que o Wine grava (um item
  `<nome>?` com o atributo `user.WINEREPARSE`, lido por `ReparsePoint`).

O ícone vem do recurso `RT_GROUP_ICON` do executável, lido pelo
`IconExtractor`. Ele escolhe no `.ico` a imagem maior e com mais cores e a
converte em PNG. O resultado fica em cache, com a data do arquivo na chave.

## Abrir um programa

Muitos programas não são o processo que abre. Um launcher (o `EALauncher` do
EA app, os de muitos jogos, um `.bat` com `start`) abre o programa de verdade e
sai na hora. Do lado do macOS não dá para saber quem abriu quem: o Wine solta
cada processo, e o pai Unix de todos vira o launchd.

Por isso quem abre é o `ctlaunch.exe`, um programa do Windows que vem no
runtime (`runtime/helpers/ctlaunch.c`) e roda na bottle:

```
wine ctlaunch.exe run   <id> <diretório> <aplicação> <linha de comando>
wine ctlaunch.exe shell <id> <diretório> <arquivo> [parâmetros]
wine ctlaunch.exe stop  <id>
```

Antes de abrir o programa, o `ctlaunch` entra num job object do Windows. Todo
processo que nasce dele herda o job, por mais rápido que saia, e o job avisa
cada entrada pela porta de conclusão. Um processo que pede para sair do job
(`CREATE_BREAKAWAY_FROM_JOB`) sai, para nenhum programa falhar por isso, e é
achado pelo PID do pai, na lista de processos do Windows (Toolhelp), uma vez
por segundo. Os processos de fundo da bottle (o `explorer.exe` da área de
trabalho, o `conhost.exe`, os serviços) não contam. O `ctlaunch` sai quando o
último processo da árvore fecha, com o código de saída dele. Se nada abriu, o
código é 127 e o motivo vai para o log.

`Wine.open(_:log:onExit:)` resolve o atalho no próprio Kit:

- **Alvo executável:** `run`, com a linha de argumentos do atalho exatamente
  como ela está, no diretório de trabalho do atalho.
- **Alvo não executável** (um `.bat`, um documento): `shell`, que abre pela
  associação do Windows.
- **Atalho do Windows Installer**, que não traz caminho: `shell` com o próprio
  `.lnk`, que o msi resolve.

`Wine.open(file:)` faz o mesmo para um arquivo: `.exe` e `.com` por `run`,
`.msi` por `run` do `msiexec /i`, o resto por `shell`.

O app mostra o programa como aberto enquanto o `ctlaunch` vive. Fechar pede
`ctlaunch.exe stop <id>`, que encerra a árvore. Se o `ctlaunch` não atender em
15 segundos, o Kit encerra só ele, para o app não ficar esperando. Se o
programa fechar com erro em menos de 5 segundos, aparece um alerta com o log,
porque isso quase sempre é uma falha ao iniciar.

## Instalar uma receita

`Installer.install(_:into:progress:)`:

1. cria a bottle, se o destino for uma nova. A receita define a versão do
   Windows, o backend e o msync. Numa bottle que já existe, a receita só soma
   variáveis e overrides;
2. roda o winetricks com os verbos que faltam. O cache do winetricks fica em
   `~/Library/Caches/CrossThrough`;
3. baixa o instalador para `~/Library/Caches/CrossThrough/Downloads`, ou
   reaproveita um já baixado. Nos dois casos confere o SHA-256 da receita;
4. instala:

   | Tipo | Comando |
   |---|---|
   | `run` | `wine <instalador> <argumentos>` |
   | `msi` | `msiexec /i` |
   | `extract` | extrai o `.zip` com o `ditto` |

   Os códigos de saída 0, 1641 e 3010 contam como sucesso;
5. espera os processos que o instalador deixou rodando. Os de fundo (serviços,
   `explorer.exe`) não contam;
6. cria o atalho da receita no Menu Iniciar, quando ela tem um;
7. registra a receita no `crossthrough.json`.

Se a instalação falhar numa bottle nova, a bottle vai para o Lixo.

## Adotar uma bottle de outro programa

`BottleStore.adopt(_:graphics:runtime:)`:

1. lê a versão do Windows do `system.reg` (`CurrentBuild`, por exemplo 19045 →
   Windows 10);
2. roda `wineboot --update`, que atualiza os arquivos do Windows para o Wine
   do runtime e mantém o registro, os programas e os dados;
3. encerra a bottle (`wineserver -k`), o que grava o registro;
4. confere se `kernel32.dll` existe e instala o backend gráfico;
5. grava o `crossthrough.json`, com a data da adoção.

Os arquivos de configuração do outro programa ficam como estão. Adotar uma
bottle que já tem `crossthrough.json` não faz nada.

## Empacotamento

`app/scripts/bundle.sh` faz o seguinte:

- compila o app e o CLI em modo universal (arm64 e x86_64);
- monta o `CrossThrough.app` com o catálogo e o ícone;
- copia o runtime com `ditto`, que preserva os links e as permissões;
- assina tudo ad hoc.

O `install.sh` da raiz chama o `bundle.sh` depois dos testes e troca o app em
`/Applications` de uma vez: grava ao lado, confere a assinatura, fecha o app
aberto e move. Antes, confere duas coisas:

- se não há programas do Windows abertos pelo runtime do app;
- se o caminho do runtime instalado cabe no limite do `runtime.json`.
