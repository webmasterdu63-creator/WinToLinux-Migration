#!/bin/bash

echo "==============================================="
echo "   Script de restauration Windows → Linux"
echo "==============================================="
echo ""

BACKUP_DIR="/mnt/WinToLinux-Backup"
TARGET_HOME="$HOME"

# Vérification du dossier de sauvegarde
if [ ! -d "$BACKUP_DIR" ]; then
    echo "Erreur : le dossier de sauvegarde n'a pas été trouvé."
    echo "Veuillez monter votre partition Windows contenant : C:\\WinToLinux-Backup"
    exit 1
fi

echo "Dossier de sauvegarde détecté : $BACKUP_DIR"
echo ""

# Liste des dossiers à restaurer
FOLDERS=("Documents" "Pictures" "Videos" "Desktop" "Downloads" "Favorites")

echo "Restauration des données..."
echo ""

for folder in "${FOLDERS[@]}"; do
    SRC="$BACKUP_DIR/$folder"
    DEST="$TARGET_HOME/$folder"

    if [ -d "$SRC" ]; then
        mkdir -p "$DEST"
        cp -r "$SRC/"* "$DEST/"
        echo "✔ $folder restauré"
    else
        echo "✖ $folder non trouvé dans la sauvegarde"
    fi
done

echo ""
echo "Restauration terminée."
echo "Vos fichiers sont maintenant disponibles dans votre dossier personnel."
echo ""
