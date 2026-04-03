Add-Type -AssemblyName System.Windows.Forms

function Select-LinuxISO {
    $dialog = New-Object System.Windows.Forms.OpenFileDialog
    $dialog.Filter = "Fichiers ISO (*.iso)|*.iso"
    $dialog.Title  = "Sélectionner une ISO Linux"

    if ($dialog.ShowDialog() -eq "OK") {
        return $dialog.FileName
    }

    return $null
}

function Get-ISOHash {
    param([string]$ISOPath)

    if (!(Test-Path $ISOPath)) {
        return "ISO introuvable."
    }

    $hash = Get-FileHash -Path $ISOPath -Algorithm SHA256
    return $hash.Hash
}

# =========================
#   LISTE DES DISTROS
# =========================
$LinuxDistros = @{
    # --- Debian / Ubuntu / Mint ---
    "Ubuntu 24.04 LTS" = "https://releases.ubuntu.com/24.04/ubuntu-24.04-desktop-amd64.iso"
    "Linux Mint 22"    = "https://mirrors.edge.kernel.org/linuxmint/stable/22/linuxmint-22-cinnamon-64bit.iso"
    "LMDE 6 Faye"      = "https://mirrors.edge.kernel.org/linuxmint/debian/lmde-6-cinnamon-64bit.iso"
    "LMDE 7 Gigi"      = "https://mirrors.edge.kernel.org/linuxmint/debian/lmde-7-cinnamon-64bit.iso"
    "Debian 12.5"      = "https://cdimage.debian.org/debian-cd/current/amd64/iso-dvd/debian-12.5.0-amd64-DVD-1.iso"

    # --- Fedora / RHEL-based ---
    "Fedora Workstation 40" = "https://download.fedoraproject.org/pub/fedora/linux/releases/40/Workstation/x86_64/iso/Fedora-Workstation-Live-x86_64-40-1.14.iso"
    "Bazzite (Fedora-based)" = "https://github.com/ublue-os/bazzite/releases/latest/download/bazzite.iso"
    "Nobara KDE" = "https://nobaraproject.org/downloads/Nobara-40-KDE.iso"

    # --- Pop!_OS ---
    "Pop!_OS 22.04" = "https://pop-iso.sfo2.cdn.digitaloceanspaces.com/22.04/amd64/intel/pop-os_22.04_amd64_intel_33.iso"

    # --- Arch-based ---
    "Arch Linux" = "https://geo.mirror.pkgbuild.com/iso/latest/archlinux-x86_64.iso"
    "Manjaro KDE" = "https://download.manjaro.org/kde/23.1.0/manjaro-kde-23.1.0-240101-linux66.iso"
    "Garuda KDE Dr460nized" = "https://iso.builds.garudalinux.org/iso/latest/garuda-dr460nized-linux-zen.iso"

    # --- Sécurité / Pentest ---
    "Kali Linux 2024.4" = "https://cdimage.kali.org/kali-2024.4/kali-linux-2024.4-installer-amd64.iso"

    # --- KDE Plasma ---
    "KDE Neon" = "https://files.kde.org/neon/images/user/current/neon-user-current.iso"

    # --- openSUSE ---
    "openSUSE Aeon" = "https://download.opensuse.org/tumbleweed/iso/openSUSE-Aeon.x86_64.iso"
}


# =========================
#   EXPORTS
# =========================
Export-ModuleMember -Function Select-LinuxISO, Get-ISOHash
Export-ModuleMember -Variable LinuxDistros
