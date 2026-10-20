# Slice x86_64 × arm64

Mapeamento e comparação das duas slices de `Contents/MacOS/CrossOver` (CrossOver 26.3).

| Slice | Offset no universal | Tamanho | SHA-256 (`lipo -thin`) |
|---|---|---|---|
| x86_64 | 16384 | 1.156.192 | `441318a33bc9a3e1ebc12f8d9719396e129052c3c251bb131c524697c299103c` |
| arm64 | 1179648 | 1.243.232 | `2d68c5f82665e189c0dbd2d9985ec583fffcd199c468d7931527d377de443150` |

## Resultado

| Métrica | x86_64 | arm64 |
|---|---|---|
| Funções em `__TEXT,__text` (tabela de símbolos) | 2288 | 2288 |
| Pareadas por nome | 2287 | 2287 |
| Pareadas com as mesmas referências | 2281 | 2281 |
| Pareadas com referências diferentes | 6 | 6 |
| Exclusivas da slice | 1 (`_CopyBundle`) | 1 (`-[CXServer rosettaCheck]`) |
| Bytes de código das funções pareadas | 490.583 | 392.496 |

As duas slices saem do mesmo código-fonte. As diferenças reais são poucas e quase todas vêm de `#if` por arquitetura ou de decisões do compilador:

1. **`-[CXServer rosettaCheck]` só existe na arm64.** `applicationWillFinishLaunching:` chama esse método só na arm64. Em macOS ≥ 11 (`__isPlatformVersionAtLeast(1, 11, 0, 0)`), ele chama `CFBundleIsArchitectureLoadable(0x01000007 /* CPU_TYPE_X86_64 */)`, registra `"Running as ARM64: Rosetta is %s.\n"` com `"installed"`/`"not installed"` e, se o Rosetta 2 não estiver instalado, abre `RosettaInstallationController` como janela modal. A string e a CFString desse log também só existem na arm64.
2. **`-[RunCommandController supportsAVX]` muda de comportamento.** Na arm64 retorna `YES` somente em macOS ≥ 15 (`__isPlatformVersionAtLeast(1, 15, 0, 0)`). Na x86_64 é `xor eax, eax; ret`, ou seja, sempre `NO`. O método não tem chamadores no código; o seletor aparece em `RunCommand.nib` e `RunCommandLauncherModeView.nib` (binding de interface). A ação ligada a essa opção, `AVXSelected:`, acrescenta `ROSETTA_ADVERTISE_AVX=0` ao ambiente do comando.
3. **`_CopyBundle` (LetsMove) só existe como função na x86_64.** Na arm64 ele foi inlinado em `_PFMoveToApplicationsFolderIfNecessary`. A união das referências de `PFMoveToApplicationsFolderIfNecessary` e `CopyBundle` na x86_64 é igual às referências da função arm64: `FSPathCopyObjectSync`, `fileSystemRepresentation`, `stringByDeletingLastPathComponent`, `lastPathComponent` e `NSLog(@"ERROR -- Could not copy '%@' to '%@' (%d)")`.
4. **Diferenças só de ABI:**
   - `lstat$INODE64` / `statfs$INODE64` na x86_64 contra `lstat` / `statfs` na arm64 (`stringByIterativelyResolvingSymlinkOrAlias`, `_IsLaunchedFromDMG`);
   - `BOOL` é `signed char` (`c`) na x86_64 e `_Bool` (`B`) na arm64. Isso muda as codificações de tipo (`__objc_methtype`, atributos de propriedade `Tc,…`/`TB,…`, descritores de bloco) e a string `"c"`/`"B"` passada a `class_addMethod` no bloco de `+[InstallConfiguration resolveInstanceMethod:]`;
   - só a x86_64 importa `objc_msgSend_stret` / `objc_msgSendSuper2_stret`, usados por 30 funções que retornam structs (`NSRect`, `NSSize`, `NSEdgeInsets`…);
   - a arm64 usa `__objc_stubs` (2037 trampolins `objc_msgSend$seletor`) e listas de métodos relativas em `__objc_methlist`. A x86_64 carrega o seletor de `__objc_selrefs` e chama `objc_msgSend` pela GOT, com listas de métodos absolutas em `__objc_const`;
   - na x86_64 os offsets de ivar ocupam 8 bytes (`__objc_ivar` = 0x1038), na arm64 ocupam 4 (0x81c). São 519 ivars nas duas.
5. **Nomes de blocos.** 18 blocos têm sufixos numéricos diferentes (`_block_invoke.122` contra `_block_invoke.42`). São contadores gerados pelo compilador; o pareamento remove o sufixo e respeita a ordem de ocorrência.

## Arquivos

| Arquivo | Conteúdo |
|---|---|
| [`map.json`](map.json) | Todas as funções: nome, endereço e tamanho em cada slice, e se as referências batem |
| [`reference_diffs.json`](reference_diffs.json) | As 6 funções pareadas com referências diferentes, com o delta por categoria |
| [`data_diffs.json`](data_diffs.json) | Strings, CFStrings, seletores, nomes de classe, tipos ObjC e imports exclusivos de cada slice, mais a tabela de seções |
| [`diff_functions.asm`](diff_functions.asm) | Desmontagem anotada (seletor, import, string) das funções exclusivas ou divergentes |
| [`.slicediff.py`](.slicediff.py) | Script que gera todos os arquivos acima |

## Método

- Evidence REA (`inspect_with_objdump`):
  - símbolos x86_64 `ev_6ba3de9f947294b9e583fd8674762d3655119030ef63aaa724870f27763942f6`;
  - símbolos arm64 `ev_cf0a8ece47829327ea679825b4a84077848440440afa72c6878a5b9b5c616f96`;
  - desmontagem x86_64 `ev_3e3af8da6fe5694dc184791c4755683894ac5bc4da3caf95a840fd1ca902a343`;
  - desmontagem arm64 `ev_be740f96d13b18f1147404d9cca0dc483fac76d20283b87339857ccc3eb23143`.

  A saída completa foi exportada com `export_evidence_bundle` (passou do limite de transporte do MCP).
- Slices: `list_architectures` (`ev_e189162f704a2531f8bed1ccd87ba220e573c31dd33609547c445cb5574eb09d`). Os arquivos thin foram extraídos com `lipo -thin`.
- O binário mantém os símbolos locais, então o pareamento é por nome, sem heurística de similaridade.
- O `objdump` deixa referências sem símbolo. `.slicediff.py` lê o Mach-O (tabela indireta, opcodes de bind, `__objc_selrefs`, `__cfstring`, `class_ro_t`) só para dar nome a esses endereços.
- Na x86_64 os alvos RIP-relativos são exatos. Na arm64 os alvos vêm de pares `adrp`+`add`/`ldr`. Uma referência só conta como "exclusiva da x86_64" se faltar até na leitura linear da arm64, e só conta como "exclusiva da arm64" se aparecer na leitura estrita, restrita a um bloco básico. Isso elimina falsos positivos de registrador herdado de outro bloco.

## Limites

- A comparação é por **conjunto de referências** (seletores, strings, classes, imports, chamadas locais, ivars), não por equivalência semântica. Duas funções com as mesmas referências podem ter fluxo de controle diferente.
- Em 66 funções da x86_64, todas com no máximo 56 bytes (getters/setters de ivar escalar, retornos constantes, helpers de bloco), nenhuma referência foi resolvida. Elas foram pareadas, mas a comparação não diz nada sobre elas.
- Não há pseudocódigo x86_64: o Hopper estava sem permissão de Automação nesta sessão. A arm64 continua sendo a slice descompilada (`../classes`, `../c_functions.c`).
