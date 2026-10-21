#!/bin/bash
# vendor/setup.sh — popula vendor/Frameworks para o CrossThrough compilar e
# rodar sem depender do caminho /Applications/CrossOver.app.
#
# O CrossThrough liga contra o Python embarcado (C-API). Em tempo de execução,
# os módulos .pyc do backend são bytecode CPython 3.13, então o framework
# vendorizado TEM de ser 3.13.
#
# Duas fontes, nesta ordem:
#   1. Upstream (independente): framework oficial do python.org 3.13 + PyObjC 11.
#      Defina PYTHON_313_PKG_URL para apontar o .pkg macOS desejado.
#   2. Bootstrap de desenvolvimento: copia o Python.framework de um CrossOver
#      instalado (CROSSOVER_APP). É um atalho para destravar o build; não é
#      independência de verdade. O passo 1 é o objetivo.
#
# Sparkle não é mais necessário: o CrossThrough não busca atualização pela
# rede e liga com um SparkleCompat local (src/classes/SparkleCompat.m).
set -euo pipefail

HERE=$(cd "$(dirname "$0")" && pwd)
DEST="$HERE/Frameworks"
CROSSOVER_APP=${CROSSOVER_APP:-/Applications/CrossOver.app}
PYTHON_313_PKG_URL=${PYTHON_313_PKG_URL:-https://www.python.org/ftp/python/3.13.1/python-3.13.1-macos11.pkg}

mkdir -p "$DEST"

if [ -d "$DEST/Python.framework" ]; then
  echo "==> Python.framework já está em vendor/Frameworks. Nada a fazer."
  exit 0
fi

fetch_upstream() {
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

bootstrap_from_crossover() {
  local src="$CROSSOVER_APP/Contents/Frameworks/Python.framework"
  [ -d "$src" ] || return 1
  echo "==> BOOTSTRAP: copiando Python.framework de $CROSSOVER_APP"
  echo "    (atalho de desenvolvimento; troque por um framework upstream para"
  echo "     independência real — veja o passo 1 no topo deste script)"
  cp -R "$src" "$DEST/Python.framework"
  return 0
}

if fetch_upstream; then
  echo "==> Python 3.13 upstream pronto em vendor/Frameworks."
elif bootstrap_from_crossover; then
  echo "==> Python 3.13 (bootstrap do CrossOver) pronto em vendor/Frameworks."
else
  echo "ERRO: não consegui obter o Python.framework 3.13." >&2
  echo "Defina PYTHON_313_PKG_URL (upstream) ou CROSSOVER_APP (bootstrap)." >&2
  exit 1
fi
