#!/bin/bash

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

