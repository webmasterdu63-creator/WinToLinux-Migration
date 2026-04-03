# =========================
#   WinToLinux Migration
#   Interface WinForms
#   by TechNews365
# =========================

# Charger les assemblies WinForms
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# =========================
#   CHARGEMENT DES MODULES
# =========================
$modulePath = Join-Path $PSScriptRoot "modules"

Import-Module "$modulePath\backup.psm1"  -Force
Import-Module "$modulePath\iso.psm1"     -Force
Import-Module "$modulePath\usb.psm1"     -Force
Import-Module "$modulePath\restore.psm1" -Force

# =========================
#   FENÊTRE PRINCIPALE
# =========================
$form               = New-Object System.Windows.Forms.Form
$form.Text          = "WinToLinux Migration - TechNews365"
$form.Size          = New-Object System.Drawing.Size(820, 520)
$form.StartPosition = "CenterScreen"
$form.BackColor     = [System.Drawing.Color]::FromArgb(18,18,18)
$form.ForeColor     = [System.Drawing.Color]::White
$form.FormBorderStyle = "FixedDialog"
$form.MaximizeBox   = $false

# =========================
#   POLICES & COULEURS
# =========================
$fontTitle   = New-Object System.Drawing.Font("Segoe UI", 16, [System.Drawing.FontStyle]::Bold)
$fontNormal  = New-Object System.Drawing.Font("Segoe UI", 10)
$accentColor = [System.Drawing.Color]::FromArgb(0, 120, 215)

# =========================
#   TITRE
# =========================
$labelTitle = New-Object System.Windows.Forms.Label
$labelTitle.Text      = "WinToLinux Migration"
$labelTitle.Font      = $fontTitle
$labelTitle.AutoSize  = $true
$labelTitle.Location  = New-Object System.Drawing.Point(20, 15)
$form.Controls.Add($labelTitle)

# =========================
#   ZONE LOGS
# =========================
$textLog = New-Object System.Windows.Forms.TextBox
$textLog.Multiline  = $true
$textLog.ReadOnly   = $true
$textLog.ScrollBars = "Vertical"
$textLog.Font       = $fontNormal
$textLog.BackColor  = [System.Drawing.Color]::FromArgb(30,30,30)
$textLog.ForeColor  = [System.Drawing.Color]::White
$textLog.Size       = New-Object System.Drawing.Size(550, 400)
$textLog.Location   = New-Object System.Drawing.Point(240, 60)
$form.Controls.Add($textLog)

function Write-Log {
    param([string]$Message)
    $timestamp = (Get-Date).ToString("HH:mm:ss")
    $textLog.AppendText("[$timestamp] $Message`r`n")
}

# =========================
#   PROGRESS BAR
# =========================
$progressBar = New-Object System.Windows.Forms.ProgressBar
$progressBar.Style = "Continuous"
$progressBar.Minimum = 0
$progressBar.Maximum = 100
$progressBar.Value = 0
$progressBar.Size = New-Object System.Drawing.Size(550, 25)
$progressBar.Location = New-Object System.Drawing.Point(240, 470)
$form.Controls.Add($progressBar)

# =========================
#   ANIMATION PROGRESS BAR
# =========================
function Animate-Progress {
    param(
        [int]$Duration = 2000,
        [int]$Steps = 50
    )

    $interval = $Duration / $Steps

    for ($i = 0; $i -le $Steps; $i++) {
        $percent = [math]::Round(($i / $Steps) * 100)
        $progressBar.Value = $percent
        Start-Sleep -Milliseconds $interval
    }

    Start-Sleep -Milliseconds 300
    $progressBar.Value = 0
}

# =========================
#   BOUTONS DU WORKFLOW
# =========================

# --- 1. Sauvegarde Windows ---
$btnBackup = New-Object System.Windows.Forms.Button
$btnBackup.Text      = "1. Sauvegarder Windows"
$btnBackup.Font      = $fontNormal
$btnBackup.Size      = New-Object System.Drawing.Size(200, 40)
$btnBackup.Location  = New-Object System.Drawing.Point(20, 60)
$btnBackup.BackColor = $accentColor
$btnBackup.ForeColor = [System.Drawing.Color]::White
$form.Controls.Add($btnBackup)

$btnBackup.Add_Click({
    Write-Log "Démarrage de la sauvegarde..."
    Animate-Progress -Duration 2500
    $result = Start-BackupWindows
    Write-Log $result
})

# --- 2. ISO Linux ---
$btnISO = New-Object System.Windows.Forms.Button
$btnISO.Text      = "2. Choisir / Télécharger ISO Linux"
$btnISO.Font      = $fontNormal
$btnISO.Size      = New-Object System.Drawing.Size(200, 40)
$btnISO.Location  = New-Object System.Drawing.Point(20, 110)
$btnISO.BackColor = $accentColor
$btnISO.ForeColor = [System.Drawing.Color]::White
$form.Controls.Add($btnISO)

$btnISO.Add_Click({
    Write-Log "Sélection d'une ISO Linux..."
    Animate-Progress -Duration 1500

    $iso = Select-LinuxISO

    if ($iso) {
        Write-Log "ISO sélectionnée : $iso"
        $hash = Get-ISOHash -ISOPath $iso
        Write-Log "SHA256 : $hash"
    } else {
        Write-Log "Aucune ISO sélectionnée."
    }
})
# --- 3. Clé USB ---
$btnUSB = New-Object System.Windows.Forms.Button
$btnUSB.Text      = "3. Préparer la clé USB bootable"
$btnUSB.Font      = $fontNormal
$btnUSB.Size      = New-Object System.Drawing.Size(200, 40)
$btnUSB.Location  = New-Object System.Drawing.Point(20, 160)
$btnUSB.BackColor = $accentColor
$btnUSB.ForeColor = [System.Drawing.Color]::White
$form.Controls.Add($btnUSB)

# 👉 Add_Click USB (correct)
$btnUSB.Add_Click({
    Write-Log "Analyse des périphériques USB..."
    Animate-Progress -Duration 2000
    Refresh-USBList
})
# --- 3b. Créer la clé USB bootable ---
$btnWriteUSB = New-Object System.Windows.Forms.Button
$btnWriteUSB.Text      = "3b. Créer la clé USB bootable"
$btnWriteUSB.Font      = $fontNormal
$btnWriteUSB.Size      = New-Object System.Drawing.Size(200, 40)
$btnWriteUSB.Location  = New-Object System.Drawing.Point(20, 210)
$btnWriteUSB.BackColor = [System.Drawing.Color]::FromArgb(0, 150, 100)
$btnWriteUSB.ForeColor = [System.Drawing.Color]::White
$form.Controls.Add($btnWriteUSB)

# --- 4. Restauration ---
$btnRestore = New-Object System.Windows.Forms.Button
$btnRestore.Text      = "4. Restaurer les données sous Linux"
$btnRestore.Font      = $fontNormal
$btnRestore.Size      = New-Object System.Drawing.Size(200, 40)
$btnRestore.Location  = New-Object System.Drawing.Point(20, 210)
$btnRestore.BackColor = $accentColor
$btnRestore.ForeColor = [System.Drawing.Color]::White
$form.Controls.Add($btnRestore)

$btnRestore.Add_Click({
    Write-Log "Restauration des données..."
    Animate-Progress -Duration 2500
    $result = Restore-UserData
    Write-Log $result
})
Format-USBDrive -DeviceID $deviceID -Logger { param($msg) Write-Log $msg }

