#!/bin/bash

# ============================================
#  WinToLinux Migration - Install Packages
#  Author : Jean
#  Description : Install required packages for supported Linux distributions
#  Supports : Ubuntu, Linux Mint, Zorin OS, Debian
# ============================================

# --- Colors ---
GREEN="\e[32m"
RED="\e[31m"
YELLOW="\e[33m"
BLUE="\e[34m"
RESET="\e[0m"

echo -e "${BLUE}---------------------------------------------${RESET}"
echo -e "${BLUE}   WinToLinux Migration - Package Installer   ${RESET}"
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

# --- Installation function ---
install_packages() {
    echo -e "${GREEN}[INFO] Updating package lists...${RESET}"

    case "$DISTRO" in

        ubuntu|linuxmint|zorin)
            apt update -y
            apt install -y curl git wget software-properties-common lsb-release
            ;;

        debian)
            apt update -y
            apt install -y curl git wget lsb-release
            ;;

        *)
            echo -e "${RED}[ERROR] Unsupported distribution: $DISTRO${RESET}"
            echo -e "${YELLOW}[INFO] Supported distros: Ubuntu, Mint, Zorin, Debian${RESET}"
            exit 1
            ;;
    esac

    if [ $? -eq 0 ]; then
        echo -e "${GREEN}[SUCCESS] Packages installed successfully.${RESET}"
    else
        echo -e "${RED}[ERROR] Package installation failed.${RESET}"
        exit 1
    fi
}

# --- Run installation ---
install_packages

echo -e "${GREEN}[DONE] Installation process completed.${RESET}"
exit 0
