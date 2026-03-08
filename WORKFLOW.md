# 🔧 Workflow de développement — WinToLinux Migration

Ce document décrit le workflow officiel du projet **WinToLinux Migration**, afin de garantir une structure propre, cohérente et facile à maintenir.  
Il s’adresse aux contributeurs, mainteneurs et développeurs souhaitant participer au projet.

---

# 🟦 1. Structure générale du projet

Le projet est organisé en plusieurs dossiers :

WinToLinux-Migration/
│
├── cloud-init/      → fichiers user-data et meta-data
├── scripts/         → scripts Bash principaux
├── distros/         → fichiers JSON des distributions supportées
├── assets/          → images, logos, captures
├── docs/            → documentation officielle
└── README.md        → présentation générale
Code


Chaque dossier a un rôle clair et doit rester simple à maintenir.

---

# 🟩 2. Branches Git

Le projet utilise plusieurs branches :

### ✔ `main`
- branche stable  
- contient les versions validées  
- utilisée par les utilisateurs finaux  

### ✔ `docs`
- documentation officielle  
- fichiers Markdown  
- changelogs, guides, workflows  

### ✔ `dev`
- développement actif  
- scripts, tests, nouvelles fonctionnalités  

### ✔ `iso` (optionnel)
- travail sur la Mini‑ISO Ubuntu WintoLinux  
- modifications GRUB, tests cloud-init  

---

# 🟧 3. Workflow de contribution

### Étape 1 — Créer une branche
Depuis `dev` :

git checkout dev
git checkout -b feature-nom
Code


### Étape 2 — Développer / modifier
- scripts  
- JSON des distros  
- documentation  
- cloud-init  

### Étape 3 — Commit clair

git commit -m "Add: support Zorin OS 18 installer"
Code


### Étape 4 — Push

git push origin feature-nom
Code


### Étape 5 — Pull Request
Créer une PR vers `dev`.

### Étape 6 — Merge vers `main`
Une fois testé et validé.

---

# 🟨 4. Workflow Cloud‑Init

Le projet utilise **cloud-init** pour automatiser la configuration du système.

### Pipeline :

1. L’utilisateur démarre la Mini‑ISO Ubuntu  
2. GRUB passe le paramètre :  

ds=nocloud-net;s=https://sourceforge.net/projects/wintolinux-migration/files/cloud-init/
Code

3. Cloud‑init télécharge :
- `user-data`
- `meta-data`
4. Le système se configure automatiquement :
- langue FR  
- clavier FR  
- installation des paquets  
- clonage du projet  
- lancement de l’assistant  
5. L’utilisateur choisit une distribution  
6. L’assistant télécharge l’ISO officielle  
7. Installation automatisée de la distro choisie  

---

# 🟪 5. Workflow Mini‑ISO WintoLinux

### Objectif :
Créer une ISO Ubuntu minimale qui lance automatiquement WintoLinux.

### Étapes :
1. Télécharger l’ISO Ubuntu Minimal  
2. Modifier GRUB pour ajouter NoCloud-Net  
3. Générer l’ISO finale  
4. Tester en VM  
5. Publier sur SourceForge  

---

# 🟫 6. Workflow des distributions supportées

Chaque distribution est décrite dans un fichier JSON :

Exemple :

```json
{
"name": "Zorin OS 18",
"desktop": "GNOME",
"url": "https://zorin.com/os/download/",
"recommended": true
}

Pipeline :

    L’utilisateur choisit une distro

    Le script lit le JSON

    Téléchargement de l’ISO

    Vérification du hash

    Préparation de l’installation

    Lancement automatique

🟩 7. Tests
Tests recommandés :

    VM VirtualBox / QEMU

    Test cloud-init

    Test Mini‑ISO

    Test installation de chaque distro

    Test du script principal

🟦 8. Publication
Sur GitHub :

    merge vers main

    tag version

    release notes

Sur SourceForge :

    Mini‑ISO

    fichiers cloud-init

    scripts optionnels

📄 Licence

Ce workflow fait partie du projet WinToLinux Migration (MIT).
