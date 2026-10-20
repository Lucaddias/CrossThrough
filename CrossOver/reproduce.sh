#!/bin/bash
# Regenera todas as saídas da análise a partir do CrossOver.app instalado e de um
# bundle de Evidence do REA (export_evidence_bundle), e compara com o que está no repo.
# Nada do CrossOver é executado: só lipo, leitura de arquivos e os scripts deste repo.
#
# uso: CrossOver/reproduce.sh <rea-bundle.json> [dir-de-saida]
set -euo pipefail

APP=${APP:-/Applications/CrossOver.app}
BUNDLE=${1:?uso: reproduce.sh <rea-bundle.json> [dir-de-saida]}
OUT=${2:-$(mktemp -d -t crossover-re)}
PY=${PYTHON:-$(command -v python3.14 || echo /opt/homebrew/bin/python3.14)}
HERE=$(cd "$(dirname "$0")" && pwd)

step() { printf '\n\033[1m==> %s\033[0m\n' "$*"; }
t0=$SECONDS

step "Alvo: $APP"
/usr/libexec/PlistBuddy -c 'Print :CFBundleShortVersionString' "$APP/Contents/Info.plist"
shasum -a 256 "$APP/Contents/MacOS/CrossOver"
echo "saída: $OUT   python: $("$PY" --version)"

step "1/6 Extraindo as slices thin (lipo)"
mkdir -p "$OUT/slices"
for a in x86_64 arm64; do
  lipo -thin "$a" "$APP/Contents/MacOS/CrossOver" -output "$OUT/slices/CrossOver.$a"
  shasum -a 256 "$OUT/slices/CrossOver.$a"
done

step "2/6 Comparando x86_64 × arm64 (.slicediff.py)"
"$PY" -I "$HERE/decompiled/x86_64/.slicediff.py" "$BUNDLE" \
  "$OUT/slices/CrossOver.x86_64" "$OUT/slices/CrossOver.arm64" "$OUT/x86_64"

step "3/6 Lendo os 50 .pyc do Python 3.13 (analyze_python.py)"
"$PY" -I "$HERE/sharedsupport/.tools/analyze_python.py" "$APP" "$OUT/sharedsupport/python"

step "4/6 Inventário de bin/ e lib/perl (analyze_tools.py)"
"$PY" -I "$HERE/sharedsupport/.tools/analyze_tools.py" "$APP" "$OUT/sharedsupport"

step "5/6 Gerando TOOLS.md e python/INDEX.md (make_index.py)"
"$PY" -I "$HERE/sharedsupport/.tools/make_index.py" "$OUT/sharedsupport"

step "6/6 Mapeando a ponte Objective-C <-> Python (bridge.py)"
"$PY" -I "$HERE/sharedsupport/.tools/bridge.py" "$APP" "$OUT/sharedsupport" "$HERE/decompiled"

step "Comparando com o repositório"
same=0; diff=0
while IFS= read -r f; do
  rel=${f#"$OUT"/}
  case $rel in slices/*) continue ;; esac
  case $rel in x86_64/*) ref="$HERE/decompiled/$rel" ;; *) ref="$HERE/$rel" ;; esac
  if cmp -s "$f" "$ref"; then same=$((same + 1)); else diff=$((diff + 1)); echo "  diferente: $rel"; fi
done < <(find "$OUT" -type f | sort)
echo "  idênticos: $same   diferentes: $diff"
printf '\nTempo total: %ds\n' $((SECONDS - t0))
[ "$diff" -eq 0 ]
