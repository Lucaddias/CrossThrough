#!/bin/bash
# install.sh — compila o CrossThrough e instala o app em /Applications.
#
# Uso: ./install.sh [--dir <pasta>] [--runtime <dir>] [--no-test] [--uninstall]
#
#   --dir        onde instalar (padrão: /Applications)
#   --runtime    o runtime do Wine a embutir (padrão: runtime/out/CrossThroughRuntime;
#                se ele não existir, é compilado do fonte com runtime/build.sh)
#   --no-test    não roda os testes do app antes de instalar
#   --uninstall  remove o app; as bottles, os logs e os caches ficam
#
# Não pede senha de administrador: só grava na pasta de instalação (a
# /Applications aceita usuários administradores) e em ~/Library/Caches.
set -euo pipefail

ROOT=$(cd "$(dirname "$0")" && pwd)
DEV=$HOME/Library/Caches/CrossThrough-dev
INSTALL_DIR=/Applications
RUNTIME=$ROOT/runtime/out/CrossThroughRuntime
RUN_TESTS=1
UNINSTALL=0
WAS_OPEN=0
LSREGISTER=/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister

while [ $# -gt 0 ]; do
    case "$1" in
        --dir) INSTALL_DIR=${2:?--dir precisa de uma pasta}; shift 2 ;;
        --runtime) RUNTIME=${2:?--runtime precisa de uma pasta}; shift 2 ;;
        --no-test) RUN_TESTS=0; shift ;;
        --uninstall) UNINSTALL=1; shift ;;
        -h|--help) sed -n 2,13p "$0"; exit 0 ;;
        *) echo "opção desconhecida: $1 (veja ./install.sh --help)" >&2; exit 2 ;;
    esac
done

step() { printf '\n==> %s\n' "$1"; }
fail() { printf 'erro: %s\n' "$1" >&2; exit 1; }

[ -d "$INSTALL_DIR" ] || fail "a pasta $INSTALL_DIR não existe."
INSTALL_DIR=$(cd "$INSTALL_DIR" && pwd)
APP=$INSTALL_DIR/CrossThrough.app
trap 'rm -rf "$APP.novo"' EXIT

# Programas do Windows abertos pelo runtime de dentro do app instalado (o
# wineserver vive enquanto houver um): trocar o app embaixo deles derruba
# tudo o que estiver aberto, sem salvar.
refuse_if_windows_programs_run() {
    if pgrep -f "$APP/Contents/SharedSupport/" >/dev/null 2>&1; then
        fail "há programas do Windows abertos pelo CrossThrough. Feche-os (ou use Encerrar tudo, na bottle) e rode de novo."
    fi
}

quit_app() {
    local exe="$APP/Contents/MacOS/CrossThrough"
    pkill -f "$exe" 2>/dev/null || return 0
    WAS_OPEN=1
    for _ in $(seq 50); do
        pgrep -f "$exe" >/dev/null 2>&1 || return 0
        sleep 0.1
    done
    pkill -9 -f "$exe" 2>/dev/null || true
}

if [ $UNINSTALL = 1 ]; then
    [ -d "$APP" ] || fail "não há CrossThrough em $INSTALL_DIR."
    refuse_if_windows_programs_run
    quit_app
    rm -rf "$APP"
    "$LSREGISTER" -u "$APP" >/dev/null 2>&1 || true
    echo "Removido: $APP"
    echo "Ficaram (apague à mão se quiser):"
    echo "  bottles  ~/Library/Application Support/CrossThrough"
    echo "  logs     ~/Library/Logs/CrossThrough"
    echo "  caches   ~/Library/Caches/CrossThrough (downloads e ícones)"
    exit 0
fi

step "Conferindo os requisitos"
[ "$(uname)" = Darwin ] || fail "o CrossThrough roda só no macOS."
macos=$(sw_vers -productVersion)
[ "${macos%%.*}" -ge 14 ] || fail "precisa do macOS 14 ou mais novo (este é o $macos)."
if [ "$(uname -m)" = arm64 ]; then
    /usr/bin/arch -x86_64 /usr/bin/true 2>/dev/null \
        || fail "falta o Rosetta 2, que roda o Wine (x86_64): softwareupdate --install-rosetta --agree-to-license"
fi
command -v swift >/dev/null 2>&1 || fail "falta o Swift: instale o Xcode ou as Command Line Tools (xcode-select --install)."
swift_version=$(swift --version 2>/dev/null | sed -n 's/.*Swift version \([0-9][0-9.]*\).*/\1/p' | head -1)
[ "${swift_version%%.*}" -ge 6 ] 2>/dev/null || fail "precisa do Swift 6 ou mais novo (encontrado: ${swift_version:-nenhum})."
[ -w "$INSTALL_DIR" ] || fail "$INSTALL_DIR não aceita gravação por $(whoami); use --dir <pasta>."
refuse_if_windows_programs_run
echo "ok: macOS $macos, Swift $swift_version"

if [ ! -f "$RUNTIME/runtime.json" ]; then
    [ "$RUNTIME" = "$ROOT/runtime/out/CrossThroughRuntime" ] || fail "não há runtime em $RUNTIME (falta o runtime.json)."
    step "Compilando o runtime do Wine do fonte (só na primeira vez; demora)"
    "$ROOT/runtime/build.sh"
fi
# O Wine monta caminhos de DOS em buffers de 260 caracteres a partir do caminho
# do runtime (runtime/README.md): o runtime.json diz até onde ele foi testado.
limit=$(sed -n 's/.*"maxInstallPathLength": *\([0-9][0-9]*\).*/\1/p' "$RUNTIME/runtime.json")
installed_runtime=$APP/Contents/SharedSupport/CrossThroughRuntime
length=$(printf %s "$installed_runtime" | wc -c | tr -d ' ')
if [ -n "$limit" ] && [ "$length" -gt "$limit" ]; then
    fail "o caminho do runtime instalado teria $length caracteres; o limite é $limit. Use uma pasta mais curta em --dir."
fi
echo "ok: runtime $(sed -n 's/.*"wine": *"\([^"]*\)".*/\1/p' "$RUNTIME/runtime.json") em $RUNTIME"

if [ $RUN_TESTS = 1 ]; then
    step "Rodando os testes"
    mkdir -p "$DEV"
    log=$DEV/test.log
    # O swift test intercala bytes nulos na saída quando não vai para um terminal.
    if swift test --package-path "$ROOT/app" --scratch-path "$DEV/build" 2>&1 | tr -d '\000' > "$log"; then
        passed=$(sed -n 's/.*Test run with \([0-9][0-9]*\) tests.* passed.*/\1/p' "$log" | tail -1)
        echo "ok: ${passed:-todos os} testes passaram"
    else
        tail -30 "$log" >&2
        fail "os testes falharam (log completo em $log)."
    fi
fi

step "Montando o app"
"$ROOT/app/scripts/bundle.sh" --runtime "$RUNTIME" --out "$DEV/app"

step "Instalando em $INSTALL_DIR"
refuse_if_windows_programs_run
rm -rf "$APP.novo"
ditto "$DEV/app/CrossThrough.app" "$APP.novo"
codesign --verify --strict "$APP.novo" || fail "a cópia em $APP.novo não confere com a assinatura."
quit_app
rm -rf "$APP"
mv "$APP.novo" "$APP"
"$LSREGISTER" -f "$APP" >/dev/null 2>&1 || true
echo "ok: $APP ($(defaults read "$APP/Contents/Info.plist" CFBundleShortVersionString))"

step "Pronto"
if [ $WAS_OPEN = 1 ]; then
    # Estava aberto antes da troca: abre de novo, já na versão nova.
    open "$APP"
    echo "O CrossThrough estava aberto e foi reaberto na versão nova."
else
    echo "Abra pelo Launchpad ou pelo Spotlight, ou: open \"$APP\""
fi
bottles=$("$APP/Contents/Helpers/crossthrough" bottles 2>/dev/null || true)
if [ -n "$bottles" ]; then
    echo
    echo "Suas bottles:"
    printf '%s\n' "$bottles" | sed 's/^/  /'
    if printf '%s\n' "$bottles" | grep -q "de outro programa"; then
        echo "As que vieram de outro programa aparecem na barra lateral: clique numa delas e em Usar no CrossThrough."
    fi
fi
