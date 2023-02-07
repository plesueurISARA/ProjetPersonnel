##################################################  Nom : LESUEUR
#####_"Capacitees et competences numeriques"_#####  Prenom : Pierre
##################################################  Groupe : 
#install.packages("ggplot2")
library(ggplot2)
#install.packages("reshape2")
library(reshape2)
#install.packages("esquisse")
#library(esquisse)
#install.packages("questionr")
library(questionr)
##### ETAPE 1 : importantion des donnees #####
setwd("C:/Pierre/ISARA 4A/ModuleA-OPEN/ProjetPerso")
#Quand les données sont en .csv
CompNum1_unmelted<-read.table("Fig1_INSEE_competences_numeriques.csv", 
                     sep=";",dec=",",header=TRUE, 
                     col.names = c("Age","Aucune", "Faible","Basique","Plus que basique" )
                     ) # fonctionnel
#OU
#tableau<-read.csv2("Fig1_INSEE_competences_numeriques.csv", sep = ";", dec = ",",header = T,col.names = c("Age","Aucune", "Faible","Basique","Plus que basique" ))

##### ETAPE 2 : reformatage #####
#on utilise la fonction melt() du package reshape2
Comp1 <- melt(CompNum1_unmelted, id.vars="Age", col.names= c("Tranche d'âge","Niveau de compétence", "Proportion")) # transforme les données en 3 colonnes, avec 1 ligne = 1 pourcentage/1 croisement
prop.table(CompNum1_unmelted, 1)
class(Comp1)
Comp1_matrix <- as.matrix(Comp1)
Comp1_proportions <- prop.table(Comp1_matrix, 1)

##### ETAPE 3 : calculs statistiques #####

### Test du X^2
Comp1_cross_tab <- xtabs(value ~ Age + variable, data = Comp1)
chisq.test(Comp1_cross_tab)

#On obesrve : 
# - La valeur du chi2 (distance entre notre tabl observé et celui attendu si les 2 variables étaient indépendantes)
# - Le nombre de degrés de libertés, df
# - La p-value, s'il est inférieur à 0.05 alors on rejette l'hypothèse d'indépendance des lignes et colonnes.
#La pvalue est inférieure à 0,05 ; nous pouvons donc rejetter l'hypothèse d'indépendance. 
#Ce qui nous arrange bien, puisqu'on cherche à mettre en avant que l'âge est lié au niveau de compétece dans le numérique.
#Analyse des résidus
chisq.residuals(Comp1_cross_tab)
# si la valeur d'un résidu pour une case est inférieure à -2, alors il y a sous-représentation de cette case, les effectifs sont significativement plus faibles que sous l'hyp d'indépendance.
# si >2 alors sur-représentation
# Je ne sais pas trop quoi dire à ce propos.

##### ETAPE 4 : graphiques #####

### Solution de ChatGPT :
# Créez un tableau croisé avec des données fictives
ggplot(data2_melted, aes(x=Age, y=value, fill=variable)) +
  geom_bar(stat="identity", position="stack") +
  labs(x="Tranche d'âge", y="Proportion de la population") +
  ggtitle("Compétence numérique en fonction de l'âge") +
  theme(plot.title = element_text(hjust = 0.5))


##### ETAPE 5 : interpretation & explications #####