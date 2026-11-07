# 🔍 Linux Audit Machine

![Bash](https://img.shields.io/badge/Bash-Scripting-green?style=for-the-badge&logo=gnu-bash)
![Linux](https://img.shields.io/badge/Linux-Ubuntu-orange?style=for-the-badge&logo=linux)
![GitHub](https://img.shields.io/badge/GitHub-Versioning-black?style=for-the-badge&logo=github)
![Status](https://img.shields.io/badge/Status-Completed-brightgreen?style=for-the-badge)

## 📖 Présentation

Ce projet a été réalisé dans le cadre du cours **SYSTEM UNIX** à **3iL Ingénieurs**.

L'objectif était de développer un outil d'audit système en **Shell Bash** capable d'effectuer différentes vérifications sur une machine Linux et de générer automatiquement des rapports exploitables.

Le projet met en pratique plusieurs notions fondamentales :

- Administration système Linux
- Scripts Shell Bash
- Gestion des processus
- Surveillance des ressources
- Contrôles réseau
- Contrôles de sécurité
- Journalisation
- Automatisation de tâches
- Utilisation de Git et GitHub

---

## ✨ Fonctionnalités

### 🖥️ Audit système

- Informations sur la machine
- Vérification de l'espace disque
- Surveillance de l'utilisation mémoire
- Analyse des processus actifs
- Informations sur les utilisateurs

### 🌐 Audit réseau

- Vérification des adresses IP
- Contrôle des interfaces réseau
- Vérification de la connectivité
- Analyse des ports ouverts

### 🔒 Audit sécurité

- Vérification de certaines permissions sensibles
- Contrôles de sécurité de base
- Détection d'anomalies simples

### 📝 Journalisation

Chaque exécution est enregistrée automatiquement dans un journal :

```text
logs/audit.log
```

avec :

- date
- heure
- type d'exécution

### 📄 Génération de rapports

Chaque audit produit un rapport horodaté :

```text
reports/audit_YYYY-MM-DD_HH-MM-SS.txt
```

---

## 📂 Structure du projet

```text
audit-shell-project
│
├── audit.sh
│
├── config
│   └── targets.conf
│
├── logs
│   └── audit.log
│
├── reports
│
├── archives
│
└── README.md
```

---

## ⚙️ Installation

### 1. Cloner le projet

```bash
git clone https://github.com/VOTRE-DEPOT.git
```

### 2. Accéder au projet

```bash
cd audit-shell-project
```

### 3. Rendre le script exécutable

```bash
chmod +x audit.sh
```

---

## 🚀 Utilisation

### Audit système

```bash
./audit.sh --system
```

### Audit réseau

```bash
./audit.sh --network
```

### Audit sécurité

```bash
./audit.sh --security
```

### Tous les audits

```bash
./audit.sh --all
```

### Aide

```bash
./audit.sh --help
```

---

## 📊 Exemple de rapport

```text
RAPPORT D'AUDIT

Date : 2026-11-07 10:45:32
Machine : poste-linux
Utilisateur : etudiant
```

---

## 🛠️ Technologies utilisées

- Bash
- Linux
- Ubuntu / WSL2
- Git
- GitHub
- Visual Studio Code

---

## 👥 Équipe

Projet réalisé par :

- Maurice ABADOMA
- Franck Arthur PAWA
- Leonie TCHEUWO
- Tarigo FOGNO

---

## 🎓 Contexte académique

Projet réalisé dans le cadre du module **SYSTEM UNIX** de la formation **Ingénieur 1 - 3iL**.

Ce projet avait pour objectif d'appliquer de manière concrète les notions vues en cours à travers le développement d'un outil d'administration et d'audit système sous Linux.

---


⭐ N'hésitez pas à consulter le dépôt, proposer des améliorations ou signaler des pistes d'optimisation.
