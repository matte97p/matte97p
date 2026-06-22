#!/usr/bin/env bash
# Confronta le estensioni REALMENTE installate con (base + strato) e mostra il drift.
# Rileva la macchina: macOS -> work, altrimenti -> private. Override: ./check.sh work|private
#
# Read-only: non installa e non committa nulla. Dice solo cosa spostare dove,
# poi aggiorni a mano i .txt (sono minuscoli) e fai commit+push.
set -euo pipefail
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

layer="${1:-}"
if [ -z "$layer" ]; then
  [ "$(uname -s)" = "Darwin" ] && layer=work || layer=private
fi
echo "Strato rilevato: $layer"

expected="$(cat "$DIR/base.txt" "$DIR/$layer.txt" | grep -vE '^[[:space:]]*(#|$)' | sort -u)"
installed="$(code --list-extensions | grep -E '^[^[:space:]]+\.[^[:space:]]+$' | sort -u)"

extra="$(comm -13 <(printf '%s\n' "$expected") <(printf '%s\n' "$installed"))"
missing="$(comm -23 <(printf '%s\n' "$expected") <(printf '%s\n' "$installed"))"

echo
echo "+ Installate ma NON nei profili (classificale in base/work/private):"
[ -n "$extra" ] && printf '   %s\n' $extra || echo "   (nessuna)"
echo
echo "- Nei profili ma NON installate (le mette install.sh):"
[ -n "$missing" ] && printf '   %s\n' $missing || echo "   (nessuna)"
