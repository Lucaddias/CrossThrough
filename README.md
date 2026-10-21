# CrossThrough

Uma GUI nativa para macOS, em Objective-C/Cocoa, que roda aplicativos e jogos Windows. A GUI instala apps a partir de um catálogo de receitas, cria e gerencia *bottles* (ambientes Wine isolados) e abre os programas instalados.

![ícone](CrossThrough/resources/icon/CrossThrough-1024.png)

## Requisitos

- macOS 11 ou mais recente (Apple Silicon ou Intel). No Apple Silicon, o Rosetta 2 é necessário.
- Xcode Command Line Tools (`xcode-select --install`).
- O runtime host instalado e licenciado em `/Applications/CrossOver.app`, versão 26.3. O CrossThrough é só a interface: o Wine, a biblioteca Python e as ferramentas de bottle vêm desse runtime.

## Instalação

```bash
git clone https://github.com/Lucaddias/CrossThrough.git
```

```bash
cd CrossThrough && ./install.sh
```

O instalador:

1. confere os requisitos;
2. compila o app;
3. roda os testes;
4. instala em `/Applications/CrossThrough.app`, encerrando antes uma cópia aberta.

Depois disso, abra o app pelo Launchpad ou pelo Spotlight. Nenhuma etapa pede senha de administrador.

Opções do instalador:

| Opção | Efeito |
|---|---|
| `--dir <pasta>` | instala em outra pasta (ex.: `~/Applications`) |
| `--no-test` | pula os testes |
| `--uninstall` | remove o app instalado |

Na primeira abertura, se o macOS bloquear o app (ele é assinado ad hoc), clique com o botão direito no app e escolha **Abrir**.

## Uso

- **Home**: catálogo de apps populares, com busca. Clique num app para ver detalhes e **Install**.
- **Install an unlisted application**: instala qualquer `.exe`/`.msi` local.
- **Bottles**: na barra lateral, cada bottle mostra seus programas. O menu de contexto abre, configura ou apaga a bottle.

## Compilar manualmente

```bash
cd CrossThrough
```

```bash
make -j8 && make app
```

| Alvo | O que faz |
|---|---|
| `make` | compila o binário em `build/CrossThrough` |
| `make app` | monta `build/CrossThrough.app` |
| `make install` | instala em `/Applications` (`INSTALL_DIR=<pasta>` para outra) |
| `make test` | `test_wizard` + `test_misc` |
| `make snapshot` | capturas das telas Home e detalhe em `build/snapshots/` |
| `make probe` | lista as tarefas de instalação de `PROBE_PACKAGE` |
| `make icon` / `make logo` | regenera o ícone e a logo a partir de `resources/icon/controller.webp` |
| `make clean` | apaga `build/` |

## Documentação

- [`docs/HOW-IT-WORKS.md`](docs/HOW-IT-WORKS.md): camadas, inicialização, ponte GUI ↔ Python, fluxo de instalação, classes e funções.
- [`CrossThrough/ARCHITECTURE.md`](CrossThrough/ARCHITECTURE.md): detalhes de baixo nível (processos, privilégios, apps helper).
- [`CrossThrough/sharedsupport/`](CrossThrough/sharedsupport): ferramentas Perl e biblioteca Python do backend.
- [`CrossThrough/decompiled/`](CrossThrough/decompiled): pseudocódigo de referência usado na reconstrução.

## Estrutura

```
install.sh              # instalador
docs/                   # documentação do sistema
CrossThrough/
├── Makefile            # build, empacotamento e instalação
├── src/                # código-fonte
│   ├── Headers/        # headers das classes
│   ├── include/        # CrossThrough.h, shims (Python, Sparkle) e branding
│   ├── classes/        # implementação das 95 classes
│   ├── c_functions.m   # funções C
│   └── main.m          # ponto de entrada
├── tests/              # testes e ferramentas de captura
├── tools/              # geradores do ícone e da logo
├── resources/          # ícone e logo
├── decompiled/         # referência
└── sharedsupport/      # referência do backend
```

## Comportamentos próprios

- A lista de ícones do catálogo é baixada em segundo plano. Se a resposta não for válida, o app continua sem ela.
- Os caminhos dos ícones ficam salvos em `~/Library/Caches/com.crossthrough.app/IconPaths.plist`, para os ícones aparecerem mesmo sem rede.
- A cópia instalada não reivindica `.exe`, `.c4p` nem links de receita: essas associações continuam com o runtime host.

## Aviso

Projeto de estudo de engenharia reversa, sem afiliação com o fabricante do runtime host. Ele não distribui nenhum binário ou recurso desse runtime: tudo é lido da sua instalação licenciada.
