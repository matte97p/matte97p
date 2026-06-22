#!/usr/bin/env bash
# Rigenera le liste estensioni dallo stato REALE e (se la cartella e' un repo git) committa+pusha.
# Lancialo da una finestra connessa a WSL, dopo aver aggiunto/tolto estensioni:
#   bash update-profiles.sh
set -euo pipefail
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# WSL: in una finestra connessa a WSL, `code` punta al server remoto.
if command -v code >/dev/null 2>&1; then
  code --list-extensions | sort > "$DIR/wsl-extensions.txt"
  echo "WSL -> $(wc -l < "$DIR/wsl-extensions.txt") estensioni"
fi

# Windows: leggo direttamente il registro del lato Windows via /mnt/c.
WIN=/mnt/c/Users/matte/.vscode/extensions/extensions.json
if [ -f "$WIN" ]; then
  python3 -c "import json;print('\n'.join(sorted(e['identifier']['id'] for e in json.load(open('$WIN')))))" \
    > "$DIR/windows-extensions.txt"
  echo "Windows -> $(wc -l < "$DIR/windows-extensions.txt") estensioni"
fi

# Commit+push solo se siamo in un repo e qualcosa e' cambiato.
if git -C "$DIR" rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  if ! git -C "$DIR" diff --quiet -- wsl-extensions.txt windows-extensions.txt 2>/dev/null \
     || [ -n "$(git -C "$DIR" ls-files --others --exclude-standard -- wsl-extensions.txt windows-extensions.txt)" ]; then
    git -C "$DIR" add wsl-extensions.txt windows-extensions.txt
    git -C "$DIR" commit -m "chore: aggiorna profili estensioni vscode"
    git -C "$DIR" push 2>/dev/null && echo "pushato." || echo "commit fatto (push manuale: nessun remote o offline)."
  else
    echo "Nessuna modifica alle liste."
  fi
else
  echo "(cartella non ancora sotto git: liste rigenerate, niente commit)"
fi
