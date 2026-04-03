# Charger les modules
$modulePath = Join-Path $PSScriptRoot "modules"
Import-Module "$modulePath\backup.psm1" -Force
Import-Module "$modulePath\iso.psm1" -Force
Import-Module "$modulePath\usb.psm1" -Force
Import-Module "$modulePath\restore.psm1" -Force

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# =========================
# CONFIG FENÊTRE PRINCIPALE
# =========================
$form               = New-Object System.Windows.Forms.Form
$form.Text          = "WinToLinux Migration - TechNews365"
$form.Size          = New-Object System.Drawing.Size(800, 500)
$form.StartPosition = "CenterScreen"
$form.BackColor     = [System.Drawing.Color]::FromArgb(18,18,18)
$form.ForeColor     = [System.Drawing.Color]::White

# =========================
# POLICE / STYLE
# =========================
$fontTitle   = New-Object System.Drawing.Font("Segoe UI", 16, [System.Drawing.FontStyle]::Bold)
$fontNormal  = New-Object System.Drawing.Font("Segoe UI", 10, [System.Drawing.FontStyle]::Regular)
$accentColor = [System.Drawing.Color]::FromArgb(0, 120, 215)

# =========================
# TITRE
# =========================
$labelTitle = New-Object System.Windows.Forms.Label
$labelTitle.Text      = "WinToLinux Migration"
$labelTitle.Font      = $fontTitle
$labelTitle.AutoSize  = $true
$labelTitle.Location  = New-Object System.Drawing.Point(20, 15)
$form.Controls.Add($labelTitle)

# =========================
# ZONE LOGS
# =========================
$textLog = New-Object System.Windows.Forms.TextBox
$textLog.Multiline  = $true
$textLog.ReadOnly   = $true
$textLog.ScrollBars = "Vertical"
$textLog.Font       = $fontNormal
$textLog.BackColor  = [System.Drawing.Color]::FromArgb(30,30,30)
$textLog.ForeColor  = [System.Drawing.Color]::White
$textLog.Size       = New-Object System.Drawing.Size(540, 380)
$textLog.Location   = New-Object System.Drawing.Point(230, 60)
$form.Controls.Add($textLog)

function Write-Log {
    param([string]$Message)
    $timestamp = (Get-Date).ToString("HH:mm:ss")
    $textLog.AppendText("[$timestamp] $Message`r`n")
}

# =========================
# BOUTONS (WORKFLOW)
# =========================

# Bouton 1 : Sauvegarde
$btnBackup = New-Object System.Windows.Forms.Button
$btnBackup.Text      = "1. Sauvegarder Windows"
$btnBackup.Font      = $fontNormal
$btnBackup.Size      = New-Object System.Drawing.Size(200, 40)
$btnBackup.Location  = New-Object System.Drawing.Point(20, 60)
$btnBackup.BackColor = $accentColor
$btnBackup.ForeColor = [System.Drawing.Color]::White
$form.Controls.Add($btnBackup)

$btnBackup.Add_Click({
    Write-Log "Démarrage de la sauvegarde Windows..."
    # TODO: Appeler ta fonction de backup (module backup.psm1)
    # Start-BackupWindows
    Write-Log "Sauvegarde terminée (placeholder)."
})

# Bouton 2 : ISO Linux
$btnISO = New-Object System.Windows.Forms.Button
$btnISO.Text      = "2. Choisir / Télécharger ISO Linux"
$btnISO.Font      = $fontNormal
$btnISO.Size      = New-Object System.Drawing.Size(200, 40)
$btnISO.Location  = New-Object System.Drawing.Point(20, 110)
$btnISO.BackColor = $accentColor
$btnISO.ForeColor = [System.Drawing.Color]::White
$form.Controls.Add($btnISO)

$btnISO.Add_Click({
    Write-Log "Sélection ou téléchargement d'une ISO Linux..."
    # TODO: Appeler ta fonction de gestion ISO
    # Select-LinuxISO
    Write-Log "ISO sélectionnée (placeholder)."
})

# Bouton 3 : Clé USB
$btnUSB = New-Object System.Windows.Forms.Button
$btnUSB.Text      = "3. Préparer la clé USB bootable"
$btnUSB.Font      = $fontNormal
$btnUSB.Size      = New-Object System.Drawing.Size(200, 40)
$btnUSB.Location  = New-Object System.Drawing.Point(20, 160)
$btnUSB.BackColor = $accentColor
$btnUSB.ForeColor = [System.Drawing.Color]::White
$form.Controls.Add($btnUSB)

$btnUSB.Add_Click({
    Write-Log "Préparation de la clé USB..."
    # TODO: Appeler ta fonction de création USB
    # Write-BootableUSB
    Write-Log "Clé USB prête (placeholder)."
})

# Bouton 4 : Restauration
$btnRestore = New-Object System.Windows.Forms.Button
$btnRestore.Text      = "4. Restaurer les données sous Linux"
$btnRestore.Font      = $fontNormal
$btnRestore.Size      = New-Object System.Drawing.Size(200, 40)
$btnRestore.Location  = New-Object System.Drawing.Point(20, 210)
$btnRestore.BackColor = $accentColor
$btnRestore.ForeColor = [System.Drawing.Color]::White
$form.Controls.Add($btnRestore)

$btnRestore.Add_Click({
    Write-Log "Restauration des données sous Linux..."
    # TODO: Appeler ta fonction de restauration
    # Restore-UserData
    Write-Log "Restauration terminée (placeholder)."
})

# =========================
# LANCEMENT
# =========================
[void]$form.ShowDialog()
