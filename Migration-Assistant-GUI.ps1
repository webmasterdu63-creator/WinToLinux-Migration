Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Fenêtre
$form = New-Object System.Windows.Forms.Form
$form.Text = "Assistant de Migration Windows → Linux"
$form.Size = New-Object System.Drawing.Size(650, 500)
$form.StartPosition = "CenterScreen"

# Titre
$labelTitle = New-Object System.Windows.Forms.Label
$labelTitle.Text = "Assistant de Migration Windows → Linux"
$labelTitle.AutoSize = $true
$labelTitle.Font = New-Object System.Drawing.Font("Segoe UI", 14, [System.Drawing.FontStyle]::Bold)
$labelTitle.Location = New-Object System.Drawing.Point(120, 20)
$form.Controls.Add($labelTitle)

# Zone de log
$logBox = New-Object System.Windows.Forms.RichTextBox
$logBox.ReadOnly = $true
$logBox.Size = New-Object System.Drawing.Size(600, 180)
$logBox.Location = New-Object System.Drawing.Point(20, 260)
$form.Controls.Add($logBox)

function Write-Log($msg, $color="Black") {
    $logBox.SelectionColor = $color
    $logBox.AppendText("[$(Get-Date -Format 'HH:mm:ss')] $msg`r`n")
}

# --- Sélecteur de distribution Linux ---
$labelDistro = New-Object System.Windows.Forms.Label
$labelDistro.Text = "Distribution Linux :"
$labelDistro.Location = New-Object System.Drawing.Point(20, 70)
$form.Controls.Add($labelDistro)

$comboDistro = New-Object System.Windows.Forms.ComboBox
$comboDistro.Location = New-Object System.Drawing.Point(150, 65)
$comboDistro.Width = 200
$comboDistro.Items.AddRange(@("Ubuntu", "Linux Mint", "Debian"))
$comboDistro.SelectedIndex = 0
$form.Controls.Add($comboDistro)

# --- Détection automatique des clés USB ---
function Get-USBDrives {
    Get-WmiObject Win32_LogicalDisk | Where-Object { $_.DriveType -eq 2 }
}

$labelUSB = New-Object System.Windows.Forms.Label
$labelUSB.Text = "Clé USB détectée :"
$labelUSB.Location = New-Object System.Drawing.Point(20, 110)
$form.Controls.Add($labelUSB)

$comboUSB = New-Object System.Windows.Forms.ComboBox
$comboUSB.Location = New-Object System.Drawing.Point(150, 105)
$comboUSB.Width = 200
$form.Controls.Add($comboUSB)

# Charger les clés USB au démarrage
$usbList = Get-USBDrives
foreach ($usb in $usbList) {
    $comboUSB.Items.Add("$($usb.DeviceID) — $($usb.VolumeName)")
}
if ($comboUSB.Items.Count -gt 0) { $comboUSB.SelectedIndex = 0 }

# --- Boutons d’actions ---
$buttons = @(
    @{ Text = "Analyse système";      X = 400; Y = 60;  Script = ".\Backup.ps1 -AnalyseOnly" },
    @{ Text = "Sauvegarde données";   X = 400; Y = 100; Script = ".\Backup.ps1" },
    @{ Text = "Télécharger ISO";      X = 20;  Y = 150; Script = ".\Download-ISO.ps1" },
    @{ Text = "Créer clé USB";        X = 400; Y = 150; Script = ".\Create-USB.ps1" },
    @{ Text = "Générer rapport";      X = 20;  Y = 190; Script = ".\Report.ps1" }
)

foreach ($b in $buttons) {
    $btn = New-Object System.Windows.Forms.Button
    $btn.Text = $b.Text
    $btn.Size = New-Object System.Drawing.Size(200, 30)
    $btn.Location = New-Object System.Drawing.Point($b.X, $b.Y)
    $btn.Add_Click({
        Write-Log "Exécution : $($this.Text)" "Blue"
        try {
            Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$($b.Script)`"" -Wait
            Write-Log "Terminé : $($this.Text)" "Green"
        } catch {
            Write-Log "Erreur lors de l'exécution." "Red"
        }
    })
    $form.Controls.Add($btn)
}

# --- Boutons ouvrir dossier ---
$btnOpenBackup = New-Object System.Windows.Forms.Button
$btnOpenBackup.Text = "Ouvrir sauvegarde"
$btnOpenBackup.Size = New-Object System.Drawing.Size(150, 30)
$btnOpenBackup.Location = New-Object System.Drawing.Point(20, 450)
$btnOpenBackup.Add_Click({ Start-Process "C:\WinToLinux-Backup" })
$form.Controls.Add($btnOpenBackup)

$btnOpenISO = New-Object System.Windows.Forms.Button
$btnOpenISO.Text = "Ouvrir ISO"
$btnOpenISO.Size = New-Object System.Drawing.Size(150, 30)
$btnOpenISO.Location = New-Object System.Drawing.Point(200, 450)
$btnOpenISO.Add_Click({ Start-Process "C:\WinToLinux-ISO" })
$form.Controls.Add($btnOpenISO)

# --- Quitter ---
$btnQuit = New-Object System.Windows.Forms.Button
$btnQuit.Text = "Quitter"
$btnQuit.Size = New-Object System.Drawing.Size(100, 30)
$btnQuit.Location = New-Object System.Drawing.Point(520, 450)
$btnQuit.Add_Click({ $form.Close() })
$form.Controls.Add($btnQuit)

[void]$form.ShowDialog()

