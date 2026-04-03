function Format-USBDrive {
    param(
        [string]$DeviceID,
        [scriptblock]$Logger
    )

    $diskNumber = ($DeviceID -replace "[^\d]").Trim()

    & $Logger "Formatage de la clé USB..."

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

    diskpart /s $scriptPath | Out-Null

    Remove-Item $scriptPath -Force
}
Export-ModuleMember -Function Get-USBDrives, Format-USBDrive
