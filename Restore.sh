#!/bin/bash

# ============================================
#  WinToLinux Migration - Restore Script
#  Author : Jean
#  Description : Restore user data exported from Windows
#  Supports : Ubuntu, Linux Mint, Zorin OS, Debian
# ============================================

GREEN="\e[32m"
RED="\e[31m"
YELLOW="\e[33m"
BLUE="\e[34m"
RESET="\e[0m"

echo -e "${BLUE}---------------------------------------------${RESET}"
echo -e "${BLUE}   WinToLinux Migration - Restore Tool       ${RESET}"
echo -e "${BLUE}---------------------------------------------${RESET}"

# --- Check arguments ---
if [ -z "$1" ]; then
    echo -e "${RED}[ERROR] Please provide the migration package ZIP file.${RESET}"
    echo -e "${YELLOW}Usage: bash Restore.sh Migration-Package.zip${RESET}"
    exit 1
fi

PACKAGE="$1"

# --- Check root privileges ---
if [ "$EUID" -ne 0 ]; then
    echo -e "${RED}[ERROR] Please run this script as root (sudo).${RESET}"
    exit 1
fi

# --- Check dependencies ---
if ! command -v unzip >/dev/null 2>&1; then
    echo -e "${YELLOW}[INFO] unzip not found. Installing...${RESET}"
    apt install -y unzip
fi

if ! command -v jq >/dev/null 2>&1; then
    echo -e "${YELLOW}[INFO] jq not found. Installing...${RESET}"
    apt install -y jq
fi

# --- Extract package ---
echo -e "${GREEN}[INFO] Extracting migration package...${RESET}"
unzip -o "$PACKAGE" -d Migration-Data

if [ $? -ne 0 ]; then
    echo -e "${RED}[ERROR] Failed to extract the package.${RESET}"
    exit 1
fi

# --- Read metadata ---
JSON="Migration-Data/migration.json"

if [ ! -f "$JSON" ]; then
    echo -e "${RED}[ERROR] migration.json not found in the package.${RESET}"
    exit 1
fi

USER=$(jq -r '.UserName' "$JSON")
FOLDERS=$(jq -r '.DataFolders[]' "$JSON")

echo -e "${GREEN}[INFO] Restoring data for user: $USER${RESET}"

# --- Ensure user exists ---
if id "$USER" >/dev/null 2>&1; then
    echo -e "${GREEN}[INFO] User already exists.${RESET}"
else
    echo -e "${YELLOW}[INFO] User does not exist. Creating user...${RESET}"
    useradd -m "$USER"
fi

# --- Restore folders ---
for folder in $FOLDERS; do
    SRC="Migration-Data/$folder"
    DEST="/home/$USER/$folder"

    echo -e "${GREEN}[INFO] Restoring $folder...${RESET}"

    mkdir -p "$DEST"
    cp -r "$SRC/"* "$DEST/" 2>/dev/null

    chown -R "$USER:$USER" "$DEST"
done

echo -e "${GREEN}[SUCCESS] Migration completed successfully.${RESET}"
exit 0

