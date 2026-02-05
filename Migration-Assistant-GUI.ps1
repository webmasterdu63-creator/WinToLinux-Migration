Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Fenêtre
$form = New-Object System.Windows.Forms.Form
$form.Text = "Assistant de Migration Windows → Linux"
$form.Size = New-Object System.Drawing.Size(600, 400)
$form.StartPosition = "CenterScreen"

# Titre
$labelTitle = New-Object System.Windows.Forms.Label
$labelTitle.Text = "Assistant de Migration Windows → Linux"
$labelTitle.AutoSize = $true
$labelTitle.Font = New-Object System.Drawing.Font("Segoe UI", 14, [System.Drawing.FontStyle]::Bold)
$labelTitle.Location = New-Object System.Drawing.Point(80, 20)
$form.Controls.Add($labelTitle)

# Zone de log
$logBox = New-Object System.Windows.Forms.TextBox
$logBox.Multiline = $true
$logBox.ScrollBars = "Vertical"
$logBox.ReadOnly = $true
$logBox.Size = New-Object System.Drawing.Size(540, 150)
$logBox.Location = New-Object System.Drawing.Point(20, 200)
$form.Controls.Add($logBox)

function Write-Log($msg) {
    $logBox.AppendText("[$(Get-Date -Format 'HH:mm:ss')] $msg`r`n")
}

# Boutons
$buttons = @(
    @{ Text = "1. Analyse du système";      X = 20;  Y = 70;  Script = ".\Backup.ps1 -AnalyseOnly" },
    @{ Text = "2. Sauvegarde des données";  X = 300; Y = 70;  Script = ".\Backup.ps1" },
    @{ Text = "3. Télécharger une ISO";    X = 20;  Y = 110; Script = ".\Download-ISO.ps1" },
    @{ Text = "4. Créer une clé USB";       X = 300; Y = 110; Script = ".\Create-USB.ps1" },
    @{ Text = "5. Générer un rapport";      X = 20;  Y = 150; Script = ".\Report.ps1" }
)

foreach ($b in $buttons) {
    $btn = New-Object System.Windows.Forms.Button
    $btn.Text = $b.Text
    $btn.Size = New-Object System.Drawing.Size(250, 30)
    $btn.Location = New-Object System.Drawing.Point($b.X, $b.Y)
    $btn.Add_Click({
        Write-Log "Exécution : $($this.Text)"
        try {
            Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$($b.Script)`"" -Wait
            Write-Log "Terminé : $($this.Text)"
        } catch {
            Write-Log "Erreur lors de l'exécution."
        }
    })
    $form.Controls.Add($btn)
}

# Bouton Quitter
$btnQuit = New-Object System.Windows.Forms.Button
$btnQuit.Text = "Quitter"
$btnQuit.Size = New-Object System.Drawing.Size(100, 30)
$btnQuit.Location = New-Object System.Drawing.Point(460, 340)
$btnQuit.Add_Click({ $form.Close() })
$form.Controls.Add($btnQuit)

[void]$form.ShowDialog()
