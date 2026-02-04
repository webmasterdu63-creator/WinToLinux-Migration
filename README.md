# WinToLinux-Migration
Assistant de migration Windows → Linux (sauvegarde, ISO, clé USB, restauration)
# WinToLinux-Migration  
Assistant complet de migration Windows → Linux  
(sauvegarde, ISO, clé USB bootable, restauration, post-installation)

---

## 🎯 Objectif du projet

WinToLinux-Migration est un assistant automatisé permettant de migrer facilement un système Windows vers une distribution Linux (Ubuntu, Mint, Debian).  
Il guide l’utilisateur à travers toutes les étapes critiques :

- Analyse du système Windows  
- Sauvegarde automatique des données  
- Téléchargement d’une ISO Linux  
- Création d’une clé USB bootable  
- Génération d’un rapport HTML  
- Scripts Linux de restauration et post-installation  

Ce projet vise à simplifier la transition pour les utilisateurs, tout en offrant un outil professionnel pour les techniciens.

---

## 🗂️ Structure du projet

WinToLinux-Migration/
│
├── Windows/
│   ├── Migration-Assistant.ps1      # Menu principal Windows
│   ├── Backup.ps1                   # Sauvegarde automatique
│   ├── Download-ISO.ps1             # Téléchargement ISO Linux
│   ├── Create-USB.ps1               # Création clé USB bootable
│   └── Report.ps1                   # Rapport HTML
│
├── Linux/
│   ├── Restore.sh                    # Restauration des données
│   ├── Install-Packages.sh           # Installation logiciels essentiels
│   └── Post-Install.sh               # Optimisations et configuration
│
└── docs/
├── migration-guide.md            # Guide complet (à venir)
└── screenshots/                 # Captures d’écran

---

## 🪟 Partie Windows

### ✔️ 1. Migration-Assistant.ps1  
Menu principal permettant de lancer toutes les étapes.

### ✔️ 2. Backup.ps1  
Sauvegarde automatique des dossiers :

- Documents  
- Images  
- Vidéos  
- Bureau  
- Téléchargements  
- Favoris  

Sauvegarde dans :  
`C:\WinToLinux-Backup\`

### ✔️ 3. Download-ISO.ps1  
Téléchargement automatique de :

- Ubuntu  
- Linux Mint  
- Debian  

Stockage dans :  
`C:\WinToLinux-ISO\`

### ✔️ 4. Create-USB.ps1  
Création d’une clé USB bootable via Rufus (mode automatique).

### ✔️ 5. Report.ps1  
Génération d’un rapport HTML complet.

---

## 🐧 Partie Linux

### ✔️ 1. Restore.sh  
Restaure automatiquement les données sauvegardées sous Windows.

### ✔️ 2. Install-Packages.sh  
Installe les logiciels essentiels :

- Chromium  
- VLC  
- p7zip  
- VSCode  
- Steam  
- Discord  
- OBS Studio  

### ✔️ 3. Post-Install.sh  
Optimise et configure le système :

- Flatpak + Flathub  
- Codecs multimédia  
- Pare-feu UFW  
- Nettoyage système  
- TRIM SSD  
- Outils utiles (htop, neofetch, git…)

---

## 🚀 Comment utiliser l’assistant

### 1️⃣ Sous Windows  
Lancer :


Puis suivre les étapes du menu.

### 2️⃣ Installer Linux  
Bootez sur la clé USB créée.

### 3️⃣ Sous Linux  
Monter la partition Windows contenant la sauvegarde, puis exécuter :

sudo bash Restore.sh
sudo bash Install-Packages.sh
sudo bash Post-Install.sh

---

## 📌 Compatibilité

- Windows 10 / 11  
- Ubuntu 22.04+  
- Linux Mint 21+  
- Debian 12+  

---

## 🧑‍💻 Auteur

Projet développé par **Jean-Jacques Boucheret**, Administrateur Systèmes & Réseaux.  
Objectif : fournir un outil professionnel de migration Windows → Linux, simple, fiable et automatisé.

---

## 📄 Licence

Projet open-source — libre d’utilisation et d’adaptation.
