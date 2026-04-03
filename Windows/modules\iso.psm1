
Add-Type -AssemblyName System.Windows.Forms

function Select-LinuxISO {
    $dialog = New-Object System.Windows.Forms.OpenFileDialog
    $dialog.Filter = "Fichiers ISO (*.iso)|*.iso"
    $dialog.Title  = "Sélectionner une ISO Linux"

    if ($dialog.ShowDialog() -eq "OK") {
        return $dialog.FileName
    }

    return $null
}

function Get-ISOHash {
    param([string]$ISOPath)

    if (!(Test-Path $ISOPath)) {
        return "ISO introuvable."
    }

    $hash = Get-FileHash -Path $ISOPath -Algorithm SHA256
    return $hash.Hash
}

Export-ModuleMember -Function Select-LinuxISO, Get-ISOHash
