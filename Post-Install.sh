#!/bin/bash

# ============================================
#  WinToLinux Migration - Post Install Script
#  Author : Jean
#  Description : Apply final configurations after migration
#  Supports : Ubuntu, Linux Mint, Zorin OS, Debian
# ============================================

GREEN="\e[32m"
RED="\e[31m"
YELLOW="\e[33m"
BLUE="\e[34m"
RESET="\e[0m"

echo -e "${BLUE}---------------------------------------------${RESET}"
echo -e "${BLUE}   WinToLinux Migration - Post Install       ${RESET}"
echo -e "${BLUE}---------------------------------------------${RESET}"

# --- Check root privileges ---
if [ "$EUID" -ne 0 ]; then
    echo -e "${RED}[ERROR] Please run this script as root (sudo).${RESET}"
    exit 1
fi

# --- Detect distribution ---
if [ -f /etc/os-release ]; then
    source /etc/os-release
    DISTRO=$ID
else
    echo -e "${RED}[ERROR] Unable to detect your Linux distribution.${RESET}"
    exit 1
fi

echo -e "${GREEN}[INFO] Detected distribution: $DISTRO${RESET}"

# --- Function: Install recommended software ---
install_recommended_apps() {
    echo -e "${GREEN}[INFO] Installing recommended applications...${RESET}"

    case "$DISTRO" in

        ubuntu|linuxmint|zorin|debian)
            apt update -y
            apt install -y \
                gnome-tweaks \
                vlc \
                gparted \
                htop \
                neofetch \
                curl \
                git \
                wget
            ;;

        *)
            echo -e "${YELLOW}[WARNING] No recommended apps list for this distribution.${RESET}"
            ;;
    esac
}

# --- Function: Apply system tweaks ---
apply_system_tweaks() {
    echo -e "${GREEN}[INFO] Applying system tweaks...${RESET}"

    # Enable firewall
    if command -v ufw >/dev/null 2>&1; then
        ufw enable
    fi

    # Improve performance
    echo "vm.swappiness=10" >> /etc/sysctl.conf
    sysctl -p >/dev/null 2>&1
}

# --- Function: Clean system ---
clean_system() {
    echo -e "${GREEN}[INFO] Cleaning system...${RESET}"
    apt autoremove -y
    apt autoclean -y
}

# --- Run tasks ---
install_recommended_apps

