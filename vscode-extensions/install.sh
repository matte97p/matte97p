#!/usr/bin/env bash
# Installa la BASE condivisa + uno strato per-contesto. Vale per Mac e WSL/Linux
# (entrambi hanno `code` nel PATH). Per l'host Windows usa install-windows.ps1.
#
#   bash install.sh work      # Mac di lavoro  -> base + AWS/Terraform
#   bash install.sh private   # WSL/Linux privato -> base + Godot
#   bash install.sh           # solo base
#
# Su WSL lancialo da una finestra connessa a WSL (`code` punta al server remoto).
set -euo pipefail
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAYER="${1:-}"

files=("$DIR/base.txt")
case "$LAYER" in
  work)    files+=("$DIR/work.txt") ;;
  private) files+=("$DIR/private.txt") ;;
  "")      echo "Solo base. Per aggiungere uno strato: install.sh [work|private]" ;;
  *) echo "Strato sconosciuto: '$LAYER' (validi: work | private)"; exit 1 ;;
esac

count=0
for f in "${files[@]}"; do
  while IFS= read -r ext; do
    case "$ext" in ""|\#*) continue ;; esac
    code --install-extension "$ext" --force
    count=$((count + 1))
  done < "$f"
done
echo "Fatto: $count estensioni installate (base${LAYER:+ + $LAYER})."
