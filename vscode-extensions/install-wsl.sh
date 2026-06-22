#!/usr/bin/env bash
# Profilo estensioni VS Code — lato WSL (Ubuntu)
# Lancialo DA UNA FINESTRA CONNESSA A WSL: qui `code` punta al server remoto.
#   bash install-wsl.sh
set -euo pipefail

EXTS=(
  akamud.vscode-theme-onedark      # tema (UI; opzionale lato WSL, gira comunque in locale)
  analytic-signal.preview-pdf      # anteprima PDF (output pentest-framework)
  anthropic.claude-code            # Claude Code
  bradlc.vscode-tailwindcss        # Tailwind (geo FE)
  eamodio.gitlens                  # blame inline + history
  geequlim.godot-tools             # Godot (perinopolis)
  github.vscode-github-actions     # CI (workflow in quasi tutti i repo)
  github.vscode-pull-request-github# PR GitHub (repo OSS)
  mechatroner.rainbow-csv          # CSV
  mhutchie.git-graph               # grafo commit
  ms-azuretools.vscode-containers  # Docker (cato + geo)
  ms-python.debugpy                # debugger Python
  ms-python.python                 # Python (geo BE, pentest)
  ms-python.vscode-pylance         # language server Python
  ms-python.vscode-python-envs     # gestione env Python
  redhat.vscode-yaml               # YAML
  vue.volar                        # Vue/Nuxt (geo FE)
)

for e in "${EXTS[@]}"; do
  code --install-extension "$e" --force
done
echo "Fatto: ${#EXTS[@]} estensioni installate sul lato WSL."
