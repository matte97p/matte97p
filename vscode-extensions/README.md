# Profili estensioni VS Code (WSL + Windows)

Backup delle estensioni per ripristinare il setup su un PC nuovo.
Principio: **i language server stanno su WSL** (dove gira il codice), **Windows tiene solo il ponte + il tema** (la UI gira in locale).

## File
- `windows-extensions.txt` / `install-windows.ps1` — lato Windows (2 estensioni: `remote-wsl` + tema)
- `wsl-extensions.txt` / `install-wsl.sh` — lato WSL (17 estensioni: i veri tool di lavoro)

## Ripristino su PC nuovo (ordine importante)

1. **Windows** — installa VS Code, poi da PowerShell:
   ```powershell
   powershell -ExecutionPolicy Bypass -File install-windows.ps1
   ```
   Questo mette `ms-vscode-remote.remote-wsl` (il ponte) + il tema.

2. **Connettiti a WSL** — apri una cartella in WSL (`code .` da dentro Ubuntu, oppure "WSL: Connect to WSL").

3. **WSL** — da quella finestra connessa:
   ```bash
   bash install-wsl.sh
   ```
   `code` qui punta al server remoto, quindi installa tutto sul lato Linux giusto.

## Rigenerare le liste (se aggiungi/togli estensioni)
```bash
# WSL
code --list-extensions > wsl-extensions.txt
# Windows (da PowerShell)
code --list-extensions > windows-extensions.txt
```
