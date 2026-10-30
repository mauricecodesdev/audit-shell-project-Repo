#!/bin/bash

#Repertoires du script
DIR=$(cd "$(dirname "$0")" && pwd)
LOG="$DIR/logs/audit.log"
DATE=$(date '+%Y-%m-%d_%H-%M-%S')
RAPPORT="$DIR/reports/audit_$DATE.txt"
NB_OK=0
NB_ERREUR=0

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

ecrire_resume() {
    {
        echo "[4] Résumé"
        echo "Tests OK : $NB_OK"
        echo "Tests en échec : $NB_ERREUR"
        echo
    } >> "$RAPPORT"

    journaliser "Résumé ajouté au rapport"
}

archiver_rapport() {
    archive="$DIR/archives/audit_$DATE.tar.gz"

    tar -czf "$archive" \
        -C "$DIR/reports" \
        "$(basename "$RAPPORT")"

    journaliser "Archive créée : $(basename "$archive")"
}

afficher_aide() {
    echo "Usage : $0 OPTION"
    echo "--system   audit du système"
    echo "--network  tests réseau"
    echo "--security contrôles de sécurité"
    echo "--all      les trois audits"
    echo "--help     cette aide"
    echo "--interactive menu interactif"
    echo "--html     génère un rapport HTML"
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
    if [ ! -f "$DIR/config/targets.conf" ]; then
        echo "Erreur : fichier targets.conf introuvable"
        journaliser "Erreur : fichier targets.conf introuvable"
        exit 2
    fi
    echo "[2] Tests réseau" >> "$RAPPORT"
    while read -r cible
    do
       [ -z "$cible" ] && continue
       [[ "$cible" =~ ^#.*$ ]] && continue
       
       echo "Test de connectivité vers $cible"
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

generer_html() {
    HTML="$DIR/reports/audit_$DATE.html"
    {
        echo "<html>"
        echo "<head>"
        echo "<meta charset='UTF-8'>"
        echo "<title>Rapport d'audit</title>"
        echo "</head>"
        echo "<body>"
        echo "<h1>Rapport d'audit</h1>"
        echo "<pre>"
        cat "$RAPPORT"
        echo "</pre>"
        echo "</body>"
        echo "</html>"
    } > "$HTML"
    journaliser "Rapport HTML créé : $(basename "$HTML")"
}

menu_interactif() {
    while true
    do
        echo
        echo "===== MENU AUDIT ====="
        echo "1 - Audit système"
        echo "2 - Audit réseau"
        echo "3 - Audit sécurité"
        echo "4 - Audit complet"
        echo "5 - Quitter"
        echo

        read -p "Votre choix : " choix

        case "$choix" in
            1)
                ecrire_entete
                audit_systeme
                ;;
            2)
                ecrire_entete
                audit_reseau
                ;;
            3)
                ecrire_entete
                audit_securite
                ;;
            4)
                ecrire_entete
                audit_systeme
                audit_reseau
                audit_securite
                ;;
            5)
                echo "Au revoir."
                break
                ;;
            *)
                echo "Choix invalide."
                ;;
        esac
    done
}

case "$1" in
    --system)
        ecrire_entete
        audit_systeme
        ;;
    --network)
        ecrire_entete
        audit_reseau
        ;;
    --security)
        ecrire_entete
        audit_securite
        ;;
    --all)
        ecrire_entete
        audit_systeme
        audit_reseau
        audit_securite
        ;;
    --help)
        afficher_aide
        exit 0;
        ;;
    --interactive)
        menu_interactif
        exit 0
        ;;
    --html)
        ecrire_entete
        audit_systeme
        audit_reseau
        audit_securite
        ecrire_resume
        generer_html
        exit 0
        ;;
    *)
        echo "Option inconnue : $1"
        afficher_aide
        exit 1
        ;;
esac

ecrire_resume
generer_html
archiver_rapport
echo
echo "Rapport créé : $RAPPORT"
echo "Tests OK : $NB_OK"
echo "Tests en échec : $NB_ERREUR"
journaliser "Audit $1 terminé"
