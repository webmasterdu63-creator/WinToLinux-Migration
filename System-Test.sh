#!/bin/bash

# ============================================
#  WinToLinux Migration - System Test
#  Author : Jean
#  Description : Check system compatibility before migration
#  Supports : Ubuntu, Linux Mint, Zorin OS, Debian
# ============================================

GREEN="\e[32m"
RED="\e[31m"
YELLOW="\e[33m"
BLUE="\e[34m"
RESET="\e[0m"

echo -e "${BLUE}---------------------------------------------${RESET}"
echo -e "${BLUE}   WinToLinux Migration - System Test        ${RESET}"
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
    DISTRO_NAME=$NAME
else
    echo -e "${RED}[ERROR] Unable to detect your Linux distribution.${RESET}"
    exit 1
fi

echo -e "${GREEN}[INFO] Distribution detected: $DISTRO_NAME ($DISTRO)${RESET}"

# --- Test: Internet connectivity ---
echo -e "${GREEN}[TEST] Checking internet connection...${RESET}"
if ping -c 1 8.8.8.8 >/dev/null 2>&1; then
    echo -e "${GREEN}[OK] Internet connection is working.${RESET}"
else
    echo -e "${RED}[FAIL] No internet connection detected.${RESET}"
fi

# --- Test: Disk space ---
echo -e "${GREEN}[TEST] Checking disk space...${RESET}"
DISK=$(df -h / | awk 'NR==2 {print $4}')
echo -e "${GREEN}[OK] Available disk space: $DISK${RESET}"

# --- Test: RAM ---
echo -e "${GREEN}[TEST] Checking RAM...${RESET}"
RAM=$(free -h | awk '/Mem:/ {print $2}')
echo -e "${GREEN}[OK] Total RAM: $RAM${RESET}"

# --- Test: Required commands ---
check_command() {
    if command -v "$1" >/dev/null 2>&1; then
        echo -e "${GREEN}[OK] $1 is installed.${RESET}"
    else
        echo -e "${RED}[MISSING] $1 is NOT installed.${RESET}"
    fi
}

echo -e "${GREEN}[TEST] Checking required tools...${RESET}"
check_command curl
check_command git
check_command wget
check_command unzip
check_command jq

# --- Test: Package manager ---
echo -e "${GREEN}[TEST] Checking package manager...${RESET}"
if command -v apt >/dev/null 2>&1; then
    echo -e "${GREEN}[OK] APT package manager detected.${RESET}"
else
    echo -e "${RED}[FAIL] APT not found. Unsupported distribution.${RESET}"
fi

echo -e "${GREEN}[SUCCESS] System test completed.${RESET}"
exit 0
