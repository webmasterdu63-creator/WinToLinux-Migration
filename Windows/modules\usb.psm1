
function Get-USBDrives {
    Get-WmiObject Win32_DiskDrive |
        Where-Object { $_.InterfaceType -eq "USB" } |
        Select-Object Model, DeviceID
}

Export-ModuleMember -Function Get-USBDrives
function Format-USBDrive {
    param([string]$DeviceID)

    $diskNumber = ($DeviceID -replace "[^\d]").Trim()

    $script = @"
select disk $diskNumber
clean
create partition primary
format fs=fat32 quick
assign
exit
"@

    $scriptPath = "$env:TEMP\diskpart_script.txt"
    $script | Out-File -FilePath $scriptPath -Encoding ASCII

    Write-Log "Formatage de la clé USB..."
    diskpart /s $scriptPath | Out-Null

    Remove-Item $scriptPath -Force
}
