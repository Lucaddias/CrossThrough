#!/bin/bash
# runtime/scripts/helpers.sh — programas Windows do próprio CrossThrough.
#
# Fonte em runtime/helpers/, compilado com o mingw-w64 (x86_64; um processo de
# 64 bits abre e enxerga os de 32 bits no WoW64 do Wine):
#
#   ctlaunch.exe   abre um programa e acompanha a árvore de processos dele até
#                  o último fechar (launchers que abrem o programa e saem)
#
# É rápido o bastante para compilar sempre: não tem marca de etapa.
source "$(dirname "$0")/common.sh"

export PATH="/opt/homebrew/bin:/usr/bin:/bin:/usr/sbin:/sbin"
H=$WORK/helpers
mkdir -p "$H"
log "Helpers: ctlaunch.exe"
x86_64-w64-mingw32-gcc -O2 -s -Wall -Wextra -Werror -municode \
  -o "$H/ctlaunch.exe" "$RUNTIME_DIR/helpers/ctlaunch.c" -lshell32 -lole32
