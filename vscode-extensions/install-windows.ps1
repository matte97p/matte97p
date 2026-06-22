# Profilo estensioni VS Code - lato Windows (host)
# Lancialo da PowerShell SU WINDOWS (NON da WSL): qui `code` e' la CLI di VS Code Windows.
#   powershell -ExecutionPolicy Bypass -File install-windows.ps1
# Tieni il lato Windows minimale: solo il ponte verso WSL + il tema (la UI gira in locale).

$exts = @(
  "ms-vscode-remote.remote-wsl",   # IL ponte verso WSL - essenziale
  "akamud.vscode-theme-onedark"    # tema (la UI gira sul lato Windows)
)

foreach ($e in $exts) {
  code --install-extension $e --force
}
Write-Host "Fatto: $($exts.Count) estensioni installate sul lato Windows."
