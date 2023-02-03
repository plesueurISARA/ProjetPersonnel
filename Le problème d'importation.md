## Contexte :

Nous sommes sur Rstudio, dans un fichier .R.

`CompNum1<-read.table("Fig1_INSEE_competences_numeriques.csv", sep=";",dec=",")`

## Problématique :

`Error in make.names(col.names, unique = TRUE) : 
  invalid multibyte string 2`
  
## Solution essayées :

### Un problème d'accent ?
En tout cas, Rstudio est bien en UTF-8 (Tools/Global Options.../Code/Saving/Serialization/Default texte encoding: UTF-8)

### Un problème au niveau des titres ?
Probablement, puisque la seule solution que j'ai trouvé pour contourner le problème est de définir les noms des colonnes à l'importation.
`CompNum1<-read.table("Fig1_INSEE_competences_numeriques.csv", sep=";",dec=",",header=TRUE, col.names = c("Age","Aucune", "Faible","Basique","Plus que basique" ))`

## Je suis donc preneur de tout autre solution !
