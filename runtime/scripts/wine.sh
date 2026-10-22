#!/bin/bash
# runtime/scripts/wine.sh — Wine 11.0 (árvore LGPL da CodeWeavers, com msync).
#
# Compila de uma cópia com os patches de runtime/patches/wine/ (correções de
# bugs que os testes do runtime encontraram; ver o cabeçalho de cada patch).
#
# WoW64 novo: o lado Unix é só x86_64 e os programas 32-bit rodam via DLLs PE
# i386 (--enable-archs=i386,x86_64), que é o único modo possível no macOS
# atual, sem binários Unix de 32 bits. As DLLs PE saem do mingw-w64; o lado
# Unix sai do clang com -arch x86_64.
#
# O OpenGL do macOS (CGL, em winemac.drv) não depende de --with-opengl, que no
# Wine 11 se refere ao EGL dos drivers X11/Wayland.
#
# Recursos que dependem de bibliotecas ainda não empacotadas (GStreamer/FFmpeg
# para mídia, SDL para controles) ficam desligados explicitamente, para o
# resultado não variar conforme o que estiver instalado na máquina.
source "$(dirname "$0")/common.sh"

ensure_sources
WSRC=$(patched_tree wine "$SRC/wine")
x86_env
[ -f "$DEPS/lib/libgnutls.30.dylib" ] || die "rode scripts/deps.sh antes"
[ -f "$DEPS/lib/libMoltenVK.dylib" ]  || die "rode scripts/moltenvk.sh antes"

# Objective-C do winemac.drv também precisa sair x86_64.
export OBJC="$CC" OBJCFLAGS="$CFLAGS"
# DLLs PE (mingw) sem informação de depuração: o padrão "-g -O2" quase dobra o
# tamanho do runtime.
export CROSSCFLAGS="-O2 -g0"
# Os módulos Unix (lib/wine/x86_64-unix/*.so) acham as bibliotecas do runtime
# em lib/ (dois níveis acima) por rpath; o wine em bin/ acha em ../lib.
export LDFLAGS="$LDFLAGS -Wl,-rpath,@loader_path/../../ -Wl,-rpath,@loader_path/../lib"
# GnuTLS e FreeType vêm do nosso prefixo, sem pkg-config de terceiros.
export FREETYPE_CFLAGS="-I$DEPS/include/freetype2" FREETYPE_LIBS="-L$DEPS/lib -lfreetype"
export GNUTLS_CFLAGS="-I$DEPS/include" GNUTLS_LIBS="-L$DEPS/lib -lgnutls"

B=$BUILD/wine
if ! stamp_done wine-configure; then
  rm -rf "$B"; mkdir -p "$B"
  log "Wine: configure"
  ( cd "$B" && "$WSRC/configure" \
      --prefix="$STAGE" --build=$HOST --host=$HOST \
      --enable-archs=i386,x86_64 --disable-tests \
      --with-mingw --with-coreaudio --with-opencl \
      --with-freetype --with-gnutls --with-vulkan --with-pthread --with-unwind \
      --without-x --without-wayland --without-fontconfig --without-dbus --without-udev \
      --without-alsa --without-oss --without-pulse --without-capi --without-v4l2 \
      --without-gphoto --without-sane --without-hwloc --without-inotify \
      --without-krb5 --without-gssapi --without-netapi --without-pcsclite \
      --without-usb --without-sdl --without-gstreamer --without-ffmpeg \
      --without-cups --without-pcap ) > "$B/configure.log" 2>&1 \
    || { tail -60 "$B/configure.log"; die "Wine: configure falhou ($B/configure.log)"; }
  # O resumo final lista o que ficou de fora; os itens críticos precisam existir.
  sed -n '/^configure: Finished/,$p' "$B/configure.log"
  for need in SONAME_LIBGNUTLS SONAME_LIBFREETYPE SONAME_LIBMOLTENVK; do
    grep -q "define $need " "$B/include/config.h" || die "Wine: configure sem $need (ver $B/configure.log)"
  done
  stamp wine-configure
fi

if ! stamp_done wine-build; then
  log "Wine: make -j$JOBS (demorado)"
  ( cd "$B" && make -j"$JOBS" ) > "$B/make.log" 2>&1 \
    || { grep -nE "error|Error" "$B/make.log" | tail -30; die "Wine: make falhou ($B/make.log)"; }
  stamp wine-build
fi

if ! stamp_done wine-install; then
  # install-lib: só o que roda (bin, lib/wine, share/wine); sem headers e
  # bibliotecas de importação, que são do install-dev.
  log "Wine: make install-lib -> $STAGE"
  rm -rf "$STAGE"
  ( cd "$B" && make install-lib ) > "$B/install.log" 2>&1 \
    || { tail -30 "$B/install.log"; die "Wine: make install-lib falhou"; }
  stamp wine-install
fi

"$STAGE/bin/wine" --version
