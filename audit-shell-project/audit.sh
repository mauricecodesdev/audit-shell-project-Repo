#!/bin/bash

#Repertoires du script
DIR=$(cd "$(dirname "$0")" && pwd)
LOG="$DIR/logs/audit.log"
DATE=$(date '+%Y-%m-%d_%H-%M-%S')
RAPPORT="$DIR/reports/audit_$DATE.txt"

journaliser(){
    echo "[$(date '+%F %T')] $1" >> "$LOG"
}

ecrire_entete() {
    {
        echo "RAPPORT D'AUDIT"
        echo "Date        : $(date '+%F %T')"
        echo "Machine     : $(hostname)"
        echo "Utilisateur : $(whoami)"
        echo " "
    } > "$RAPPORT"
}

afficher_aide() {
    echo "Usage : $0 OPTION"
    echo "--system   audit du système"
    echo "--network  tests réseau"
    echo "--security contrôles de sécurité"
    echo "--all      les trois audits"
    echo "--help     cette aide"
}

audit_systeme() {
    echo "Audit système"
    echo "[1] Informations système"
    echo "Noyau : $(uname -r)"
    echo "Démarrée : $(uptime -p)"
    echo
    echo "Mémoire :"
    free -h
    echo
    echo "Disque racine :"
    df -h /
    echo
    echo "Les 5 processus les plus gourmands :"
    ps aux --sort=-%cpu | head -n 6
    echo
     >> "$RAPPORT"
    journaliser "Audit système terminé"
}

audit_reseau() {
    echo "Audit réseau"
}

audit_securite() {
    echo "Audit sécurité"
}

if [ $# -ne 1 ]; then
    afficher_aide
    exit 1
fi


journaliser "Execution du script"
ecrire_entete

case "$1" in
    --system)
        audit_systeme
        ;;
    --network)
        audit_reseau
        ;;
    --security)
        audit_securite
        ;;
    --all)
        audit_systeme
        audit_reseau
        audit_securite
        ;;
    --help)
        afficher_aide
        ;;
    *)
        echo "Option inconnue : $1"
        afficher_aide
        exit 1
        ;;
esac

