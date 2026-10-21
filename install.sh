#!/bin/bash
# install.sh — builds CrossThrough and installs it in /Applications.
#
# Usage: ./install.sh [--dir <folder>] [--no-test] [--uninstall]
# Never asks for administrator rights: it only writes to the install folder
# (default /Applications, writable by admin users) and to build/.
set -euo pipefail

INSTALL_DIR=/Applications
RUN_TESTS=1
# Host runtime: found by its bundle identifier; override with RUNTIME=<path>.
RUNTIME="${RUNTIME:-$(mdfind "kMDItemCFBundleIdentifier == 'com.codeweavers.*'" 2>/dev/null | grep "^/Applications/[^/]*\.app$" | head -1)}"
ROOT="$(cd "$(dirname "$0")" && pwd)"

while [ $# -gt 0 ]; do
    case "$1" in
        --dir) INSTALL_DIR="$2"; shift 2 ;;
        --no-test) RUN_TESTS=0; shift ;;
        --uninstall)
            rm -rf "$INSTALL_DIR/CrossThrough.app"
            echo "Removed $INSTALL_DIR/CrossThrough.app"
            exit 0 ;;
        -h|--help) sed -n 2,6p "$0"; exit 0 ;;
        *) echo "unknown option: $1" >&2; exit 2 ;;
    esac
done

step() { printf '\n==> %s\n' "$1"; }
fail() { printf 'error: %s\n' "$1" >&2; exit 1; }

step "Checking requirements"
[ "$(uname)" = Darwin ] || fail "CrossThrough runs on macOS only."
major=$(sw_vers -productVersion | cut -d. -f1)
[ "$major" -ge 11 ] || fail "macOS 11 or later is required."
xcrun --find clang >/dev/null 2>&1 || fail "Xcode Command Line Tools are missing: run xcode-select --install"
[ -n "$RUNTIME" ] && [ -d "$RUNTIME/Contents/SharedSupport" ] || fail "The host runtime was not found at $RUNTIME (see README, Requirements)."
[ -w "$INSTALL_DIR" ] || fail "$INSTALL_DIR is not writable by $(whoami); use --dir <folder>."
echo "ok: macOS $(sw_vers -productVersion), $(xcrun clang --version | head -1)"

cd "$ROOT/CrossThrough"

step "Building"
make -j"$(sysctl -n hw.ncpu)" >/dev/null
make app >/dev/null
echo "ok: build/CrossThrough.app"

if [ "$RUN_TESTS" = 1 ]; then
    step "Running tests"
    make test 2>&1 | grep -E "ALL .*PASSED|FAIL" || fail "tests failed (rerun with make test for details)"
fi

step "Installing in $INSTALL_DIR"
pkill -f "$INSTALL_DIR/CrossThrough.app/Contents/MacOS/CrossThrough" 2>/dev/null && sleep 1 || true
make install INSTALL_DIR="$INSTALL_DIR" >/dev/null
echo "ok: $INSTALL_DIR/CrossThrough.app"

step "Done"
echo "Open it from Launchpad/Spotlight, or: open \"$INSTALL_DIR/CrossThrough.app\""
