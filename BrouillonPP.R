##################################################  Nom : LESUEUR
#####_"Capacitees et competences numeriques"_#####  Prenom : Pierre
##################################################  Groupe : 
# encoding: latin1
#install.packages("ggplot2")
library(ggplot2)
#install.packages("reshape2")
library(reshape2)
#install.packages("esquisse") #aurait pu être utile pour tracer facilement notre graph, mais ne fonctionne pas avec 2 variables qualitatives.
#library(esquisse)
#install.packages("questionr")  # aurait pu être utle pour les fonction lprop() et cprop() pour avoir les proportions en colonne ou en ligne. Mais ça ne fonctionnne pas parce que c'est des variables qualitatives.
library(questionr)
##### ETAPE 1 : importantion des donnees #####
setwd("C:/Pierre/ISARA 4A/ModuleA-OPEN/ProjetPersonnel")
#Quand les données sont en .csv
CompNum1_unmelted<-read.table("Fig1_INSEE_competences_numeriques.csv", 
                     sep=";",dec=",",header=TRUE, 
                     col.names = c("Age","Aucune", "Faible","Basique","Plus que basique" )
                              ) # fonctionnel
CompNum2_unmelted<-read.table("Fig2_INSEE_competences_numeriques.csv", 
                              sep=";",dec=",",header=TRUE, 
                              col.names = c("Diplome","Aucune", "Faible","Basique","Plus que basique" ),
                              encoding = "latin1"
                              )
CompNum2bis_unmelted<-read.table("Fig2bis_INSEE_competences_numeriques.csv", 
                                 sep=";",dec=",",header=TRUE,
                                 col.names = c("Diplome","Aucune", "Faible","Basique","Plus que basique" ),
                                 encoding = "latin1"
                                 )
#OU
#tableau<-read.csv2("Fig1_INSEE_competences_numeriques.csv", sep = ";", dec = ",",header = T,col.names = c("Age","Aucune", "Faible","Basique","Plus que basique" ))

##### ETAPE 2 : reformatage #####
#on utilise la fonction melt() du package reshape2
Comp1 <- melt(CompNum1_unmelted, id.vars="Age") # transforme les données en 3 colonnes, avec 1 ligne = 1 pourcentage/1 croisement
nomcolmat1<-c("Tranche_d_age","Niveau_de_compétence", "Proportion")
colnames(Comp1)<-nomcolmat1 #attribution d'un Nom aux Colonnes d'une Matrice
Comp2 <- melt(CompNum2_unmelted, id.vars="Diplome") 
nomcolmat2<-c("Diplome","Niveau_de_compétence", "Proportion")
colnames(Comp2)<-nomcolmat2
#table(Comp2$Diplome)
#unique(Comp2$Diplome)
Comp2$Diplome<-factor(Comp2$Diplome, levels = c("Aucun diplôme ou CEP", "CAP, BEP ou BEPC", "Bac ou équivalent", "Bac +2", "Bac +3 ou plus", "Ensemble") ) #changement d'ordre pour la lisibilité du graphique en vulgarisation
Comp2bis <- melt(CompNum2bis_unmelted, id.vars="Diplome") 
colnames(Comp2bis)<-nomcolmat2
Comp2bis$Diplome<-factor(Comp2bis$Diplome, levels = c("Aucun diplôme ou CEP", "CAP, BEP ou BEPC", "Bac ou équivalent", "Bac +2", "Bac +3 ou plus", "Ensemble") ) 

##### ETAPE 3 : calculs statistiques #####
#on a pas trop le droit de faire un chi2 avec des %, la significativité sera tjrs atteinte
#on connait pas les effectifs des profils en fait, on met tlm au même niveau
# et puis mettre "Ensemble" alors que c'est une moyenne, et donc que les effectifs sont déjà inclu dans les autres, bah on a pas le droit.
#eventuellement AFC

### Test du χ² dans Comp1
Comp1_cross_tab <- xtabs(Proportion ~ Tranche_d_age + Niveau_de_compétence, data = Comp1)
chisq.test(Comp1_cross_tab)
mosaicplot(Comp1_cross_tab, shade = T)
#On obesrve : 
# - La valeur du chi2 (distance entre notre tabl observé et celui attendu si les 2 variables étaient indépendantes)
# - Le nombre de degrés de libertés, df
# - La p-value, s'il est inférieur à 0.05 alors on rejette l'hypothèse d'indépendance des lignes et colonnes.
#La pvalue est inférieure à 0,05 ; nous pouvons donc rejetter l'hypothèse d'indépendance. 
#Ce qui nous arrange bien, puisqu'on cherche à mettre en avant que l'âge est lié au niveau de compétece dans le numérique.
#Analyse des résidus
chisq.residuals(Comp1_cross_tab) #fonction du package "questionr"
# si la valeur d'un résidu pour une case est inférieure à -2, alors il y a sous-représentation de cette case, les effectifs sont significativement plus faibles que sous l'hyp d'indépendance.
# si >2 alors sur-représentation
# Je ne sais pas trop quoi dire à ce propos.

### Test du χ² dans Comp2
Comp2_cross_tab <- xtabs(Proportion ~ Diplome + Niveau_de_compétence, data = Comp2)
chisq.test(Comp2_cross_tab)
#La pvalue est inférieure à 0,05 ; nous pouvons donc rejetter l'hypothèse d'indépendance. 
#Ce qui nous arrange bien, puisqu'on cherche à mettre en avant que le niveau d'éducation, via le diplôme est lié au niveau de compétece dans le numérique.
#Analyse des résidus
chisq.residuals(Comp2_cross_tab) 
#Beaucoup de sur-représentations et sous-représentations.

### Test du χ² dans Comp2bis
Comp2bis_cross_tab <- xtabs(Proportion ~ Diplome + Niveau_de_compétence, data = Comp2)
chisq.test(Comp2bis_cross_tab)
#La pvalue est inférieure à 0,05 ; nous pouvons donc rejetter l'hypothèse d'indépendance. 
#Ce qui nous arrange bien, puisqu'on cherche à mettre en avant que le niveau d'éducation, via le diplôme est lié au niveau de compétece dans le numérique.
#(exactement les mêmes valeurs que Comp2)
#Analyse des résidus
chisq.residuals(Comp2bis_cross_tab) 
#Beaucoup de sur-représentations et sous-représentations.
#résidu négatif, évitemment, beaucoup moins nombreux qu'attendu sous l'indépendance
#(exactement les mêmes valeurs que Comp2)

##### ETAPE 4 : graphiques #####

ggplot(Comp1, aes(x=Tranche_d_age, y=Proportion, fill=Niveau_de_compétence)) +
  geom_bar(stat="identity", position="stack") +
  labs(x="Tranche d'âge", y="Proportion de la population") +
  ggtitle("Compétences numériques en fonction de l'âge") +
  theme(plot.title = element_text(hjust = 0.5))

ggplot(Comp2, aes(x=Diplome, y=Proportion, fill=Niveau_de_compétence)) +
  geom_bar(stat="identity", position="stack") +
  labs(x="Diplôme", y="Proportion de la population") +
  ggtitle("Compétences numériques en fonction du niveau d'étude") +
  theme(plot.title = element_text(hjust = 0.5))

#On voit que les données ne sont pas cohérentes avec ce qu'on veut montrer. 
#On observe dans ces données que plus notre niveau de dîplome est faible, meilleures sont nos compétences en numérique.
#L'erreur vient des données, où les noms des colonnes ont été inversées par rapport à ce qu'on veut montrer.
#On voit bien que ça vient des données parce que sur le site https://www.insee.fr/fr/statistiques/4238593?sommaire=4238635#consulter
# à la figure 2, lorsque l'on veut masquer les compétences faibles en cliquant sur la légende, c'est compétence de base qui est masqué.
#Ainsi on peut supposer que les données associées à compétences faibles sont celles de compétence de base et inversement, de même pour
#compétences plus que basqiues avec Aucune compétence ou aucune utilisation d'Internet.

#graphique avec les données corrigées
ggplot(Comp2bis, aes(x=Diplome, y=Proportion, fill=Niveau_de_compétence)) +
  geom_bar(stat="identity", position="stack") +
  labs(x="Diplôme", y="Proportion de la population") +
  ggtitle("Compétences numériques en fonction du niveau d'étude") +
  theme(plot.title = element_text(hjust = 0.5)
  )


##### ETAPE 5 : interpretation & explications #####
# définir Aucune, Faible, Basique et Plus que basique
#

##### Améliorations possibles #####
#stringr, grep,
#retirer les . intermédiares de Plus.que.basique dans la légende

