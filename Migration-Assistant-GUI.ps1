Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

#========================
# Fenêtre principale
#========================
$form = New-Object System.Windows.Forms.Form
$form.Text = "Assistant de Migration Windows → Linux"
$form.Size = New-Object System.Drawing.Size(900, 550)
$form.StartPosition = "CenterScreen"

# Logo en haut
$logo = New-Object System.Windows.Forms.PictureBox
$logo.ImageLocation = "Windows\Assets\WintoLinux.png"
$logo.SizeMode = "Zoom"
$logo.Size = New-Object System.Drawing.Size(180, 180)
$logo.Location = New-Object System.Drawing.Point(360, 5)
$form.Controls.Add($logo)

#========================
# Barre de progression
#========================
$progressBar = New-Object System.Windows.Forms.ProgressBar
$progressBar.Location = New-Object System.Drawing.Point(10, 500)
$progressBar.Size = New-Object System.Drawing.Size(870, 20)
$progressBar.Minimum = 0
$progressBar.Maximum = 100
$progressBar.Value = 0
$form.Controls.Add($progressBar)

#========================
# Zone de log
#========================
$logBox = New-Object System.Windows.Forms.RichTextBox
$logBox.ReadOnly = $true
$logBox.Size = New-Object System.Drawing.Size(550, 200)
$logBox.Location = New-Object System.Drawing.Point(320, 280)
$form.Controls.Add($logBox)

function Write-Log($msg, $color="Black") {
    $logBox.SelectionColor = $color
    $logBox.AppendText("[$(Get-Date -Format 'HH:mm:ss')] $msg`r`n")
}

#========================
# Panneau latéral (menu)
#========================
$panelMenu = New-Object System.Windows.Forms.Panel
$panelMenu.Size = New-Object System.Drawing.Size(280, 460)
$panelMenu.Location = New-Object System.Drawing.Point(10, 20)
$panelMenu.BorderStyle = "FixedSingle"
$form.Controls.Add($panelMenu)

#========================
# Panneau de contenu
#========================
$panelContent = New-Object System.Windows.Forms.Panel
$panelContent.Size = New-Object System.Drawing.Size(580, 250)
$panelContent.Location = New-Object System.Drawing.Point(300, 200)
$panelContent.BorderStyle = "FixedSingle"
$form.Controls.Add($panelContent)

#========================
# Fonctions utilitaires
#========================
function Reset-Progress {
    $progressBar.Value = 0
}

function Run-Task($name, $scriptBlock) {
    Write-Log "Début : $name" "Blue"
    Reset-Progress
    try {
        & $scriptBlock
        $progressBar.Value = 100
        Write-Log "Terminé : $name" "Green"
    } catch {
        Write-Log "Erreur : $($_.Exception.Message)" "Red"
    }
}

#========================
# Contenu : Analyse système
#========================
function Show-AnalyseSysteme {
    $panelContent.Controls.Clear()

    $label = New-Object System.Windows.Forms.Label
    $label.Text = "Analyse automatique du système Windows"
    $label.AutoSize = $true
    $label.Location = New-Object System.Drawing.Point(10, 10)
    $panelContent.Controls.Add($label)

    $btnTest = New-Object System.Windows.Forms.Button
    $btnTest.Text = "Lancer le test de compatibilité"
    $btnTest.Size = New-Object System.Drawing.Size(250, 30)
    $btnTest.Location = New-Object System.Drawing.Point(10, 50)
    $btnTest.Add_Click({
        Run-Task "Test système" {
            $progressBar.Value = 10
            $os = Get-CimInstance Win32_OperatingSystem
            $cpu = Get-CimInstance Win32_Processor
            $ram = [math]::Round($os.TotalVisibleMemorySize / 1MB, 1)
            $disk = Get-CimInstance Win32_LogicalDisk -Filter "DeviceID='C:'"

            $progressBar.Value = 40
            Write-Log "Windows : $($os.Caption) ($($os.OSArchitecture))"
            Write-Log "Version : $($os.Version)"
            Write-Log "CPU : $($cpu.Name)"
            Write-Log "RAM : $ram Go"
            Write-Log "Disque C: Espace libre : {0:N2} Go" -f ($disk.FreeSpace/1GB)

            $progressBar.Value = 70
            # Exemple de règles simples de compatibilité
            $compatible = $true
            if ($ram -lt 4) {
                Write-Log "Attention : moins de 4 Go de RAM." "Red"
                $compatible = $false
            }
            if (($disk.FreeSpace/1GB) -lt 20) {
                Write-Log "Attention : moins de 20 Go libres sur C:." "Red"
                $compatible = $false
            }

            $progressBar.Value = 90
            if ($compatible) {
                Write-Log "Compatibilité Linux : BONNE" "Green"
            } else {
                Write-Log "Compatibilité Linux : À VÉRIFIER" "Red"
            }
        }
    })
    $panelContent.Controls.Add($btnTest)
}

#========================
# Contenu : Mode avancé
#========================
function Show-ModeAvance {
    $panelContent.Controls.Clear()

    $label = New-Object System.Windows.Forms.Label
    $label.Text = "Mode avancé - options techniques"
    $label.AutoSize = $true
    $label.Location = New-Object System.Drawing.Point(10, 10)
    $panelContent.Controls.Add($label)

    # Exemple : case à cocher logs détaillés
    $chkVerbose = New-Object System.Windows.Forms.CheckBox
    $chkVerbose.Text = "Activer les logs détaillés"
    $chkVerbose.Location = New-Object System.Drawing.Point(10, 40)
    $panelContent.Controls.Add($chkVerbose)

    $btnSysInfo = New-Object System.Windows.Forms.Button
    $btnSysInfo.Text = "Afficher les infos système complètes"
    $btnSysInfo.Size = New-Object System.Drawing.Size(260, 30)
    $btnSysInfo.Location = New-Object System.Drawing.Point(10, 80)
    $btnSysInfo.Add_Click({
        Run-Task "Infos système avancées" {
            $progressBar.Value = 20
            $bios = Get-CimInstance Win32_BIOS
            $cs = Get-CimInstance Win32_ComputerSystem
            $progressBar.Value = 50
            Write-Log "Fabricant : $($cs.Manufacturer)"
            Write-Log "Modèle : $($cs.Model)"
            Write-Log "BIOS : $($bios.SMBIOSBIOSVersion)"
            Write-Log "Numéro de série : $($bios.SerialNumber)"
            $progressBar.Value = 100
        }
    })
    $panelContent.Controls.Add($btnSysInfo)
}

#========================
# Menu latéral : boutons
#========================
function Add-MenuButton($text, $y, $onClick) {
    $btn = New-Object System.Windows.Forms.Button
    $btn.Text = $text
    $btn.Size = New-Object System.Drawing.Size(260, 35)
    $btn.Location = New-Object System.Drawing.Point(10, $y)
    $btn.Add_Click($onClick)
    $panelMenu.Controls.Add($btn)
}

Add-MenuButton "Analyse système" 10 { Show-AnalyseSysteme }
Add-MenuButton "Sauvegarde"      55 { Run-Task "Sauvegarde" { .\Backup.ps1 } }
Add-MenuButton "ISO Linux"       100 { Run-Task "Téléchargement ISO" { .\Download-ISO.ps1 } }
Add-MenuButton "Clé USB"         145 { Run-Task "Création clé USB" { .\Create-USB.ps1 } }
Add-MenuButton "Rapport"         190  { Run-Task "Rapport" { .\Report.ps1 } }
Add-MenuButton "Mode avancé"     235 { Show-ModeAvance }

#========================
# Bouton Quitter
#========================
$btnQuit = New-Object System.Windows.Forms.Button
$btnQuit.Text = "Quitter"
$btnQuit.Size = New-Object System.Drawing.Size(100, 30)
$btnQuit.Location = New-Object System.Drawing.Point(780, 470)
$btnQuit.Add_Click({ $form.Close() })
$form.Controls.Add($btnQuit)

# Afficher la fenêtre
Show-AnalyseSysteme
[void]$form.ShowDialog()

