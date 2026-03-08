# 📘 Guide d’installation — WinToLinux Migration

Ce document explique comment installer, lancer et utiliser l’assistant **WinToLinux Migration**, ainsi que les différentes méthodes disponibles (local, cloud-init, Mini‑ISO).

---

# 🟦 1. Prérequis

### Matériel
- PC Windows ou Linux
- Connexion Internet stable
- 4 Go de RAM minimum
- 20 Go d’espace disque recommandé

### Logiciels nécessaires
- Git (optionnel)
- Bash (Linux ou WSL)
- Outil de création USB (Rufus, Ventoy, BalenaEtcher)

---

# 🟩 2. Installation locale (méthode standard)

### 2.1 Cloner le dépôt
```bash
git clone https://github.com/webmasterdu63-creator/WinToLinux-Migration
cd WinToLinux-Migration
2.2 Lancer l’assistant
bash

bash scripts/wintolinux.sh

L’assistant vous guidera pour :

    choisir une distribution Linux

    télécharger l’ISO officielle

    vérifier l’intégrité

    préparer la clé USB

    lancer l’installation

🟧 3. Installation via Mini‑ISO WintoLinux (recommandé)

La Mini‑ISO Ubuntu WintoLinux (en développement) permet une installation :

    automatisée

    préconfigurée en FR

    avec lancement automatique de l’assistant

    sans manipulation manuelle

3.1 Télécharger la Mini‑ISO

(à venir)
3.2 Créer une clé USB bootable

Avec Ventoy, Rufus ou BalenaEtcher.
3.3 Démarrer sur la clé USB

L’assistant WintoLinux se lance automatiquement au premier démarrage.
☁️ 4. Installation automatisée via Cloud‑Init (NoCloud-Net)

WintoLinux supporte le mode cloud-init, permettant une installation automatisée via une ISO standard Ubuntu/Fedora/Debian.
4.1 Paramètre à ajouter au boot

Dans GRUB, ajouter :
Code

ds=nocloud-net;s=https://sourceforge.net/projects/wintolinux-migration/files/cloud-init/

4.2 Fonctionnement

Cloud‑init appliquera automatiquement :

    langue FR

    clavier FR

    installation de l’assistant

    configuration système

    lancement automatique

🟦 5. Liste des distributions supportées

WintoLinux permet d’installer automatiquement 8 distributions populaires :

    Ubuntu 24.04 LTS

    Kubuntu (KDE)

    Xubuntu (XFCE)

    Zorin OS 18

    Fedora Workstation

    openSUSE Tumbleweed KDE

    Debian 12 XFCE

    Bazzite (Gaming)

Chaque distribution est téléchargée depuis sa source officielle.
🛠 6. Dépannage
L’assistant ne se lance pas

Vérifiez que vous utilisez :
bash

bash scripts/wintolinux.sh

Problème de permission
bash

chmod +x scripts/*.sh

ISO non téléchargée

Vérifiez votre connexion Internet.
🤝 Contribution

Les contributions sont les bienvenues.
Ouvrez une issue ou une pull request sur GitHub.
📄 Licence

Ce projet est distribué sous licence MIT.
