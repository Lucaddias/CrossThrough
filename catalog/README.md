# Catálogo de receitas

`catalog.json` diz ao CrossThrough como instalar cada programa numa bottle:
que bottle criar, quais dependências do winetricks pôr, o que baixar e como
rodar o instalador. O app e o CLI leem o mesmo arquivo:

```bash
crossthrough catalog
```

```bash
crossthrough install 7zip
```

O catálogo não guarda nenhum programa. Cada receita aponta para o instalador
oficial, no site de quem o distribui, e fixa o SHA-256 do arquivo.

## Formato

```json
{
  "formatVersion": 1,
  "recipes": [
    {
      "id": "7zip",
      "name": "7-Zip",
      "summary": "Compactador de arquivos: 7z, zip, rar, tar, iso e outros.",
      "category": "utilities",
      "homepage": "https://www.7-zip.org",
      "license": "LGPL-2.1+",
      "download": {"url": "https://www.7-zip.org/a/7z2605-x64.exe", "sha256": "fd99e8…"},
      "install": {"type": "run", "arguments": ["/S"]}
    }
  ]
}
```

| Campo | Obrigatório | O que é |
|---|---|---|
| `id` | sim | identificador estável: `a-z`, `0-9` e hífen |
| `name`, `summary` | sim | nome e uma linha de descrição, em português |
| `category` | sim | `games`, `launchers`, `productivity`, `utilities`, `development`, `multimedia` ou `internet` |
| `homepage`, `license` | não | site do programa e licença, para o usuário saber o que instala |
| `bottle` | não | configuração da bottle nova: `windowsVersion` (`win11` … `winxp`), `graphics` (`dxmt`, `dxvk`, `wined3d`), `msync`, `environment`, `dllOverrides` |
| `winetricks` | não | verbos instalados antes do programa, na ordem (ex.: `["vcrun2022", "corefonts"]`) |
| `download` | se `install` não for `none` | `url` (HTTPS), `sha256` e, se a URL não terminar no nome do arquivo, `fileName` |
| `install` | não (padrão `none`) | veja abaixo |
| `shortcut` | não | atalho criado no Menu Iniciar ao final: `name`, `target` (caminho Windows), `arguments`, `workingDirectory` |
| `notes` | não | aviso para o usuário (limitações conhecidas no Wine) |

Tipos de `install`:

| `type` | Campos | O que acontece |
|---|---|---|
| `run` | `arguments` | roda o `.exe` baixado; use os argumentos de instalação silenciosa (`/S`, `/VERYSILENT`, …) |
| `msi` | `arguments` | `msiexec /i <arquivo> <arguments>` (ex.: `["/qn"]`) |
| `extract` | `destination`, `stripTopLevel` | extrai um `.zip` em `destination` (caminho Windows); com `stripTopLevel`, a pasta única do zip some |
| `none` | | só o winetricks |

O instalador aceita os códigos de saída 0, 1641 e 3010 (os dois últimos são
"reinício necessário" do Windows Installer, que numa bottle não se aplica).
Depois do instalador, o CrossThrough espera todos os processos da bottle
terminarem, então instaladores que relançam a si mesmos funcionam.

## Regras para entrar no catálogo do projeto

- A receita foi instalada e o programa foi aberto de verdade com o runtime do
  projeto, numa bottle nova, antes de entrar.
- `download.sha256` sempre presente: uma versão nova do programa é uma receita
  atualizada (URL e SHA-256), testada de novo.
- Download só por HTTPS, do distribuidor oficial.
- O teste `swift test` (em `app/`) valida o arquivo: ids, campos, SHA-256 e os
  verbos do winetricks do runtime.

Para testar outro catálogo sem trocar o do app:

```bash
CROSSTHROUGH_CATALOG=/caminho/catalog.json crossthrough catalog
```
