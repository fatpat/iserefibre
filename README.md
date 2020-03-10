# iserefibre
Stats suivi d'éligibilité sur le RIP isère fibre

Ce script s'appuie sur des données rendues publiques par isère fibre.

Il suffit d'appeler le script `iserefibre` pour récupérer l'ensemble de la base isère fibre et de générer les stats associées.
Les résultats sont stockés dans un répertoire à la date du jour (au format `AAAAMMJJ`).

Attention, ce script peu flooder le site d'isère fibre, ne pas en abuser !

## Résultats

Les résultats sont générés dans le répertoire à la date du jour (au format `AAAMMJJ`). On va trouver:
- `villes`: liste l'ensemble des villes répertoriées dans la base isère fibre
- `types`: liste l'ensemble des type de voie pour chaque ville
- `noms`: liste l'ensemble des noms de rue pour chaque type/ville
- `adresses`: liste l'ensemble des adresses
- `resultats`: liste, pour chaque adresse, l'éligibilité indiquée par Isère Fibre
- `stats.csv`: des stats, au fromat csv, pour chaque commune et au globale
