## Contexte
Nous sommes sur Rstudio, dans un fichier .R.\
Pour essayer avec les mêmes données, téléchargez le *"Fig1_INSEE_competences_numeriques.csv"*\
Le code initial est le suivant :\
```
#install.packages("ggplot2")
library(ggplot2)
CompNum1<-read.table("Fig1_INSEE_competences_numeriques.csv", sep=";",dec=",",header=TRUE, col.names = c("Age","Aucune", "Faible","Basique","Plus que basique" ))
AgeComp1<-factor(CompNum1[,1])
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
Même comme ça je n'y arrive pas, le plot tracé `plot(AgeComp1,NivComp1A, type = "l")`ne correspond en rien à ce que j'espère faire ensuite ; c'est à dire superposer des courbes par la fonction line().
### La solution de la dernière chance
Si toutefois je n'y arrive pas, je sais qu'en divisant mon tableau, en le mettant davantage sous forme de liste, je peux y arriver.\
C'est à dire que la colonne 1 repètera 5 fois les **âges**, la colonne 2 sera composées des **niveaux**, et la 3ème colonne fera les **proportions** selon les critères.\
Ce n'est pas forcément une solution que j'envisage, parce qu'il faut refaire le tableau, c'est un peu long, et je n'apprendrai rien. \
Edit, plus je vois d'exemples, plus je me dis que c'est parce que les données ne sont pas rentrées de telle sorte à faire apparaitre clairement les 2 variables.

## Code de la solution 
Finalement, ce code reprend la "solution de la dernière chance" mais avec une fonction : melt(). On aurait tout aussi bien pu utiliser les fonctions pivot_longer et pivot_wider du package "tidyR". 
```
#install.packages("ggplot2")
library(ggplot2)
#install.packages("reshape2")
library(reshape2)

#Quand les données sont en .csv
CompNum1_unmelted<-read.table("Fig1_INSEE_competences_numeriques.csv", 
                     sep=";",dec=",",header=TRUE, 
                     col.names = c("Age","Aucune", "Faible","Basique","Plus que basique" )
                     ) # fonctionnel

#on utilise la fonction melt() du package reshape2
Comp1 <- melt(CompNum1_unmelted, id.vars="Age", col.names= c("Tranche d'âge","Niveau de compétence", "Proportion")) # transforme les données en 3 colonnes, avec 1 ligne = 1 pourcentage/1 croisement

ggplot(data2_melted, aes(x=Age, y=value, fill=variable)) +
  geom_bar(stat="identity", position="stack") +
  labs(x="Tranche d'âge", y="Proportion de la population") +
  ggtitle("Compétence numérique en fonction de l'âge") +
  theme(plot.title = element_text(hjust = 0.5))
```
