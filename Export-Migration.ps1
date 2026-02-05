$MigrationFolder = "C:\Migration-Data"
$JsonFile = "$MigrationFolder\migration.json"

New-Item -ItemType Directory -Force -Path $MigrationFolder

# Export user data
Copy-Item "$env:USERPROFILE\Documents" "$MigrationFolder\Documents" -Recurse
Copy-Item "$env:USERPROFILE\Pictures" "$MigrationFolder\Pictures" -Recurse

# Create metadata file
$MigrationInfo = @{
    UserName = $env:USERNAME
    ExportDate = (Get-Date)
    WindowsVersion = (Get-ComputerInfo).WindowsVersion
    DataFolders = @("Documents","Pictures")
}

$MigrationInfo | ConvertTo-Json | Out-File $JsonFile

# Create ZIP
Compress-Archive -Path $MigrationFolder -DestinationPath "Migration-Package.zip" -Force

Write-Host "Migration package created successfully."
