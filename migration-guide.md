# Guide complet de migration Windows → Linux  
WinToLinux-Migration — Documentation officielle

---

## 🧭 Introduction

Ce guide accompagne l’utilisateur dans toutes les étapes de la migration d’un système Windows vers Linux, en utilisant l’assistant automatisé **WinToLinux-Migration**.

Il couvre :

- la préparation sous Windows  
- la sauvegarde des données  
- le téléchargement d’une ISO Linux  
- la création d’une clé USB bootable  
- l’installation de Linux  
- la restauration des données  
- la configuration post-installation  

Ce guide est conçu pour être simple, clair et accessible, même pour un utilisateur non technique.

---

# 1️⃣ Préparation sous Windows

## ✔️ 1.1 Télécharger le projet

Assurez-vous que les scripts Windows se trouvent dans :

## ✔️ 1.2 Lancer l’assistant
Ouvrez PowerShell **en tant qu’administrateur**, puis exécutez :


Vous verrez apparaître le menu principal.

---

# 2️⃣ Analyse et sauvegarde

## ✔️ 2.1 Analyse du système
Dans le menu, choisissez :

L’assistant affiche :

- version de Windows  
- CPU  
- RAM  
- espace disque disponible  

## ✔️ 2.2 Sauvegarde des données
Choisissez :

Les dossiers suivants seront sauvegardés automatiquement :

- Documents  
- Images  
- Vidéos  
- Bureau  
- Téléchargements  
- Favoris  

La sauvegarde est stockée dans :
C:\WinToLinux-Backup\
Télécharger une ISO Linux


Vous pouvez sélectionner :

- Ubuntu  
- Linux Mint  
- Debian  

L’ISO sera téléchargée dans :
C:\WinToLinux-ISO\

---

# 4️⃣ Création de la clé USB bootable

Choisissez :

Créer une clé USB bootable


L’assistant :

- détecte automatiquement les clés USB  
- télécharge Rufus si nécessaire  
- crée la clé bootable en mode automatique  

⚠️ **Attention : la clé USB sera entièrement effacée.**

---

# 5️⃣ Génération du rapport HTML

Choisissez :
Générer un rapport


Le rapport contient :

- informations système  
- dossiers sauvegardés  
- ISO téléchargée  
- instructions de démarrage USB  

Il est enregistré dans :
C:\WinToLinux-Backup\report.html


---

# 6️⃣ Installation de Linux

Redémarrez votre ordinateur et bootez sur la clé USB :

- F12  
- F9  
- ESC  
- ou selon votre modèle

Installez Linux normalement.

---

# 7️⃣ Restauration sous Linux

Une fois Linux installé :

## ✔️ 7.1 Monter la partition Windows
Exemple :
sudo mkdir /mnt/win
sudo mount /dev/sdXN /mnt/win


Le dossier de sauvegarde doit être visible dans :
/mnt/win/WinToLinux-Backup


## ✔️ 7.2 Restaurer les données

Exécutez :
sudo bash Restore.sh


Les dossiers seront restaurés dans votre `/home`.

---

# 8️⃣ Installation des logiciels essentiels

Exécutez :


Ce script installe :

- Chromium  
- VLC  
- p7zip  
- VSCode  
- Steam  
- Discord  
- OBS Studio  

---

# 9️⃣ Configuration post-installation

Exécutez :
sudo bash Post-Install.sh

Ce script :

- active Flatpak  
- installe les codecs  
- configure UFW  
- optimise le système  
- installe des outils utiles  
- active TRIM pour SSD  

---

# 🔚 Conclusion

Votre migration Windows → Linux est maintenant terminée.  
Grâce à WinToLinux-Migration, vous disposez :

- d’une sauvegarde propre  
- d’une restauration automatique  
- d’un système Linux optimisé  
- d’un environnement logiciel complet  

Ce guide peut être enrichi avec des captures d’écran dans :
docs/screenshots/

N’hésitez pas à contribuer ou améliorer le projet.
















Téléchargez ou clonez le projet :

