Données brutes des compteurs cycles déployés par GAM.

Codes états
-----------

### Jours spéciaux

* `0x0001` : Week-end
* `0x0002` : Férié
* `0x0004` : Vacances scolaires
* `0x0010` : Grève transports
* `0x0020` : Confinement sanitaire

### Dysfonctionnement compteur

* `0x0100` : Installation compteur
* `0x0200` : Dysfonctionnement compteur
* `0x0400` : Total depuis données historiques (Excel GAM)

### Problème aménagement cyclable

* `0x1000` : Fermeture totale aménagement cyclable
* `0x2000` : Modification accès aménagement

Évolutions
----------

### 2020-05-19 Ouverture des accès publics par EcoCompteur

### 2020-11-30 Modification des flux

Les agrégats des flux semblent avoir été modifiées à compter du 30/11/2020.

### 2020-12-29 Évolution repo suite modifications EcoCompteur

* Modification des appels API et des structures pour s'adapter aux nouvelles données.
* Retour à un fichier unique par point de comptage
* Ajout de la semaine ISO dans les fichiers
* Ajout d'un code état pour marquer les dysfonctionnements connus/repérés
* Rattrapage des données en retard
