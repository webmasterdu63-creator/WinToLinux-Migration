Clear-Host
Write-Host "==============================================="
Write-Host "     Création d'une clé USB bootable Linux"
Write-Host "==============================================="
Write-Host ""

# Vérification ISO
$isoPath = "C:\WinToLinux-ISO"
$iso = Get-ChildItem $isoPath -Filter *.iso -ErrorAction SilentlyContinue

if (-not $iso) {
    Write-Host "Aucune ISO trouvée dans $isoPath"
    Write-Host "Veuillez d'abord télécharger une ISO."
    Pause
    exit
}

Write-Host "ISO détectée : $($iso.Name)"
Write-Host ""

# Vérification Rufus
$rufusExe = "$env:TEMP\rufus.exe"

if (-not (Test-Path $rufusExe)) {
    Write-Host "Téléchargement de Rufus..."
    Invoke-WebRequest -Uri "https://github.com/pbatard/rufus/releases/latest/download/rufus.exe" -OutFile $rufusExe
}

# Liste des disques USB
Write-Host "Détection des clés USB..."
$usbDisks = Get-Disk | Where-Object { $_.BusType -eq "USB" }

if (-not $usbDisks) {
    Write-Host "Aucune clé USB détectée."
    Pause
    exit
}

Write-Host ""
Write-Host "Clés USB disponibles :"
$usbDisks | Format-Table Number, FriendlyName, Size

$diskNumber = Read-Host "Numéro du disque USB à utiliser"

$selectedDisk = $usbDisks | Where-Object { $_.Number -eq $diskNumber }

if (-not $selectedDisk) {
    Write-Host "Disque invalide."
    Pause
    exit
}

Write-Host ""
Write-Host "Création de la clé USB bootable..."
Write-Host "Cette opération va effacer tout le contenu de la clé."
Pause

# Lancement de Rufus en mode automatique
Start-Process -FilePath $rufusExe -ArgumentList `
    "--device=$diskNumber", `
    "--iso=""$($iso.FullName)""", `
    "--quiet"

Write-Host ""
Write-Host "Clé USB bootable créée avec succès !"
Pause
