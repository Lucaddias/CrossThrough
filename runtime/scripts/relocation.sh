#!/bin/bash
# runtime/scripts/relocation.sh — prova que o runtime funciona fora de onde foi
# montado, no limite do contrato de caminho.
#
# Clona $OUT para um diretório com espaços (como "Application Support") cujo
# caminho tem exatamente RUNTIME_PATH_MAX caracteres, esconde o original para
# que nada consiga resolver de volta para ele e roda o smoke.sh inteiro no clone.
source "$(dirname "$0")/common.sh"

[ -x "$OUT/bin/wine" ] || die "runtime não encontrado em $OUT (rode scripts/assemble.sh)"

base=$(mktemp -d "${TMPDIR:-/tmp}/crossthrough-relocation.XXXXXX")
base=$(cd "$base" && pwd -P)
parent="$base/Application Support/CrossThrough"
leaf="Runtime "
pad=$(( RUNTIME_PATH_MAX - ${#parent} - 1 - ${#leaf} ))
[ $pad -ge 1 ] || die "TMPDIR longo demais para montar um caminho de $RUNTIME_PATH_MAX caracteres"
RT="$parent/$leaf$(printf '%*s' $pad '' | tr ' ' x)"
[ ${#RT} -eq $RUNTIME_PATH_MAX ] || die "caminho de teste com ${#RT} caracteres, esperado $RUNTIME_PATH_MAX"

mkdir -p "$parent"
# Clone APFS (instantâneo); em outro sistema de arquivos, cópia comum.
cp -cR "$OUT" "$RT" 2>/dev/null || { rm -rf "$RT"; cp -R "$OUT" "$RT"; }

restore() {
  [ -d "$OUT.hidden" ] && mv "$OUT.hidden" "$OUT"
  rm -rf "$base"
}
trap restore EXIT
mv "$OUT" "$OUT.hidden"

log "Runtime realocado (${#RT} caracteres): $RT"
bash "$RUNTIME_DIR/scripts/smoke.sh" "$RT"
