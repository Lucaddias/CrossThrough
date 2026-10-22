#!/bin/bash
# runtime/scripts/moltenvk.sh — MoltenVK (Vulkan sobre Metal) do fonte.
#
# Usa a árvore do MoltenVK 1.2.10 que vem no tarball da CodeWeavers, com o
# SPIRV-Cross que vem junto (preservado via --spirv-cross-root). As demais
# dependências (cereal, Vulkan-Headers, glslang/SPIRV-Tools) são clonadas do
# GitHub nas revisões fixadas em ExternalRevisions/. O xcodebuild gera um
# dylib universal; guardamos só a fatia x86_64 em $DEPS/lib.
source "$(dirname "$0")/common.sh"

ensure_sources
if stamp_done moltenvk && [ -f "$DEPS/lib/libMoltenVK.dylib" ]; then
  log "MoltenVK: já instalado"; exit 0
fi

B=$BUILD/moltenvk
rm -rf "$B" "$BUILD/spirv-cross"
mkdir -p "$BUILD"
cp -R "$SRC/moltenvk" "$B"
cp -R "$SRC/moltenvk/External/SPIRV-Cross" "$BUILD/spirv-cross"
# Os projetos pedem macOS 10.15; o Xcode atual só aceita a partir do 12.0.
find "$B" -name project.pbxproj -exec sed -i '' -E \
  "s/MACOSX_DEPLOYMENT_TARGET = [0-9.]+;/MACOSX_DEPLOYMENT_TARGET = $MACOSX_DEPLOYMENT_TARGET;/" {} +

# Ferramentas nativas (cmake/ninja/python do sistema); nada de x86_env aqui.
export PATH="/opt/homebrew/bin:/usr/bin:/bin:/usr/sbin:/sbin"
log "MoltenVK: buscando dependências externas (revisões fixadas)"
( cd "$B" && ./fetchDependencies --macos --spirv-cross-root "$BUILD/spirv-cross" ) \
  > "$B/fetch.log" 2>&1 || { tail -40 "$B/fetch.log"; die "MoltenVK: fetchDependencies falhou"; }

log "MoltenVK: xcodebuild (macOS)"
( cd "$B" && make macos ) > "$B/build.log" 2>&1 \
  || { tail -60 "$B/build.log"; die "MoltenVK: build falhou ($B/build.log)"; }

dylib=$(find "$B/Package" -path "*dynamic*" -name libMoltenVK.dylib -path "*macOS*" | head -1)
[ -n "$dylib" ] || dylib=$(find "$B/Package" -name libMoltenVK.dylib | head -1)
[ -n "$dylib" ] || die "MoltenVK: libMoltenVK.dylib não encontrado em $B/Package"
mkdir -p "$DEPS/lib"
lipo -thin x86_64 "$dylib" -output "$DEPS/lib/libMoltenVK.dylib" 2>/dev/null \
  || cp "$dylib" "$DEPS/lib/libMoltenVK.dylib"
[ "$(lipo -archs "$DEPS/lib/libMoltenVK.dylib")" = x86_64 ] || die "MoltenVK sem fatia x86_64"
stamp moltenvk
log "MoltenVK pronto: $DEPS/lib/libMoltenVK.dylib"
