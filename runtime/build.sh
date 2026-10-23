#!/bin/bash
# runtime/build.sh — compila o runtime do CrossThrough inteiro, do fonte.
#
#   ./build.sh            compila o que faltar, monta em out/ e roda os testes
#                         (no lugar e realocado para um caminho no limite)
#   ./build.sh --clean    apaga .work/ (exceto downloads) e out/ antes
#   ./build.sh --no-test  não roda o smoke.sh no final
#
# Etapas (cada uma retomável): deps -> moltenvk -> wine -> dxvk -> helpers ->
# assemble -> smoke -> relocation
set -euo pipefail
HERE=$(cd "$(dirname "$0")" && pwd)
clean=0 test=1
for a in "$@"; do
  case "$a" in
    --clean) clean=1 ;;
    --no-test) test=0 ;;
    *) echo "uso: $0 [--clean] [--no-test]" >&2; exit 2 ;;
  esac
done

if [ $clean = 1 ]; then
  find "$HERE/.work" -mindepth 1 -maxdepth 1 ! -name dl -exec rm -rf {} + 2>/dev/null || true
  rm -rf "$HERE/out"
fi

bash "$HERE/scripts/prereqs.sh"
bash "$HERE/scripts/deps.sh"
bash "$HERE/scripts/moltenvk.sh"
bash "$HERE/scripts/wine.sh"
bash "$HERE/scripts/dxvk.sh"
bash "$HERE/scripts/helpers.sh"
bash "$HERE/scripts/assemble.sh"
if [ $test = 1 ]; then
  bash "$HERE/scripts/smoke.sh"
  bash "$HERE/scripts/relocation.sh"
fi
