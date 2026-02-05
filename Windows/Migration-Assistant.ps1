Clear-Host
Write-Host "==============================================="
Write-Host "     Assistant de Migration Windows → Linux"
Write-Host "==============================================="
Write-Host ""
Write-Host "1. Analyse du système"
Write-Host "2. Sauvegarde des données"
Write-Host "3. Télécharger une ISO Linux"
Write-Host "4. Créer une clé USB bootable"
Write-Host "5. Générer un rapport"
Write-Host "6. Quitter"
Write-Host ""

$choice = Read-Host "Votre choix"

switch ($choice) {

    "1" {
        ./Backup.ps1 -AnalyseOnly
        Pause
    }

    "2" {
        ./Backup.ps1
        Pause
    }

    "3" {
        ./Download-ISO.ps1
        Pause
    }

    "4" {
        ./Create-USB.ps1
        Pause
    }

    "5" {
        ./Report.ps1
        Pause
    }

    "6" {
        Write-Host "Au revoir."
        exit
    }

    default {
        Write-Host "Choix invalide."
        Pause
    }
}
