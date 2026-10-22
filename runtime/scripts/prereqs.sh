#!/bin/bash
# runtime/scripts/prereqs.sh — confere as ferramentas de build antes de começar.
#
# Do Homebrew só vêm ferramentas que rodam na máquina (arm64); nenhuma
# biblioteca dele entra no runtime.
source "$(dirname "$0")/common.sh"

missing=()
xcode-select -p >/dev/null 2>&1 || missing+=("Xcode (xcode-select --install não basta: o MoltenVK usa xcodebuild)")
xcodebuild -version >/dev/null 2>&1 || missing+=("Xcode completo (xcodebuild)")
/usr/bin/arch -x86_64 /usr/bin/true 2>/dev/null || missing+=("Rosetta 2 (softwareupdate --install-rosetta)")
command -v brew >/dev/null || missing+=("Homebrew (https://brew.sh)")

need_brew="bison mingw-w64 pkgconf meson ninja autoconf automake libtool gettext glslang cmake"
for p in $need_brew; do
  brew list --versions "$p" >/dev/null 2>&1 || missing+=("$p (brew install $p)")
done

if [ ${#missing[@]} -gt 0 ]; then
  printf 'Faltam pré-requisitos:\n' >&2
  printf '  - %s\n' "${missing[@]}" >&2
  printf '\nInstale de uma vez com:\n  brew install %s\n' "$need_brew" >&2
  exit 1
fi
log "Pré-requisitos ok ($(xcodebuild -version | head -1), mingw-w64 $(brew list --versions mingw-w64 | awk '{print $2}'))"
