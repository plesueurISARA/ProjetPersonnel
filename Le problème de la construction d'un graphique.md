## Contexte
Nous sommes sur Rstudio, dans un fichier .R.\
Pour essayer avec les mêmes données, téléchargez le *"Fig1_INSEE_competences_numeriques.csv"*\
Le code initial est le suivant :\
```
#install.packages("ggplot2")
library(ggplot2)
CompNum1<-read.table("Fig1_INSEE_competences_numeriques.csv", sep=";",dec=",",header=TRUE, col.names = c("Age","Aucune", "Faible","Basique","Plus que basique" ))
AgeComp1<-CompNum1[,1]
NivComp1A<-CompNum1[,2]
NivComp1F<-CompNum1[,3]
NivComp1B<-CompNum1[,4]
NivComp1P<-CompNum1[,5]
```

## Problématique
Mon objectif est de créer un graphique où je peux empiler les données.\
Soit en barplot soit avec une courbe d'un ensemble de points:\
l'axe des abscisses serait l'âge, et l'axe des ordonnées la proportion de chaque niveau de compétence.

## Solutions essayées
### Esquisse
Avec esquisse de ggplot2 j'ai essayé de faire quelque chose, mais rien de bien concluant, la forme du jeu de données ne semble pas adéquat.
### Cheatsheet ggplot2
Je tente donc, depuis la cheatsheet de ggplot2 de faire un barplot, mais les paramètres sont incompréhensibles : \
`s<-ggplot(CompNum1,aes(fl, fill=drv))`\
Peut-être que si je comprenais ce que doit être `drv` j'y arriverai. Car je suppose que `fl` est un ensemble de données.
### Un plot classique ?
J'ai même essayé plus classiquement :\
`plot(AgeComp1,NivComp1A)`\
Mais : 
```
Error in plot.window(...) : 'xlim' nécessite des valeurs finies
In addition: Warning messages:
1: In xy.coords(x, y, xlabel, ylabel, log) : NAs introduced by coercion
2: In min(x) : no non-missing arguments to min; returning Inf
3: In max(x) : no non-missing arguments to max; returning -Inf
```
Je me suis dit qu'à partir de là je poubvais ajouter des courbes grâce à line(), mais si le début ne fonctionne pas...
### La solution de la dernière chance
Si toutefois je n'y arrive pas, je sais qu'en divisant mon tableau, en le mettant davantage sous forme de liste, je peux y arriver.\
C'est à dire que la colonne 1 repètera 5 fois les **âges**, la colonne 2 sera composées des **niveaux**, et la 3ème colonne fera les **proportions** selon les critères.\
Ce n'est pas forcément une solution que j'envisage, parce qu'il faut refaire le tableau, c'est un peu long, et je n'apprendrai rien. 

## Si vous avez une idée, je suis donc preneur de toute solution !
