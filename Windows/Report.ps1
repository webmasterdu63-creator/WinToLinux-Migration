Clear-Host
Write-Host "==============================================="
Write-Host "     Génération du rapport de migration"
Write-Host "==============================================="
Write-Host ""

$backupPath = "C:\WinToLinux-Backup"
$isoPath = "C:\WinToLinux-ISO"
$reportFile = "$backupPath\report.html"

if (-not (Test-Path $backupPath)) {
    Write-Host "Aucune sauvegarde trouvée."
    Pause
    exit
}

# Analyse système
$os = (Get-CimInstance Win32_OperatingSystem).Caption
$cpu = (Get-CimInstance Win32_Processor).Name
$ram = [math]::Round((Get-CimInstance Win32_ComputerSystem).TotalPhysicalMemory / 1GB, 2)
$diskFree = [math]::Round((Get-PSDrive C).Free / 1GB, 2)

# ISO
$iso = Get-ChildItem $isoPath -Filter *.iso -ErrorAction SilentlyContinue

# Dossiers sauvegardés
$savedFolders = Get-ChildItem $backupPath | Where-Object { $_.PSIsContainer }

# Génération HTML
$html = @"
<html>
<head>
<title>Rapport de Migration Windows → Linux</title>
<style>
body { font-family: Arial; margin: 20px; }
h1 { color: #2c3e50; }
h2 { color: #2980b9; }
ul { line-height: 1.6; }
</style>
</head>
<body>

<h1>Rapport de Migration Windows → Linux</h1>
<p>Généré le $(Get-Date)</p>

<h2>1. Informations système</h2>
<ul>
<li><b>Système :</b> $os</li>
<li><b>CPU :</b> $cpu</li>
<li><b>Mémoire RAM :</b> $ram Go</li>
<li><b>Espace libre sur C:</b> $diskFree Go</li>
</ul>

<h2>2. Sauvegarde des données</h2>
<ul>
"@

foreach ($folder in $savedFolders) {
    $html += "<li>$($folder.Name)</li>"
}

$html += @"
</ul>

<h2>3. ISO Linux téléchargée</h2>
<ul>
<li>$($iso.Name)</li>
</ul>

<h2>4. Étapes restantes</h2>
<ul>
<li>Redémarrer l’ordinateur</li>
<li>Bootez sur la clé USB (F12, F9, ESC selon le PC)</li>
<li>Installer Linux</li>
<li>Lancer le script de restauration sous Linux</li>
</ul>

</body>
</html>
"@

$html | Out-File -FilePath $reportFile -Encoding UTF8

Write-Host ""
Write-Host "Rapport généré avec succès :"
Write-Host $reportFile
Pause
