# Audit Shell Project
# Description

Ce projet consiste à réaliser un script Bash permettant d'effectuer différents audits sur une machine Linux.

Le script peut effectuer :

- un audit système ;
- un audit réseau ;
- un audit de sécurité ;
- un audit complet regroupant les trois précédents.

Les résultats sont enregistrés dans un rapport horodaté, archivés automatiquement et les actions sont enregistrées dans un journal d'exécution.


# Installation

1. Cloner le dépôt github créé ou alors utilisé le dossier compressé zip :

    git clone <url-du-depot>
    cd audit-shell-project

2. Rendre le script exécutable :

    chmod +x audit.sh

3. Vérifier que l'arborescence du projet est présente :

   ```text
    audit-shell-project/
    ├── audit.sh
    ├── config/
    │   └── targets.conf
    ├── logs/
    ├── reports/
    ├── archives/
    ├── README.md
    └── tests.md
    ```

# Options disponibles

# Audit système

./audit.sh --system

Affiche des informations sur le système :
    - la version du noyau 
    - la durée de fonctionnement 
    - la mémoire 
    - l'espace disque 
    - les processus les plus gourmands

# Audit réseau

    ./audit.sh --network

Teste la connectivité des machines définies dans :

    config/targets.conf

et indique le nombre de tests réussis et échoués.


# Audit sécurité

    ./audit.sh --security

Affiche :
- les comptes utilisant Bash 
- les ports en écoute 
- les fichiers possédant des permissions 777


# Audit complet

    ./audit.sh --all

Exécute l'ensemble des audits dans un seul rapport.

# Aide

    ./audit.sh --help

Affiche la liste des options disponibles.


* Exemple d'utilisation

Exécution d'un audit complet :

    ./audit.sh --all

Exemple de résultat :

Rapport créé : reports/audit_2026-10-30_10-15-20.txt
Tests OK : 1
Tests en échec : 1


* Une archive compressée est également créée dans le dossier archives/

* Pour exécuter automatiquement un audit complet chaque jour à 8h :

    ```cron
        0 8 * * * /chemin/audit-shell-project/audit.sh --all
    ```
Cette ligne est donnée à titre d'exemple et n'est pas installée automatiquement

# Limites

- Les tests réseau nécessitent une connexion réseau fonctionnelle
- Le fichier `config/targets.conf` doit être présent. Mais on a dès le départ configuré l'environnement avec tous les fichiers et dossiers
- Certains résultats peuvent dépendre des droits de l'utilisateur qui exécute le script
- La détection des permissions 777 est limitée aux fichiers accessibles par l'utilisateur
- Les audits réalisés fournissent des informations de diagnostic mais ne garantissent pas l'absence de vulnérabilités sur la machine

# Fonctionnalités bonus
En plus des fonctionnalités demandées dans le projet, deux améliorations ont été ajoutées

# Menu interactif

    ./audit.sh --interactive

Cette option affiche un menu permettant de lancer les différents audits sans avoir à saisir les options manuellement.

Menu proposé :
    1 - Audit système
    2 - Audit réseau
    3 - Audit sécurité
    4 - Audit complet
    5 - Quitter

L'utilisateur choisit  le numéro correspondant à l'action souhaitée.

# Rapport HTML

    ./audit.sh --html

Cette option génère une version HTML du rapport d'audit en plus de la version texte.
Les rapports sont enregistrés dans le répertoire :

    reports/

Exemple :

    audit_2026-10-30_18-00-00.txt
    audit_2026-10-30_18-00-00.html

Le rapport HTML peut être ouvert directement dans un navigateur web pour une lecture plus confortable
