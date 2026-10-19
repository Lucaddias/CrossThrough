# CrossOver

Estudo de engenharia reversa (curiosidade/interoperabilidade) do app **CrossOver for Mac** da CodeWeavers.

> [!WARNING]
> CrossOver é software proprietário da CodeWeavers. O pseudocódigo aqui é saída automática do Hopper e não é o código-fonte original. A parte Wine do CrossOver é open source e está disponível em <https://www.codeweavers.com/crossover/source>.

## Alvo

| Campo | Valor |
|---|---|
| App | `/Applications/CrossOver.app` |
| Versão | 26.3 |
| Binário | `Contents/MacOS/CrossOver` (Mach-O universal: arm64 + x86_64) |
| SHA-256 | `1d245f2f9f52bd56a120616fede8b1eb9cca9fa228319de04a2cbeabd8de7174` |
| Slice analisada | arm64 |
| Ferramentas | REA (MCP) + Hopper Disassembler |

## Progresso

| Etapa | Estado |
|---|---|
| Inventário do bundle (frameworks, libs) | ✅ |
| Índice de procedures (10.627) | ✅ [`INDEX.md`](CrossOver/decompiled/INDEX.md) |
| Mapa de classes ObjC (94 classes) | ✅ [`objc_methods.json`](CrossOver/decompiled/objc_methods.json) |
| Descompilação de todos os métodos ObjC (2.107/2.107, 0 erros) | ✅ [`classes/`](CrossOver/decompiled/classes) |
| Funções C/`sub_*` não-ObjC (~3.000 relevantes de 8.520) | ⏳ pendente |
| Slice x86_64 | ⏳ pendente |
| Scripts Python/Perl em `SharedSupport/CrossOver` | ⏳ pendente |
| Documentação da arquitetura (GUI ↔ backend) | ⏳ pendente |

## Arquitetura (observações iniciais)

- **GUI nativa em Objective-C/Cocoa.** As classes principais são `MainWindowController`, `BottleViewController`, `PackageViewController` e `PackageInstaller`.
- **`CXServerCrossOver`** (~13,9 mil linhas de pseudocódigo) é a maior classe. Gera os apps "helper" do macOS por bottle (`CrossOverHelper*`, `CFBundleDocumentTypes`, associações de extensão/URL como `steam`, `mailto`) e os menus a partir dos dados da bottle (`%WINEPREFIX%`, `--bottle %@`).
- **Python 3.13 embutido** (`Contents/Frameworks/Python.framework`). A lógica de bottles e instalação fica em `SharedSupport/CrossOver/{bin,lib,share}`.
- **Sparkle 2.4.1** cuida das atualizações (`CXUpdater`, `CXSparkleUserDriver`).
- **CrossTie** (`CrossTieURLHandler`, `LoadingCrossTieSheetController`) é o formato de receitas de instalação.

## Estrutura

```
CrossOver/decompiled/
├── INDEX.md            # todas as procedures por classe, com endereço
├── objc_methods.json   # classe -> [(endereço, seletor)]
├── classes/*.m         # pseudocódigo por classe (Hopper)
└── .ingest.py          # converte a saída do REA batch_decompile em classes/*.m
```

## Como reproduzir

1. Conceda a permissão *Automation → Hopper Disassembler* ao app que roda o REA.
2. `open_binary` no binário, depois `list_procedures`.
3. Rode `batch_decompile` em lotes de endereços e passe cada saída para `python3 CrossOver/decompiled/.ingest.py <saida.json>`.
