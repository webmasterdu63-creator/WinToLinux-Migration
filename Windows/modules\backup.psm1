
function Start-BackupWindows {
    param(
        [string]$Destination = "$env:USERPROFILE\WinToLinux-Backup"
    )

    if (!(Test-Path $Destination)) {
        New-Item -ItemType Directory -Path $Destination | Out-Null
    }

    $folders = @("Documents", "Pictures", "Desktop", "Downloads")

    foreach ($folder in $folders) {
        $source = Join-Path $env:USERPROFILE $folder
        $target = Join-Path $Destination $folder

        if (Test-Path $source) {
            Copy-Item $source -Destination $target -Recurse -Force
        }
    }

    return "Sauvegarde terminée dans : $Destination"
}

Export-ModuleMember -Function Start-BackupWindows
