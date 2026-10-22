#!/bin/bash
# vendor/setup.sh — popula vendor/ para o CrossThrough compilar e empacotar sem
# que o Makefile aponte diretamente para /Applications/CrossOver.app. Depois
# desta etapa, o ÚNICO lugar que conhece o caminho do app de referência é este
# script, pela variável CROSSOVER_APP.
#
# Três artefatos, cada um idempotente (pula se já estiver em vendor/):
#
#   1. Frameworks/Python.framework — o CrossThrough liga contra o Python
#      embarcado (C-API) e os .pyc do backend são bytecode CPython 3.13, então o
#      framework TEM de ser 3.13. Fontes, nesta ordem:
#        a. Upstream (independente): framework oficial do python.org 3.13 +
#           PyObjC 11. Defina PYTHON_313_PKG_URL para o .pkg macOS desejado.
#        b. Bootstrap de desenvolvimento: copia o Python.framework de um
#           CrossOver instalado (CROSSOVER_APP). Atalho; não é independência.
#
#   2. SharedSupport — o backend (Wine x86_64, ferramentas Perl, lib Python). É o
#      componente pesado (~930M) e, por ora, vem do host: por padrão um symlink
#      para CROSSOVER_APP/Contents/SharedSupport (bootstrap). A independência de
#      verdade substitui isto por um Wine reconstruído do fonte LGPL — veja o
#      INDEPENDENCE-PLAN. Defina VENDOR_SHAREDSUPPORT_MODE=copy para um snapshot
#      copiado (desacopla do app, porém ~930M em disco).
#
#   3. Resources — nibs, Assets.car, ícones e strings da GUI (~19M). Copiados do
#      host (bootstrap), até serem reconstruídos como Cocoa em código.
#
# Sparkle não é mais necessário: o CrossThrough não busca atualização pela rede e
# liga com um SparkleCompat local (src/classes/SparkleCompat.m).
set -euo pipefail

HERE=$(cd "$(dirname "$0")" && pwd)
DEST="$HERE/Frameworks"
DEST_SS="$HERE/SharedSupport"
DEST_RES="$HERE/Resources"
CROSSOVER_APP=${CROSSOVER_APP:-/Applications/CrossOver.app}
PYTHON_313_PKG_URL=${PYTHON_313_PKG_URL:-https://www.python.org/ftp/python/3.13.1/python-3.13.1-macos11.pkg}
VENDOR_SHAREDSUPPORT_MODE=${VENDOR_SHAREDSUPPORT_MODE:-link}

# Fase 2: dados redistribuíveis do upstream (Gecko + Mono), em vez do host.
# Opt-in (VENDOR_UPSTREAM_DATA=1) porque são ~125 MB de download; só faz sentido
# quando SharedSupport é um snapshot copiado (VENDOR_SHAREDSUPPORT_MODE=copy).
# VENDOR_UPSTREAM_DRY=1 valida as URLs sem baixar. Veja vendor/UPSTREAM.md.
VENDOR_UPSTREAM_DATA=${VENDOR_UPSTREAM_DATA:-0}
VENDOR_UPSTREAM_DRY=${VENDOR_UPSTREAM_DRY:-0}
GECKO_VERSION=${GECKO_VERSION:-2.47.4}
MONO_VERSION=${MONO_VERSION:-10.4.1}
GECKO_BASE_URL=${GECKO_BASE_URL:-https://dl.winehq.org/wine/wine-gecko/$GECKO_VERSION}
MONO_URL=${MONO_URL:-https://github.com/wine-mono/wine-mono/releases/download/wine-mono-$MONO_VERSION/wine-mono-$MONO_VERSION-x86.tar.xz}

mkdir -p "$DEST"

# ---------------------------------------------------------------------------
# 1. Python.framework
# ---------------------------------------------------------------------------
fetch_python_upstream() {
  command -v curl >/dev/null || return 1
  local tmp
  tmp=$(mktemp -d -t crossthrough-python)
  echo "==> Baixando Python 3.13 de $PYTHON_313_PKG_URL"
  curl -fL --retry 2 -o "$tmp/python.pkg" "$PYTHON_313_PKG_URL" || { rm -rf "$tmp"; return 1; }
  echo "==> Extraindo o framework do .pkg"
  pkgutil --expand-full "$tmp/python.pkg" "$tmp/expanded" || { rm -rf "$tmp"; return 1; }
  local fw
  fw=$(find "$tmp/expanded" -type d -name Python.framework -print -quit)
  [ -n "$fw" ] || { rm -rf "$tmp"; return 1; }
  cp -R "$fw" "$DEST/Python.framework"
  rm -rf "$tmp"
  echo "==> Instalando PyObjC 11 no framework vendorizado"
  local py="$DEST/Python.framework/Versions/3.13/bin/python3.13"
  if [ -x "$py" ]; then
    "$py" -m pip install --upgrade pip >/dev/null 2>&1 || true
    "$py" -m pip install "pyobjc==11.0" >/dev/null 2>&1 || \
      echo "    aviso: pip install pyobjc falhou; instale manualmente no framework."
  fi
  return 0
}

bootstrap_python_from_crossover() {
  local src="$CROSSOVER_APP/Contents/Frameworks/Python.framework"
  [ -d "$src" ] || return 1
  echo "==> BOOTSTRAP: copiando Python.framework de $CROSSOVER_APP"
  echo "    (atalho de desenvolvimento; troque por um framework upstream para"
  echo "     independência real — veja o passo 1a no topo deste script)"
  cp -R "$src" "$DEST/Python.framework"
  return 0
}

setup_python() {
  if [ -d "$DEST/Python.framework" ]; then
    echo "==> Python.framework já está em vendor/Frameworks. Nada a fazer."
    return 0
  fi
  if fetch_python_upstream; then
    echo "==> Python 3.13 upstream pronto em vendor/Frameworks."
  elif bootstrap_python_from_crossover; then
    echo "==> Python 3.13 (bootstrap do CrossOver) pronto em vendor/Frameworks."
  else
    echo "ERRO: não consegui obter o Python.framework 3.13." >&2
    echo "Defina PYTHON_313_PKG_URL (upstream) ou CROSSOVER_APP (bootstrap)." >&2
    exit 1
  fi
}

# ---------------------------------------------------------------------------
# 2. SharedSupport (backend Wine + Perl + Python lib)
# ---------------------------------------------------------------------------
setup_sharedsupport() {
  # Existe (dir real ou symlink)? Nada a fazer.
  if [ -e "$DEST_SS" ] || [ -L "$DEST_SS" ]; then
    echo "==> vendor/SharedSupport já existe. Nada a fazer."
    return 0
  fi
  local src="$CROSSOVER_APP/Contents/SharedSupport"
  if [ ! -d "$src" ]; then
    echo "aviso: SharedSupport não encontrado em $CROSSOVER_APP; o app compila" >&2
    echo "       mas não roda bottles. Defina CROSSOVER_APP ou forneça um Wine" >&2
    echo "       reconstruído em vendor/SharedSupport." >&2
    return 0
  fi
  if [ "$VENDOR_SHAREDSUPPORT_MODE" = "copy" ]; then
    echo "==> BOOTSTRAP: copiando SharedSupport (~930M) de $CROSSOVER_APP"
    cp -R "$src" "$DEST_SS"
  else
    echo "==> BOOTSTRAP: vendor/SharedSupport -> $src (symlink)"
    echo "    (atalho; VENDOR_SHAREDSUPPORT_MODE=copy faz um snapshot copiado)"
    ln -s "$src" "$DEST_SS"
  fi
  return 0
}

# ---------------------------------------------------------------------------
# 3. Resources (nibs, Assets.car, ícones, strings da GUI)
# ---------------------------------------------------------------------------
setup_resources() {
  if [ -e "$DEST_RES" ] || [ -L "$DEST_RES" ]; then
    echo "==> vendor/Resources já existe. Nada a fazer."
    return 0
  fi
  local src="$CROSSOVER_APP/Contents/Resources"
  if [ ! -d "$src" ]; then
    echo "aviso: Resources não encontrados em $CROSSOVER_APP; a interface não" >&2
    echo "       carregará. Defina CROSSOVER_APP ou forneça os nibs em" >&2
    echo "       vendor/Resources." >&2
    return 0
  fi
  echo "==> BOOTSTRAP: copiando Resources (~19M) de $CROSSOVER_APP"
  cp -R "$src" "$DEST_RES"
  return 0
}

# ---------------------------------------------------------------------------
# 4. (Fase 2, opt-in) Dados redistribuíveis do upstream: Gecko + Mono
# ---------------------------------------------------------------------------
upstream_probe() { # url -> imprime tamanho; retorna !=0 se não resolver
  local url="$1" len
  len=$(curl -sIL -m 30 "$url" | grep -i '^content-length:' | tail -1 | tr -dc '0-9')
  [ -n "$len" ] || return 1
  echo "    $url  (~$((len / 1024 / 1024)) MB)"
}

fetch_and_extract() { # url dest_dir
  local url="$1" dest="$2" tmp
  tmp=$(mktemp -d -t crossthrough-upstream)
  echo "==> Baixando $url"
  curl -fL --retry 2 -o "$tmp/pkg.tar.xz" "$url" || { rm -rf "$tmp"; return 1; }
  mkdir -p "$dest"
  tar -xJf "$tmp/pkg.tar.xz" -C "$dest" || { rm -rf "$tmp"; return 1; }
  rm -rf "$tmp"
}

setup_upstream_data() {
  [ "$VENDOR_UPSTREAM_DATA" = "1" ] || return 0
  local gecko_dir="$DEST_SS/share/wine/gecko"
  local mono_dir="$DEST_SS/share/wine/mono"

  if [ "$VENDOR_UPSTREAM_DRY" = "1" ]; then
    echo "==> [dry] validando URLs de upstream (Gecko $GECKO_VERSION, Mono $MONO_VERSION):"
    upstream_probe "$GECKO_BASE_URL/wine-gecko-$GECKO_VERSION-x86.tar.xz" || echo "    FALHA: Gecko x86"
    upstream_probe "$GECKO_BASE_URL/wine-gecko-$GECKO_VERSION-x86_64.tar.xz" || echo "    FALHA: Gecko x86_64"
    upstream_probe "$MONO_URL" || echo "    FALHA: Mono"
    return 0
  fi

  # Só faz sentido sobrepor num SharedSupport copiado (não no symlink do host).
  if [ ! -d "$DEST_SS" ] || [ -L "$DEST_SS" ]; then
    echo "aviso: VENDOR_UPSTREAM_DATA=1 requer um SharedSupport copiado" >&2
    echo "       (VENDOR_SHAREDSUPPORT_MODE=copy); pulando o overlay de Gecko/Mono." >&2
    return 0
  fi

  echo "==> Substituindo Gecko pelo upstream $GECKO_VERSION"
  rm -rf "$gecko_dir"
  fetch_and_extract "$GECKO_BASE_URL/wine-gecko-$GECKO_VERSION-x86.tar.xz" "$gecko_dir"
  fetch_and_extract "$GECKO_BASE_URL/wine-gecko-$GECKO_VERSION-x86_64.tar.xz" "$gecko_dir"
  echo "==> Substituindo Mono pelo upstream $MONO_VERSION"
  rm -rf "$mono_dir"
  fetch_and_extract "$MONO_URL" "$mono_dir"
}

setup_python
setup_sharedsupport
setup_resources
setup_upstream_data
