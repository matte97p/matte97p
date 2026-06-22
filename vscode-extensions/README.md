# Profili estensioni VS Code

Setup riproducibile delle estensioni, organizzato a **base condivisa + strato per-contesto**.
Principio: una base identica ovunque, più i pochi add-on specifici della macchina.

## Struttura

| File | Cosa contiene | Dove |
|---|---|---|
| `base.txt` | 16 estensioni condivise (Python, Git/GitHub, Vue/Tailwind, Docker, YAML, Claude, tema, + utility CSV/PDF) | Mac + WSL/Linux |
| `work.txt` | add-on lavoro: AWS Toolkit, Terraform | Mac di lavoro |
| `private.txt` | add-on personale: Godot | WSL/Linux privato |
| `windows-host.txt` | solo il ponte: `remote-wsl` + tema | host Windows del setup WSL |

Perché lo split e non una lista unica: Godot sul Mac di lavoro o AWS/Terraform sul privato sarebbero peso morto. La base resta allineata, i tail no.

## Scripts

- `install.sh [work|private]` — installa base + lo strato scelto (Mac e WSL/Linux).
- `install-windows.ps1` — host Windows (solo ponte + tema), da PowerShell.
- `check.sh [work|private]` — confronta l'installato con base+strato e segnala il drift (read-only).

## Ripristino su PC nuovo

**Mac (lavoro)**
```bash
bash install.sh work
```

**Windows + WSL (privato)** — nell'ordine:
1. Su Windows, da PowerShell: `powershell -ExecutionPolicy Bypass -File install-windows.ps1` (mette il ponte `remote-wsl`).
2. Connettiti a WSL (apri una cartella in WSL).
3. Da quella finestra WSL: `bash install.sh private`.

## Tenere allineato

Dopo aver aggiunto/tolto estensioni, lancia `bash check.sh`: ti dice cosa è "in più" (da classificare in base/work/private) o "in meno". Aggiorni il `.txt` giusto a mano e poi:
```bash
git commit -am "aggiorna profili estensioni vscode" && git push
```

## Sync automatico (alternativa/complemento)

Per il ripristino automatico zero-sforzo c'è **VS Code Settings Sync** (login GitHub → tutto si scarica). Attenzione: di default rende ogni macchina identica, quindi per mantenere lo split base/strato usa i **Profiles** di VS Code o la lista "ignored extensions" per-macchina. Questo repo resta la copia versionata e ispezionabile.
