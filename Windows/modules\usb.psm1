
function Get-USBDrives {
    Get-WmiObject Win32_DiskDrive |
        Where-Object { $_.InterfaceType -eq "USB" } |
        Select-Object Model, DeviceID
}

Export-ModuleMember -Function Get-USBDrives
