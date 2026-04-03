# ============================
#   Build EXE WinToLinux
# ============================

Write-Host "Compilation de WinToLinux.exe..." -ForegroundColor Cyan

$input  = "WinToLinux.ps1"
$output = "WinToLinux.exe"
$icon   = "logo.ico"

# Vérification des fichiers
if (!(Test-Path $input))  { Write-Host "ERREUR : WinToLinux.ps1 introuvable." -ForegroundColor Red; exit }
if (!(Test-Path $icon))   { Write-Host "ERREUR : logo.ico introuvable." -ForegroundColor Red; exit }

# Lancer PS2EXE
Invoke-Expression -Command @"
ps2exe `
  -inputFile "$input" `
  -outputFile "$output" `
  -iconFile "$icon" `
  -title "WinToLinux Migration" `
  -description "Migration Windows vers Linux - TechNews365" `
  -product "WinToLinux Migration" `
  -version "1.0.0"
"@

Write-Host "Compilation terminée !" -ForegroundColor Green
Write-Host "Fichier généré : $output"
