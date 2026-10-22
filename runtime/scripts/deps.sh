#!/bin/bash
# runtime/scripts/deps.sh — bibliotecas Unix x86_64 que o Wine carrega.
#
#   gmp -> nettle -> gnutls   TLS/criptografia (secur32/schannel, bcrypt, crypt32)
#   freetype                  renderização de fontes TrueType (indispensável)
#
# Tudo vem do fonte LGPL da CodeWeavers e é instalado em $DEPS. Cada etapa é
# retomável: uma marca em $WORK/stamps pula o que já foi feito.
source "$(dirname "$0")/common.sh"

ensure_sources
x86_env
mkdir -p "$BUILD" "$DEPS"

# autotools_build <stamp> <srcdir> [args do configure...]
autotools_build() {
  local name=$1 srcdir=$2; shift 2
  if stamp_done "deps-$name"; then log "$name: já instalado"; return 0; fi
  local b=$BUILD/$name
  rm -rf "$b"; mkdir -p "$b"
  # O tarball traz alguns projetos só com configure.ac (ex.: nettle).
  if [ ! -x "$srcdir/configure" ]; then
    log "$name: gerando configure (autoconf)"
    ( cd "$srcdir" && autoconf && autoheader ) || die "$name: autoconf falhou"
  fi
  log "$name: configure"
  ( cd "$b" && "$srcdir/configure" --prefix="$DEPS" --build=$HOST --host=$HOST \
      --enable-shared --disable-static "$@" ) > "$b/configure.log" 2>&1 \
    || { tail -40 "$b/configure.log"; die "$name: configure falhou ($b/configure.log)"; }
  log "$name: make -j$JOBS"
  ( cd "$b" && make -j"$JOBS" ) > "$b/make.log" 2>&1 \
    || { tail -40 "$b/make.log"; die "$name: make falhou ($b/make.log)"; }
  ( cd "$b" && make install ) > "$b/install.log" 2>&1 \
    || { tail -40 "$b/install.log"; die "$name: make install falhou"; }
  stamp "deps-$name"
}

# GMP: só C + assembly x86_64 genérico (core2), sem detecção da CPU do Rosetta.
autotools_build gmp "$SRC/gnutls/gmp" --disable-cxx

# Nettle: lançamento oficial do GNU (o do tarball veio incompleto).
# --enable-fat escolhe AES-NI/SHA-NI em tempo de execução.
NETTLE_SRC=$WORK/src/nettle-$(lock_field nettle version)
if [ ! -x "$NETTLE_SRC/configure" ]; then
  tar -xzf "$(fetch nettle)" -C "$WORK/src"
fi
autotools_build nettle "$NETTLE_SRC" \
  --enable-fat --disable-documentation --disable-openssl \
  --with-include-path="$DEPS/include" --with-lib-path="$DEPS/lib"

# GnuTLS: libtasn1 e libunistring embutidos; sem p11-kit, IDN, TPM, ferramentas.
# --disable-gost: o configure do 3.8.3 não enxerga o GOST do nettle 3.10 e
# recompila o seu, que colide com o do nettle; schannel não usa GOST.
autotools_build gnutls "$SRC/gnutls/gnutls" \
  --with-included-libtasn1 --with-included-unistring --disable-gost \
  --without-p11-kit --without-idn --without-tpm --without-tpm2 \
  --without-zlib --without-brotli --without-zstd \
  --disable-tools --disable-doc --disable-manpages --disable-tests \
  --disable-cxx --disable-guile --disable-nls --disable-libdane \
  --disable-full-test-suite \
  NETTLE_LIBS=-lnettle HOGWEED_LIBS=-lhogweed GMP_LIBS=-lgmp

# FreeType: lançamento oficial (o do tarball é uma cópia do git, sem configure).
# Só zlib (do sistema); sem HarfBuzz/PNG/bzip2/Brotli.
FREETYPE_SRC=$WORK/src/freetype-$(lock_field freetype version)
if [ ! -x "$FREETYPE_SRC/configure" ]; then
  tar -xJf "$(fetch freetype)" -C "$WORK/src"
fi
autotools_build freetype "$FREETYPE_SRC" \
  --without-harfbuzz --without-png --without-bzip2 --without-brotli --with-zlib=yes

log "Bibliotecas x86_64 prontas em $DEPS/lib:"
ls "$DEPS/lib"/*.dylib | xargs -n1 basename | sed 's/^/    /'
for f in "$DEPS"/lib/*.dylib; do
  [ -L "$f" ] && continue
  arch=$(lipo -archs "$f" 2>/dev/null || true)
  [ "$arch" = "x86_64" ] || die "$f não é x86_64 ($arch)"
done
