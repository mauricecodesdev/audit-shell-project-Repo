| Test | Commande | Résultat attendu | Code de retour |
|------|------|------|------|
| T1 | ./audit.sh | aide | 1 |
| T2 | ./audit.sh --toto | Option inconnue | 1 |
| T3 | ./audit.sh --system | rapport avec la section [1] | 0 |
| T4 | ./audit.sh --network | un OK, un ERREUR | 0 |
| T5 | ./audit.sh --all | rapport complet + archive | 0 |
| T6 | targets.conf renommé puis ./audit.sh --network | message d'erreur | 2 |
