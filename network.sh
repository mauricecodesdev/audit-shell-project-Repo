#!/bin/bash

audit_reseau() {
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
