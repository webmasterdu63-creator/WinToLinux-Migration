
function Restore-UserData {
    param(
        [string]$BackupPath = "$env:USERPROFILE\WinToLinux-Backup",
        [string]$Destination = "$env:HOME"
    )

    if (!(Test-Path $BackupPath)) {
        return "Aucune sauvegarde trouvée."
    }

    Copy-Item $BackupPath\* -Destination $Destination -Recurse -Force

    return "Restauration terminée."
}

Export-ModuleMember -Function Restore-UserData
