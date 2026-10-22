# runtime/scripts/common.sh — ambiente compartilhado do build do runtime.
#
# O runtime é x86_64: os programas Windows rodam sob Rosetta 2, então o lado
# Unix do Wine e todas as bibliotecas que ele carrega precisam ser x86_64. O
# compilador nativo (arm64) gera x86_64 com `-arch x86_64`; os programas de
# teste que o configure executa rodam via Rosetta de forma transparente.
#
# Nada aqui aponta para /opt/homebrew/lib: o Homebrew arm64 só fornece
# ferramentas de build (bison, mingw-w64, meson, ninja, pkgconf), nunca
# bibliotecas, porque as dele são arm64.

set -euo pipefail

RUNTIME_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
WORK=${WORK:-$RUNTIME_DIR/.work}
DL=$WORK/dl
SRC=$WORK/src/sources          # fonte LGPL da CodeWeavers, extraído
BUILD=$WORK/build
DEPS=$WORK/deps                # prefixo das bibliotecas x86_64
STAGE=$WORK/stage              # Wine instalado (make install)
TOOLCHAIN=$WORK/toolchain
OUT=${OUT:-$RUNTIME_DIR/out/CrossThroughRuntime}
JOBS=${JOBS:-$(sysctl -n hw.ncpu)}
HOST=x86_64-apple-darwin

# macOS 12 é o mínimo que o SDK/Xcode atuais aceitam para os projetos Xcode
# (MoltenVK); o runtime inteiro usa o mesmo alvo.
export MACOSX_DEPLOYMENT_TARGET=${MACOSX_DEPLOYMENT_TARGET:-12.0}

# Comprimento máximo do caminho onde o runtime pode ser instalado. O Wine guarda
# caminhos de DOS (Z:\...) em buffers de MAX_PATH (260); o mais longo que ele
# monta a partir do runtime é o do pacote de suporte do Mono
# (share\wine\mono\wine-mono-<versão>\support\winemono-support.msi), que
# estoura acima de ~195 caracteres. 150 deixa folga para os demais. O app
# confere este valor (runtime.json) e o relocation.sh testa no limite exato.
RUNTIME_PATH_MAX=150

log()  { printf '\033[1;34m==>\033[0m %s\n' "$*"; }
warn() { printf '\033[1;33maviso:\033[0m %s\n' "$*" >&2; }
die()  { printf '\033[1;31merro:\033[0m %s\n' "$*" >&2; exit 1; }

# Lê um campo do components.lock: lock_field <nome> <campo>
lock_field() {
  awk -v n="$1" -v f="$2" '
    $0 ~ "^\\[" n "\\]$" { on = 1; next }
    /^\[/ { on = 0 }
    on && $1 == f { sub(/^[^=]*= */, ""); print; exit }
  ' "$RUNTIME_DIR/components.lock"
}

# Baixa uma vez e confere o SHA-256 declarado no components.lock.
fetch() {
  local name=$1 url sha file
  url=$(lock_field "$name" url)
  sha=$(lock_field "$name" sha256)
  [ -n "$url" ] || die "components.lock não tem url para [$name]"
  file=$(lock_field "$name" file)
  file=$DL/${file:-$(basename "$url")}
  mkdir -p "$DL"
  if [ ! -f "$file" ]; then
    log "Baixando $name: $url" >&2
    curl -fsSL --retry 3 -o "$file.part" "$url"
    mv "$file.part" "$file"
  fi
  if [ -n "$sha" ]; then
    local got
    got=$(shasum -a 256 "$file" | awk '{print $1}')
    [ "$got" = "$sha" ] || die "SHA-256 de $file não confere (esperado $sha, obtido $got)"
  fi
  printf '%s\n' "$file"
}

# Fonte da CodeWeavers extraído em $SRC.
ensure_sources() {
  [ -f "$SRC/wine/VERSION" ] && return 0
  local tarball
  tarball=$(fetch crossover-sources)
  log "Extraindo o fonte LGPL da CodeWeavers"
  mkdir -p "$WORK/src"
  tar -xzf "$tarball" -C "$WORK/src"
}

# Compiladores x86_64 que rodam nativamente (arm64). Sem estes wrappers, um
# configure executado sob `arch -x86_64` rodaria o clang inteiro no Rosetta.
ensure_toolchain() {
  mkdir -p "$TOOLCHAIN/bin"
  local t
  for t in cc:clang c++:clang++ clang:clang clang++:clang++; do
    local name=${t%%:*} real=${t##*:}
    cat > "$TOOLCHAIN/bin/$name" <<EOF
#!/bin/sh
exec /usr/bin/arch -arm64 /usr/bin/$real -arch x86_64 "\$@"
EOF
    chmod +x "$TOOLCHAIN/bin/$name"
  done
}

# Ambiente para compilar código Unix x86_64 contra $DEPS.
x86_env() {
  ensure_toolchain
  local bison_bin
  bison_bin=$(brew --prefix bison 2>/dev/null)/bin
  export PATH="$TOOLCHAIN/bin:$bison_bin:$DEPS/bin:/opt/homebrew/bin:/usr/bin:/bin:/usr/sbin:/sbin"
  export CC="$TOOLCHAIN/bin/cc" CXX="$TOOLCHAIN/bin/c++"
  export CPPFLAGS="-I$DEPS/include"
  export CFLAGS="-O2 -g0"
  export CXXFLAGS="-O2 -g0"
  export LDFLAGS="-L$DEPS/lib -Wl,-headerpad_max_install_names"
  # Só os .pc das nossas bibliotecas x86_64, nunca os do Homebrew arm64.
  export PKG_CONFIG_LIBDIR="$DEPS/lib/pkgconfig"
  export PKG_CONFIG_PATH="$DEPS/lib/pkgconfig"
  unset PKG_CONFIG_SYSROOT_DIR || true
}

# Cópia do fonte com os patches de runtime/patches/<nome>/ aplicados, em ordem.
# O fonte extraído em $SRC nunca é modificado. Imprime o caminho da cópia.
# A cópia é um clone APFS (instantâneo) com as datas preservadas: num build
# retomado, o make só recompila o que os patches tocam.
patched_tree() {
  local name=$1 src=$2 p
  local dst=$BUILD/$name-src
  rm -rf "$dst"; mkdir -p "$BUILD"
  if ! cp -cRp "$src" "$dst" 2>/dev/null; then
    rm -rf "$dst"; cp -Rp "$src" "$dst"
  fi
  for p in "$RUNTIME_DIR/patches/$name"/*.patch; do
    [ -f "$p" ] || continue
    ( cd "$dst" && patch -p1 --forward --quiet < "$p" ) >&2 || die "patch $(basename "$p") não aplicou em $name"
    log "$name: patch $(basename "$p")" >&2
  done
  printf '%s\n' "$dst"
}

# Marca de etapa concluída, para o build ser retomável.
stamp_done() { [ -f "$WORK/stamps/$1" ]; }
stamp()      { mkdir -p "$WORK/stamps"; touch "$WORK/stamps/$1"; }
