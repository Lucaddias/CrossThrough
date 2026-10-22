#!/bin/bash
# vendor/build-wine.sh — compila o motor Wine 11.0 do fonte da CodeWeavers e o
# instala em vendor/SharedSupport, para a Fase 2 da independência: o backend vem
# do upstream, não de /Applications/CrossOver.app.
#
# Fonte: o tarball OFICIAL do CrossOver 26.3 (LGPL), apontado pelo license.txt do
# próprio app (https://www.codeweavers.com/crossover/source). É o Wine exato a
# partir do qual o backend analisado foi gerado — ver vendor/UPSTREAM.md.
#
#   crossover-sources-26.3.0.tar.gz  ->  sources/wine  (Wine version 11.0)
#
# ESCOPO. Este script fornece o MOTOR Wine (bin/wine*, lib/wine, share/wine). A
# cola própria da CodeWeavers (ferramentas Perl cx*, o `wineloader` nativo, os
# helpers) é reconstruída em outros pontos do projeto (native/, sharedsupport/).
# DXVK e DXMT são componentes à parte (DXMT/winemetal não está neste tarball;
# ver UPSTREAM.md). O build do Wine é PESADO (toolchain + dezenas de minutos) e
# não roda no fluxo normal de `make`; invoque este script manualmente.
#
# Uso:
#   bash vendor/build-wine.sh --check     # só pré-requisitos + URL (não compila)
#   bash vendor/build-wine.sh             # baixa, compila e instala em vendor/
#   bash vendor/build-wine.sh --jobs 8 --prefix /caminho/stage
#
set -euo pipefail

HERE=$(cd "$(dirname "$0")" && pwd)
DEST_SS="$HERE/SharedSupport"
WORK=${WORK:-$HERE/.build-wine}
SRC_URL=${XO_SOURCE_URL:-https://media.codeweavers.com/pub/crossover/source/crossover-sources-26.3.0.tar.gz}
WINE_VERSION_EXPECTED="11.0"
# CrossOver roda apps 32 e 64-bit (ver lib/dxvk/{i386,x86_64}-windows); o Wine
# novo usa WoW64 com as duas arquiteturas PE.
WINE_ARCHS=${WINE_ARCHS:-i386,x86_64}
JOBS=${JOBS:-$(sysctl -n hw.ncpu 2>/dev/null || echo 4)}
PREFIX=${PREFIX:-$WORK/stage}
MODE=build

while [ $# -gt 0 ]; do
  case "$1" in
    --check) MODE=check ;;
    --jobs) JOBS="$2"; shift ;;
    --prefix) PREFIX="$2"; shift ;;
    *) echo "argumento desconhecido: $1" >&2; exit 2 ;;
  esac
  shift
done

# --- pré-requisitos -------------------------------------------------------
BREW_PKGS="bison flex mingw-w64 pkgconf gnutls freetype"
check_prereqs() {
  local missing=0
  echo "==> Verificando pré-requisitos"
  xcode-select -p >/dev/null 2>&1 && echo "    ok: Xcode Command Line Tools" || {
    echo "    FALTA: Xcode CLT (xcode-select --install)"; missing=1; }
  if command -v brew >/dev/null 2>&1; then
    echo "    ok: Homebrew"
    local p
    for p in $BREW_PKGS; do
      if brew list --versions "$p" >/dev/null 2>&1; then
        echo "    ok: $p"
      else
        echo "    FALTA: $p  (brew install $p)"; missing=1
      fi
    done
  else
    echo "    FALTA: Homebrew — necessário para $BREW_PKGS"; missing=1
  fi
  return $missing
}

probe_source() {
  echo "==> Fonte: $SRC_URL"
  local len
  len=$(curl -sIL -m 30 "$SRC_URL" | grep -i '^content-length:' | tail -1 | tr -dc '0-9')
  if [ -n "$len" ]; then
    echo "    ok: resolve (~$((len / 1024 / 1024)) MB)"
  else
    echo "    FALHA: a URL do fonte não resolveu"; return 1
  fi
}

# --- download + extração --------------------------------------------------
fetch_and_unpack() {
  mkdir -p "$WORK"
  local tarball="$WORK/crossover-sources.tar.gz"
  if [ ! -f "$tarball" ]; then
    echo "==> Baixando o fonte do CrossOver 26.3"
    curl -fL --retry 2 -o "$tarball" "$SRC_URL"
  else
    echo "==> Tarball já baixado em $tarball"
  fi
  if [ ! -d "$WORK/sources/wine" ]; then
    echo "==> Extraindo sources/wine"
    tar -xzf "$tarball" -C "$WORK" sources/wine
  fi
  local v
  v=$(cat "$WORK/sources/wine/VERSION" 2>/dev/null | grep -oE "[0-9]+\.[0-9]+" | head -1)
  echo "==> Wine no fonte: ${v:-?} (esperado $WINE_VERSION_EXPECTED)"
  [ "$v" = "$WINE_VERSION_EXPECTED" ] || echo "    aviso: versão diferente do esperado."
}

# --- build + install ------------------------------------------------------
build_wine() {
  local srcdir="$WORK/sources/wine" builddir="$WORK/build"
  mkdir -p "$builddir"
  echo "==> configure (archs=$WINE_ARCHS, prefix=$PREFIX)"
  ( cd "$builddir" && "$srcdir/configure" \
      --prefix="$PREFIX" \
      --enable-archs="$WINE_ARCHS" \
      --without-x )
  echo "==> make -j$JOBS (demorado)"
  ( cd "$builddir" && make -j"$JOBS" )
  echo "==> make install"
  ( cd "$builddir" && make install )
}

# Mapeia o prefixo instalado pelo Wine para o layout de SharedSupport/CrossOver.
install_into_vendor() {
  if [ ! -d "$DEST_SS" ] || [ -L "$DEST_SS" ]; then
    echo "aviso: vendor/SharedSupport não é um diretório copiado" >&2
    echo "       (rode setup.sh com VENDOR_SHAREDSUPPORT_MODE=copy antes); o" >&2
    echo "       motor Wine ficou em $PREFIX, mas não foi mesclado ao backend." >&2
    return 0
  fi
  echo "==> Mesclando o Wine compilado em vendor/SharedSupport"
  # Wine instala em <prefix>/{bin,lib/wine,share/wine}. O backend do CrossOver usa
  # bin (ferramentas), lib/wine + lib64 e share/wine. Copiamos o motor; a cola
  # Perl/nativa não é tocada.
  [ -d "$PREFIX/lib/wine" ]   && { rm -rf "$DEST_SS/CrossOver/lib/wine";   cp -R "$PREFIX/lib/wine"   "$DEST_SS/CrossOver/lib/wine"; }
  [ -d "$PREFIX/share/wine" ] && { rm -rf "$DEST_SS/CrossOver/share/wine"; cp -R "$PREFIX/share/wine" "$DEST_SS/CrossOver/share/wine"; }
  echo "    motor Wine mesclado. bin/wine* e lib64 seguem a cola do projeto."
}

if [ "$MODE" = "check" ]; then
  rc=0
  check_prereqs || rc=1
  probe_source || rc=1
  if [ "$rc" = 0 ]; then echo "==> check OK: pronto para compilar."; else echo "==> check: resolva os itens FALTA acima." >&2; fi
  exit $rc
fi

check_prereqs || { echo "ERRO: pré-requisitos ausentes (rode com --check)." >&2; exit 1; }
fetch_and_unpack
build_wine
install_into_vendor
echo "==> Concluído. Wine 11.0 instalado a partir do fonte CodeWeavers."
