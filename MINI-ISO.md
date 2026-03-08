# 🐧 Mini‑ISO WintoLinux
**ISO ultra‑légère basée sur Ubuntu, utilisant Cloud‑Init pour automatiser l’installation et lancer l’assistant WintoLinux.**

La Mini‑ISO WintoLinux permet d’installer Linux de manière simple, rapide et entièrement automatisée.  
Elle utilise une ISO Ubuntu standard + Cloud‑Init (mode NoCloud-Net) pour configurer automatiquement le système et lancer l’assistant WintoLinux au premier démarrage.

---

# 🚀 Objectifs de la Mini‑ISO

- ISO légère (300–600 MB)
- Installation rapide
- Configuration automatique (FR, clavier, langue)
- Installation automatique de l’assistant WintoLinux
- Lancement automatique au premier boot
- Aucun besoin de modifier l’ISO Ubuntu
- Maintenance ultra simple

---

# 🟦 1. Principe de fonctionnement

La Mini‑ISO WintoLinux repose sur :

1. **Une ISO Ubuntu standard** (non modifiée)
2. **Un paramètre GRUB** ajoutant Cloud‑Init NoCloud-Net
3. **Un fichier `user-data` hébergé sur SourceForge**
4. **Un fichier `meta-data` minimal**
5. **Cloud‑Init configure automatiquement le système**
6. **L’assistant WintoLinux se lance au premier démarrage**

---

# 🟩 2. Paramètre Cloud‑Init (NoCloud-Net)

Lors du boot de l’ISO, le noyau reçoit :
ds=nocloud-net;s=https://sourceforge.net/projects/wintolinux-migration/files/cloud-init/
Code


Cloud‑Init télécharge automatiquement :

- `user-data`
- `meta-data`

Puis applique la configuration.

---

# 🟧 3. Contenu du Cloud‑Init WintoLinux

Le fichier `user-data` configure automatiquement :

### ✔ Langue et clavier FR  
### ✔ Création utilisateur  
### ✔ Installation des paquets nécessaires  
### ✔ Clonage du projet WintoLinux  
### ✔ Lancement automatique de l’assistant  
### ✔ Configuration système (snapshots, services, etc.)

Le fichier `meta-data` peut être minimal :

instance-id: wintolinux
local-hostname: wintolinux
Code


---

# 🟨 4. Hébergement sur SourceForge

Les fichiers Cloud‑Init doivent être placés dans :

https://sourceforge.net/projects/wintolinux-migration/files/cloud-init/ (sourceforge.net in Bing)
Code


Contenu recommandé :

cloud-init/
│
├── user-data
└── meta-data
Code


---

# 🟪 5. Création de la Mini‑ISO

### Étape 1 — Télécharger l’ISO Ubuntu Netboot / Minimal
Exemple : Ubuntu 24.04 minimal ISO.

### Étape 2 — Modifier la ligne GRUB
Ajouter :

ds=nocloud-net;s=https://sourceforge.net/projects/wintolinux-migration/files/cloud-init/
Code


### Étape 3 — Générer l’ISO finale
Avec `xorriso` ou `mkisofs`.

### Étape 4 — Tester en VM
Vérifier que :

- Cloud‑Init télécharge bien la config
- Le système se configure automatiquement
- L’assistant WintoLinux se lance au premier boot

---

# 🟫 6. Avantages de la Mini‑ISO WintoLinux

- Aucun remastering complexe
- Maintenance ultra simple
- Compatible PXE
- Compatible ISO standard
- Compatible cloud-init universel
- Expérience utilisateur premium

---

# 🟩 7. Roadmap Mini‑ISO

- [ ] Version 1 : Ubuntu Mini‑ISO + Cloud‑Init
- [ ] Version 2 : Auto‑détection du matériel
- [ ] Version 3 : Assistant graphique amélioré
- [ ] Version 4 : Support PXE complet
- [ ] Version 5 : Version “Offline” (optionnelle)

---

# 📄 Licence

Ce document fait partie du projet **WinToLinux Migration** (MIT).

