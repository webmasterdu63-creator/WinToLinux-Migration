#!/bin/bash

echo "==============================================="
echo "   Installation des logiciels essentiels Linux"
echo "==============================================="
echo ""

# Vérification sudo
if [ "$EUID" -ne 0 ]; then
    echo "Veuillez exécuter ce script avec sudo."
    exit 1
fi

# Mise à jour des dépôts
echo ""
echo "Mise à jour du système..."
apt update -y
apt upgrade -y

echo ""
echo "Installation des logiciels équivalents Windows → Linux"
echo ""

# Liste des logiciels à installer
PACKAGES=(
    "chromium-browser"   # Alternative à Chrome
    "vlc"                # Alternative VLC
    "p7zip-full"         # Alternative 7zip
    "code"               # VSCode (si repo activé)
    "steam-installer"    # Steam
    "discord"            # Discord
    "obs-studio"         # OBS
)

# Ajout des dépôts nécessaires
echo ""
echo "Activation des dépôts nécessaires..."
apt install -y software-properties-common apt-transport-https wget gpg

# VSCode
if ! command -v code &> /dev/null; then
    echo "Ajout du dépôt VSCode..."
    wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > /usr/share/keyrings/packages.microsoft.gpg
    echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list
fi

# Discord
if ! command -v discord &> /dev/null; then
    echo "Téléchargement de Discord..."
    wget -O /tmp/discord.deb "https://discord.com/api/download?platform=linux&format=deb"
    apt install -y /tmp/discord.deb
fi

# Mise à jour après ajout des dépôts
apt update -y

# Installation des paquets
for pkg in "${PACKAGES[@]}"; do
    echo ""
    echo "Installation de : $pkg"
    apt install -y "$pkg"
done

echo ""
echo "Installation terminée."
echo "Vos logiciels essentiels sont maintenant installés."
echo ""
