#!/bin/bash
# runtime/scripts/dxvk.sh — DXVK 1.10.3 (fork para macOS da CodeWeavers).
#
# Direct3D 9/10/11 -> Vulkan, que o MoltenVK leva ao Metal. A série 1.10 é a
# última que funciona com o conjunto de recursos do MoltenVK; o DXVK 2.x exige
# extensões Vulkan que o Metal não oferece. São DLLs PE, então o build é
# cruzado com mingw-w64 (como o próprio package-release.sh do projeto faz).
source "$(dirname "$0")/common.sh"

ensure_sources
command -v glslangValidator >/dev/null || die "glslangValidator ausente (brew install glslang)"
if stamp_done dxvk; then log "DXVK: já compilado"; exit 0; fi

export PATH="/opt/homebrew/bin:/usr/bin:/bin:/usr/sbin:/sbin"
# Os patches de patches/dxvk/ foram validados com o mingw-w64 14.
mingw_major=$(echo '__MINGW64_VERSION_MAJOR' | x86_64-w64-mingw32-gcc -E -include _mingw.h - | tail -1)
[ "$mingw_major" -ge 14 ] 2>/dev/null || die "DXVK requer mingw-w64 >= 14 (encontrado: ${mingw_major:-?})"
S=$(patched_tree dxvk "$SRC/dxvk")
D=$WORK/dxvk
rm -rf "$D"; mkdir -p "$D"
for bits in 64 32; do
  b=$BUILD/dxvk.$bits
  rm -rf "$b"
  log "DXVK: win$bits"
  # -include cstdint: o código de 2022 contava com o <cstdint> transitivo que o
  # GCC 13+ deixou de fornecer (o DXVK upstream corrigiu igual, com o include).
  ( meson setup --cross-file "$S/build-win$bits.txt" --buildtype release --strip \
      --prefix "$D" --bindir "x$bits" --libdir "x$bits" \
      -Dcpp_args="-include cstdint" \
      -Denable_tests=false -Dbuild_id=false "$b" "$S" \
    && ninja -C "$b" install ) > "$BUILD/dxvk.$bits.log" 2>&1 \
    || { grep -nE "error|Error" "$BUILD/dxvk.$bits.log" | head -30; die "DXVK win$bits falhou ($BUILD/dxvk.$bits.log)"; }
  rm -f "$D/x$bits"/*.a
done
ls "$D"/x64 "$D"/x32
stamp dxvk
