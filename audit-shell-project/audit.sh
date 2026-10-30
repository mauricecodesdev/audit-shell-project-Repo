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
    {
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
    } >> "$RAPPORT"
    journaliser "Audit système terminé"
}

audit_reseau() {
    echo "Audit réseau"
    echo
    echo "[2] Tests réseau" >> "$RAPPORT"
    while read -r cible
    do
       [ -z "$cible" ] && continue
       echo "Test de connectivité vers $cible"
       [[ "$cible" =~ ^#.*$ ]] && continue
   if ping -c 1 "$cible" >> "$RAPPORT" 2>&1; then
       echo "Connectivité vers $cible : OK" >> "$RAPPORT"
       NB_OK=$((NB_OK + 1))
   else
       echo "Connectivité vers $cible : Échec" >> "$RAPPORT"
       NB_ERREUR=$((NB_ERREUR + 1))
   fi
   done < "$DIR/config/targets.conf"
   journaliser "Tests réseau terminés. Résultats : $NB_OK OK, $NB_ERREUR Échec"

}

audit_securite() {
    echo "Audit sécurité"
    {
        echo "[3] Analyse de sécurité"
        echo "Comptes avec un shell bash :"
        grep 'bash$' /etc/passwd | cut -d: -f1
        echo
        echo "Ports en écoute :"
        ss -tuln
        echo
        echo "Fichiers en mode 777 dans $HOME :"
        find "$HOME" -type f -perm 0777 2>/dev/null
        echo
        echo "(indicateurs à examiner, pas une preuve de vulnérabilité)"
        echo
    } >> "$RAPPORT"
    journaliser "Audit sécurité terminé"
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

