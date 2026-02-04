#!/bin/bash

echo "==============================================="
echo "   Script Post-Installation Linux"
echo "==============================================="
echo ""

# Vérification sudo
if [ "$EUID" -ne 0 ]; then
    echo "Veuillez exécuter ce script avec sudo."
    exit 1
fi

echo ""
echo "Mise à jour du système..."
apt update -y
apt upgrade -y

echo ""
echo "Activation de Flatpak..."
apt install -y flatpak
apt install -y gnome-software-plugin-flatpak 2>/dev/null
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

echo ""
echo "Installation des codecs multimédia..."
apt install -y ubuntu-restricted-extras 2>/dev/null
apt install -y libavcodec-extra

echo ""
echo "Configuration du pare-feu UFW..."
apt install -y ufw
ufw allow OpenSSH
ufw enable

echo ""
echo "Nettoyage du système..."
apt autoremove -y
apt autoclean -y

echo ""
echo "Optimisations diverses..."
# Amélioration de la réactivité du système
sysctl vm.swappiness=10

# Activation TRIM pour SSD
systemctl enable fstrim.timer

echo ""
echo "Installation de quelques outils utiles..."
apt install -y htop neofetch curl git gparted

echo ""
echo "Configuration terminée."
echo "Votre système Linux est maintenant optimisé et prêt à l'emploi."
echo ""
