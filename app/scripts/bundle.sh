#!/bin/bash
# bundle.sh — monta o CrossThrough.app: o app SwiftUI, o CLI, o catálogo e o
# runtime do Wine, assinado ad hoc.
#
# Uso: scripts/bundle.sh [--out <pasta>] [--runtime <dir>] [--debug]
#
#   --out      onde gravar o CrossThrough.app (padrão: ~/Library/Caches/CrossThrough-dev/app)
#   --runtime  o runtime a embutir (padrão: runtime/out/CrossThroughRuntime do repositório)
#   --debug    compila sem otimização (mais rápido para testar)
#
# O build fica fora do repositório (~/Library/Caches/CrossThrough-dev/build):
# no iCloud Drive o FileProvider põe atributos estendidos nos arquivos, e o
# codesign recusa assinar com eles.
#
# Estrutura do app:
#   Contents/MacOS/CrossThrough                  o app
#   Contents/Helpers/crossthrough                o CLI (o mesmo Kit)
#   Contents/Resources/catalog.json, AppIcon.icns
#   Contents/SharedSupport/CrossThroughRuntime   Wine, DXVK, DXMT, MoltenVK, Gecko, Mono, winetricks
set -euo pipefail

APP_DIR=$(cd "$(dirname "$0")/.." && pwd)
REPO=$(cd "$APP_DIR/.." && pwd)
DEV=$HOME/Library/Caches/CrossThrough-dev
OUT=$DEV/app
RUNTIME=$REPO/runtime/out/CrossThroughRuntime
CONFIG=release
SCRATCH=$DEV/build

while [ $# -gt 0 ]; do
    case "$1" in
        --out) OUT=$2; shift 2 ;;
        --runtime) RUNTIME=$2; shift 2 ;;
        --debug) CONFIG=debug; shift ;;
        -h|--help) sed -n 2,10p "$0"; exit 0 ;;
        *) echo "opção desconhecida: $1" >&2; exit 2 ;;
    esac
done

die() { printf 'erro: %s\n' "$*" >&2; exit 1; }
[ -f "$RUNTIME/runtime.json" ] || die "runtime não encontrado em $RUNTIME (compile com runtime/build.sh)"
[ -f "$REPO/catalog/catalog.json" ] || die "catalog/catalog.json não encontrado"

VERSION=$(sed -n 's/^version *= *//p' "$APP_DIR/version.txt" 2>/dev/null || true)
[ -n "$VERSION" ] || die "app/version.txt sem a linha version = x.y.z"
BUILD=$(git -C "$REPO" rev-list --count HEAD 2>/dev/null || echo 1)

# --- compilação ---------------------------------------------------------------
# Universal (arm64 + x86_64): o runtime é x86_64 e roda também em Macs Intel.
ARCHS=(--arch arm64 --arch x86_64)
echo "==> Compilando ($CONFIG, universal)"
swift build --package-path "$APP_DIR" --scratch-path "$SCRATCH" -c "$CONFIG" "${ARCHS[@]}" \
    --product CrossThroughApp >/dev/null
swift build --package-path "$APP_DIR" --scratch-path "$SCRATCH" -c "$CONFIG" "${ARCHS[@]}" \
    --product crossthrough >/dev/null
BIN=$(swift build --package-path "$APP_DIR" --scratch-path "$SCRATCH" -c "$CONFIG" "${ARCHS[@]}" --show-bin-path)
for exe in CrossThroughApp crossthrough; do
    archs=$(lipo -archs "$BIN/$exe")
    [[ "$archs" == *arm64* && "$archs" == *x86_64* ]] || die "$exe não saiu universal ($archs)"
done

# --- bundle -------------------------------------------------------------------
APP=$OUT/CrossThrough.app
C=$APP/Contents
echo "==> Montando $APP"
rm -rf "$APP"
mkdir -p "$C/MacOS" "$C/Helpers" "$C/Resources" "$C/SharedSupport"
install -m 755 "$BIN/CrossThroughApp" "$C/MacOS/CrossThrough"
install -m 755 "$BIN/crossthrough" "$C/Helpers/crossthrough"
install -m 644 "$REPO/catalog/catalog.json" "$C/Resources/catalog.json"
printf 'APPL????' > "$C/PkgInfo"

# Ícone: o PNG de 1024 em todos os tamanhos do .icns.
ICONSET=$(mktemp -d)/AppIcon.iconset
mkdir -p "$ICONSET"
for size in 16 32 128 256 512; do
    sips -z $size $size "$APP_DIR/Resources/icon/CrossThrough-1024.png" --out "$ICONSET/icon_${size}x${size}.png" >/dev/null
    double=$((size * 2))
    sips -z $double $double "$APP_DIR/Resources/icon/CrossThrough-1024.png" --out "$ICONSET/icon_${size}x${size}@2x.png" >/dev/null
done
iconutil -c icns "$ICONSET" -o "$C/Resources/AppIcon.icns"
rm -rf "$(dirname "$ICONSET")"

# O runtime vai como está (ditto preserva links simbólicos e permissões).
ditto "$RUNTIME" "$C/SharedSupport/CrossThroughRuntime"

cat > "$C/Info.plist" <<PLIST
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>CFBundleDevelopmentRegion</key>
    <string>pt-BR</string>
    <key>CFBundleDisplayName</key>
    <string>CrossThrough</string>
    <key>CFBundleExecutable</key>
    <string>CrossThrough</string>
    <key>CFBundleIconFile</key>
    <string>AppIcon</string>
    <key>CFBundleIdentifier</key>
    <string>com.crossthrough.app</string>
    <key>CFBundleInfoDictionaryVersion</key>
    <string>6.0</string>
    <key>CFBundleName</key>
    <string>CrossThrough</string>
    <key>CFBundlePackageType</key>
    <string>APPL</string>
    <key>CFBundleShortVersionString</key>
    <string>$VERSION</string>
    <key>CFBundleVersion</key>
    <string>$BUILD</string>
    <key>LSApplicationCategoryType</key>
    <string>public.app-category.utilities</string>
    <key>LSMinimumSystemVersion</key>
    <string>14.0</string>
    <key>NSHighResolutionCapable</key>
    <true/>
    <key>NSHumanReadableCopyright</key>
    <string>Código aberto. O runtime traz as licenças de cada componente.</string>
</dict>
</plist>
PLIST
plutil -lint "$C/Info.plist" >/dev/null

# --- assinatura ---------------------------------------------------------------
# Ad hoc: sem certificado, o bastante para o macOS rodar o app compilado aqui.
# O runtime entra no selo como recurso (o app não altera nada dentro dele).
echo "==> Assinando"
xattr -cr "$APP"
codesign --force --sign - --timestamp=none "$C/Helpers/crossthrough"
codesign --force --sign - --timestamp=none "$APP"
codesign --verify --strict "$APP" || die "a assinatura do app não confere"

echo "==> Pronto: $APP ($(du -sh "$APP" | cut -f1), versão $VERSION ($BUILD))"
