#!/bin/bash
# runtime/scripts/assemble.sh — monta o runtime final em $OUT.
#
# Layout (relocável; nada aponta para o diretório de build):
#
#   bin/                         wine, wineserver, cabextract
#   lib/*.dylib                  gnutls, nettle, hogweed, gmp, freetype, MoltenVK
#   lib/wine/<arch>-{windows,unix}  Wine + winemetal (parte Unix do DXMT)
#   lib/dxvk/<arch>-windows      DXVK, DLLs nativas para instalar por bottle
#   lib/dxmt/<arch>-windows      DXMT (d3d11/dxgi/d3d10core/nvapi), idem
#   share/wine/{gecko,mono}      complementos do Wine, já descompactados
#   share/winetricks/winetricks  instalador de dependências por bottle
#   share/licenses/<componente>  licença de cada parte
#   runtime.json                 manifesto (versões, origem, SHA-256)
source "$(dirname "$0")/common.sh"

[ -x "$STAGE/bin/wine" ] || die "Wine não instalado em $STAGE (rode scripts/wine.sh)"
[ -d "$WORK/dxvk/x64" ]  || die "DXVK não compilado (rode scripts/dxvk.sh)"

log "Montando $OUT"
rm -rf "$OUT"; mkdir -p "$OUT/lib" "$OUT/share/licenses"

# --- Wine -------------------------------------------------------------------
cp -R "$STAGE/bin" "$OUT/bin"
cp -R "$STAGE/lib/wine" "$OUT/lib/wine"
mkdir -p "$OUT/share"
cp -R "$STAGE/share/wine" "$OUT/share/wine"

# --- ferramentas ------------------------------------------------------------
# O winetricks acha o cabextract pelo PATH; o app põe bin/ no PATH.
cp "$DEPS/bin/cabextract" "$OUT/bin/cabextract"
mkdir -p "$OUT/share/winetricks"
install -m 755 "$(fetch winetricks)" "$OUT/share/winetricks/winetricks"

# --- bibliotecas Unix -------------------------------------------------------
for lib in libgnutls.30 libnettle.8 libhogweed.6 libgmp.10 libfreetype.6 libMoltenVK; do
  cp -L "$DEPS/lib/$lib.dylib" "$OUT/lib/$lib.dylib"
done
# Ids viram @rpath/<nome>; dependências entre elas viram @loader_path/<nome>.
for f in "$OUT"/lib/*.dylib; do
  install_name_tool -id "@rpath/$(basename "$f")" "$f" 2>/dev/null
  otool -L "$f" | awk 'NR>1 {print $1}' | while read -r dep; do
    case "$dep" in
      "$DEPS"/lib/*) install_name_tool -change "$dep" "@loader_path/$(basename "$dep")" "$f" ;;
    esac
  done
done

# --- DXMT -------------------------------------------------------------------
# winemetal (PE + unixlib) é o único que chama código Unix: entra na árvore
# do Wine, onde não há nada com o mesmo nome. O winemetal.so liga contra
# @rpath/{ntdll,winemac}.so, que estão no mesmo diretório.
DXMT_TGZ=$(fetch dxmt)
tmp=$(mktemp -d)
tar -xzf "$DXMT_TGZ" -C "$tmp"
dx=$(find "$tmp" -maxdepth 1 -mindepth 1 -type d | head -1)
cp "$dx/x86_64-windows/winemetal.dll" "$OUT/lib/wine/x86_64-windows/"
cp "$dx/i386-windows/winemetal.dll"   "$OUT/lib/wine/i386-windows/"
cp "$dx/x86_64-unix/winemetal.so"     "$OUT/lib/wine/x86_64-unix/"
# O resto substitui as DLLs Direct3D do Wine por bottle, como DLLs nativas. A
# marca "Wine builtin DLL" faria o loader trocar o arquivo pelo builtin de
# mesmo nome do Wine, então ela é apagada aqui.
mkdir -p "$OUT/lib/dxmt/x86_64-windows" "$OUT/lib/dxmt/i386-windows"
for arch in x86_64 i386; do
  for f in "$dx/$arch-windows"/*.dll; do
    [ "$(basename "$f")" = winemetal.dll ] && continue
    cp "$f" "$OUT/lib/dxmt/$arch-windows/"
  done
done
rm -rf "$tmp"

unmark_builtin() {
  local f=$1 tag
  tag=$(dd if="$f" bs=1 skip=64 count=16 2>/dev/null)
  [ "$tag" = "Wine builtin DLL" ] || return 0
  dd if=/dev/zero of="$f" bs=1 seek=64 count=32 conv=notrunc 2>/dev/null
}
for f in "$OUT"/lib/dxmt/*/*.dll; do unmark_builtin "$f"; done

# --- DXVK -------------------------------------------------------------------
mkdir -p "$OUT/lib/dxvk/x86_64-windows" "$OUT/lib/dxvk/i386-windows"
cp "$WORK/dxvk/x64"/*.dll "$OUT/lib/dxvk/x86_64-windows/"
cp "$WORK/dxvk/x32"/*.dll "$OUT/lib/dxvk/i386-windows/"

# --- Gecko e Mono -----------------------------------------------------------
mkdir -p "$OUT/share/wine/gecko" "$OUT/share/wine/mono"
tar -xJf "$(fetch wine-gecko-x86)"    -C "$OUT/share/wine/gecko"
tar -xJf "$(fetch wine-gecko-x86_64)" -C "$OUT/share/wine/gecko"
tar -xJf "$(fetch wine-mono)"         -C "$OUT/share/wine/mono"

# --- licenças ---------------------------------------------------------------
L=$OUT/share/licenses
# lic <componente> <arquivos...>: copia os que existirem (nomes variam entre versões).
lic() {
  local d=$1 f; shift
  mkdir -p "$L/$d"
  for f in "$@"; do
    if [ -f "$f" ]; then cp "$f" "$L/$d/"; fi
  done
  [ -n "$(ls "$L/$d")" ] || die "nenhuma licença encontrada para $d"
}
lic wine      "$SRC/wine/COPYING.LIB" "$SRC/wine/LICENSE" "$SRC/wine/AUTHORS"
lic gnutls    "$SRC/gnutls/gnutls/LICENSE" "$SRC/gnutls/gnutls/COPYING.LESSERv2" "$SRC/gnutls/gnutls/doc/COPYING.LESSER"
lic nettle    "$WORK/src/nettle-$(lock_field nettle version)"/COPYING*
lic gmp       "$SRC/gnutls/gmp"/COPYING*
lic freetype  "$WORK/src/freetype-$(lock_field freetype version)/LICENSE.TXT" \
              "$WORK/src/freetype-$(lock_field freetype version)/docs/FTL.TXT" \
              "$WORK/src/freetype-$(lock_field freetype version)/docs/GPLv2.TXT"
lic moltenvk  "$SRC/moltenvk/LICENSE"
# Partes de External/ compiladas dentro do libMoltenVK.dylib.
for ext in SPIRV-Cross cereal Vulkan-Headers; do
  [ -d "$BUILD/moltenvk/External/$ext" ] || continue
  mkdir -p "$L/moltenvk/$ext"
  # Arquivo LICENSE* ou, no estilo REUSE (Vulkan-Headers), diretório LICENSES/.
  find "$BUILD/moltenvk/External/$ext" -maxdepth 1 -iname "LICENSE*" -exec cp -R {} "$L/moltenvk/$ext/" \;
done
lic vkd3d     "$SRC/vkd3d/COPYING" "$SRC/vkd3d/LICENSE"
lic dxvk      "$SRC/dxvk/LICENSE"
lic dxmt      "$(fetch dxmt-license)"
lic wine-gecko "$(fetch wine-gecko-license)"
lic wine-mono  "$(fetch wine-mono-license)"
lic cabextract "$SRC/cabextract/COPYING" "$SRC/cabextract/AUTHORS"
# O libmspack embutido é LGPL-2.1 (cabeçalho de mspack/mspack.h), mas o fonte
# não traz o texto da licença; é o mesmo texto do COPYING.LIB do Wine.
cp "$SRC/wine/COPYING.LIB" "$L/cabextract/libmspack-LGPL-2.1.txt"
lic winetricks "$(fetch winetricks-license)"

# --- limpeza ----------------------------------------------------------------
rm -rf "$OUT/share/man" "$OUT/share/applications"

# Re-assina (ad hoc) tudo que o install_name_tool tocou e o resto dos Mach-O.
find "$OUT" -type f \( -name "*.dylib" -o -name "*.so" \) -print0 | xargs -0 codesign -f -s - 2>/dev/null
for b in "$OUT"/bin/*; do
  file "$b" | grep -q Mach-O && codesign -f -s - "$b" 2>/dev/null
done

# --- verificação: nada pode apontar para o build ----------------------------
bad=0
while IFS= read -r -d '' f; do
  file "$f" | grep -q Mach-O || continue
  if otool -L "$f" 2>/dev/null | grep -q "$WORK"; then warn "referência ao build em $f"; bad=1; fi
  if otool -l "$f" 2>/dev/null | grep -A2 LC_RPATH | grep -q "$WORK"; then warn "rpath do build em $f"; bad=1; fi
done < <(find "$OUT/bin" "$OUT/lib" -type f -print0)
[ $bad = 0 ] || die "o runtime ainda depende do diretório de build"

# --- manifesto --------------------------------------------------------------
wine_version=$("$STAGE/bin/wine" --version 2>/dev/null || echo "wine-11.0")
{
  printf '{\n  "name": "CrossThroughRuntime",\n'
  printf '  "built": "%s",\n' "$(date -u +%Y-%m-%dT%H:%M:%SZ)"
  printf '  "arch": "x86_64",\n  "minimumMacOS": "%s",\n' "$MACOSX_DEPLOYMENT_TARGET"
  printf '  "maxInstallPathLength": %d,\n' "$RUNTIME_PATH_MAX"
  printf '  "wine": "%s",\n  "components": [\n' "$wine_version"
  first=1
  for c in crossover-sources nettle freetype dxmt wine-gecko-x86 wine-gecko-x86_64 wine-mono winetricks; do
    [ $first = 1 ] || printf ',\n'; first=0
    printf '    {"name": "%s", "version": "%s", "url": "%s", "sha256": "%s", "license": "%s"}' \
      "$c" "$(lock_field $c version)" "$(lock_field $c url)" "$(lock_field $c sha256)" "$(lock_field $c license)"
  done
  printf '\n  ]\n}\n'
} > "$OUT/runtime.json"
python3 -c "import json,sys; json.load(open(sys.argv[1]))" "$OUT/runtime.json" || die "runtime.json inválido"

du -sh "$OUT"
log "Runtime pronto em $OUT"
