Clear-Host
Write-Host "==============================================="
Write-Host "     Téléchargement d'une ISO Linux"
Write-Host "==============================================="
Write-Host ""
Write-Host "1. Ubuntu 22.04 LTS"
Write-Host "2. Linux Mint 21.3"
Write-Host "3. Debian 12"
Write-Host "4. Quitter"
Write-Host ""

$choice = Read-Host "Votre choix"

# Dossier de destination
$isoPath = "C:\WinToLinux-ISO"
if (-not (Test-Path $isoPath)) {
    New-Item -ItemType Directory -Path $isoPath | Out-Null
}

switch ($choice) {

    "1" {
        $url = "https://releases.ubuntu.com/22.04/ubuntu-22.04.4-desktop-amd64.iso"
        $file = "$isoPath\ubuntu.iso"
        Write-Host "Téléchargement de Ubuntu..."
    }

    "2" {
        $url = "https://mirrors.edge.kernel.org/linuxmint/stable/21.3/linuxmint-21.3-cinnamon-64bit.iso"
        $file = "$isoPath\linuxmint.iso"
        Write-Host "Téléchargement de Linux Mint..."
    }

    "3" {
        $url = "https://cdimage.debian.org/debian-cd/current/amd64/iso-dvd/debian-12.5.0-amd64-DVD-1.iso"
        $file = "$isoPath\debian.iso"
        Write-Host "Téléchargement de Debian..."
    }

    "4" {
        Write-Host "Annulé."
        exit
    }

    default {
        Write-Host "Choix invalide."
        exit
    }
}

Write-Host ""
Write-Host "Téléchargement en cours..."
Invoke-WebRequest -Uri $url -OutFile $file -UseBasicParsing

Write-Host ""
Write-Host "ISO téléchargée avec succès :"
Write-Host $file
Pause
