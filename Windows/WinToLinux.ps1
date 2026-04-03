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
$form.Controls.Add($btn
