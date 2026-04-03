function Start-Backup {
    param(
        [Parameter(Mandatory)]
        [string]$SourcePath,

        [Parameter(Mandatory)]
        [string]$DestinationPath
    )

    try {
        if (-not (Test-Path $SourcePath)) {
            throw "Le chemin source n'existe pas : $SourcePath"
        }

        if (-not (Test-Path $DestinationPath)) {
            New-Item -ItemType Directory -Path $DestinationPath -Force | Out-Null
        }

        $timestamp = Get-Date -Format "yyyyMMdd-HHmmss"
        $backupFolder = Join-Path $DestinationPath "Backup-$timestamp"

        Copy-Item -Path $SourcePath -Destination $backupFolder -Recurse -Force

        Write-Output "Backup terminé : $backupFolder"
    }
    catch {
        Write-Error "Erreur pendant le backup : $_"
    }
}

Export-ModuleMember -Function Start-Backup
