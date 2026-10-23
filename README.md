# CrossThrough

<img src="app/Resources/icon/CrossThrough-1024.png" alt="ícone do CrossThrough" width="128" align="right">

Um app para macOS que roda programas Windows. Tudo é open source: o app em
SwiftUI, a biblioteca e a linha de comando em Swift, e o runtime do Wine,
compilado aqui do código-fonte. Nada vem de um app de terceiros instalado no Mac.

- **Catálogo.** Cada receita instala um programa numa bottle nova ou numa que
  já existe: põe as dependências do winetricks, baixa o instalador oficial
  (conferido por SHA-256) e roda o instalador.
- **Bottles.** Cada bottle é um Windows à parte (um prefixo do Wine). O app
  mostra os programas do Menu Iniciar com os ícones deles, abre, acompanha e
  encerra o que roda ali. Também aceita instaladores `.exe` e `.msi` arrastados
  para a janela. Os ajustes de cada bottle são a versão do Windows, o backend
  gráfico, o msync, as variáveis de ambiente, a ordem de carga das DLLs e o
  winetricks.
- **Bottles de outro programa.** Um prefixo do Wine criado por outro app
  aparece na barra lateral, e um clique o adota sem mexer nos programas nem nos
  dados.
- **Linha de comando.** O `crossthrough` faz o mesmo que o app, sobre a mesma
  biblioteca.

## Requisitos

- Um Mac com Apple Silicon e macOS 14 ou mais novo.
- O Rosetta 2, porque o Wine é x86_64.
- O Swift 6 (Xcode ou Command Line Tools), para compilar o app.
- Para compilar o runtime, o que só acontece na primeira instalação:
  - o Xcode completo;
  - o Homebrew;
  - as ferramentas de build listadas em [`runtime/README.md`](runtime/README.md).

  Num M5, esse build leva cerca de 3 horas.

O app é universal, e o runtime x86_64 também roda em Macs Intel, mas isso ainda
não foi testado.

## Instalar

```bash
git clone https://github.com/Lucaddias/CrossThrough.git
```

```bash
cd CrossThrough && ./install.sh
```

O `install.sh`:

1. confere os requisitos;
2. compila o runtime, se ele ainda não existir em `runtime/out/`;
3. roda os testes;
4. monta o app;
5. instala o app em `/Applications/CrossThrough.app`.

Antes de trocar o app, o script recusa a troca se houver programas do Windows
abertos por ele. Se o app estava aberto, é reaberto já na versão nova. Nenhuma
etapa pede senha de administrador.

| Opção | Efeito |
|---|---|
| `--dir <pasta>` | instala em outra pasta (ex.: `~/Applications`) |
| `--runtime <dir>` | usa um runtime já compilado em outro lugar |
| `--no-test` | pula os testes |
| `--uninstall` | remove o app; as bottles, os logs e os caches ficam |

## Usar

- **Catálogo.** Escolha uma receita e clique em Instalar. Ela pode ir para uma
  bottle nova ou para uma que já existe.
- **Bottle.** Dê dois cliques num programa para abri-lo. O menu de contexto
  encerra o programa e mostra os arquivos e os logs. A barra de ferramentas tem
  estes botões:
  - Executar arquivo;
  - Winetricks;
  - Disco C:;
  - Encerrar tudo;
  - Configurações.
- **Bottle de outro programa.** Selecione-a e clique em Usar no CrossThrough. O
  app atualiza o Windows dela para o Wine do runtime e instala o backend gráfico
  escolhido (para o EA app, o Wine (OpenGL), que ele já sugere).

Pelo Terminal, o CLI está dentro do app:

```bash
/Applications/CrossThrough.app/Contents/Helpers/crossthrough help
```

| O quê | Onde |
|---|---|
| bottles | `~/Library/Application Support/CrossThrough/Bottles` |
| logs, por bottle | `~/Library/Logs/CrossThrough` |
| downloads, ícones e cache do winetricks | `~/Library/Caches/CrossThrough` |

## Backends gráficos

| Backend | Para quê |
|---|---|
| DXMT (Metal) | o padrão: Direct3D 10/11 direto no Metal, o mais rápido no Apple Silicon |
| DXVK (Vulkan) | Direct3D 9/10/11 via Vulkan e MoltenVK |
| Wine (OpenGL) | o tradutor do próprio Wine: o mais compatível e o mais lento |

O D3DMetal da Apple (Game Porting Toolkit) não entra, porque é proprietário.
Jogos que só rodam com ele ainda não rodam aqui.

## Limitações conhecidas

- Vídeo e áudio por Media Foundation/DirectShow ainda não tocam, porque o
  GStreamer não está no runtime.
- O EA app só abre com o Wine (OpenGL). O DXMT ainda não tem swap chain entre
  processos, de que o Chromium precisa, e com o DXVK ele trava.

## Estrutura

```
install.sh          compila e instala o app
app/                o app SwiftUI, o CrossThroughKit e o CLI (pacote Swift)
├── Sources/
│   ├── CrossThroughKit/   bottles, Wine, atalhos .lnk, ícones, catálogo, instalação
│   ├── CrossThroughApp/   a interface
│   └── crossthrough/      a linha de comando
├── Tests/
└── scripts/bundle.sh      monta o CrossThrough.app
catalog/            as receitas do catálogo
runtime/            o build do runtime do Wine, do fonte
docs/               como funciona e a referência da API
```

## Documentação

- [`docs/HOW-IT-WORKS.md`](docs/HOW-IT-WORKS.md): as camadas e o caminho de
  cada operação, do clique até o Wine.
- [`docs/API.md`](docs/API.md): a referência do CrossThroughKit e dos comandos
  do CLI.
- [`app/README.md`](app/README.md): como compilar, testar e capturar as telas
  do app, além de detalhes da adoção, dos atalhos e dos ícones.
- [`runtime/README.md`](runtime/README.md): os componentes, as licenças, o
  build e os testes do runtime.
- [`catalog/README.md`](catalog/README.md): o formato das receitas e as regras
  para entrar no catálogo.

## Licenças

Cada componente do runtime (Wine, DXVK, DXMT, MoltenVK, Gecko, Mono, winetricks
e os demais) mantém a própria licença open source. A lista fixa está em
[`runtime/components.lock`](runtime/components.lock), e os textos das licenças
vão dentro do app, em `Contents/SharedSupport/CrossThroughRuntime/share/licenses`.
O projeto não tem afiliação com o Wine nem com a CodeWeavers.
