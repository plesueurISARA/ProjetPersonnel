##################################################  Nom : LESUEUR
#####_"Capacitees et competences numeriques"_#####  Prenom : Pierre
##################################################  Groupe : 
#install.packages("ggplot2")
library(ggplot2)
#install.packages("esquisse")
library(esquisse)
### ETAPE 1 : importantion des donnees
setwd("C:/Pierre/ISARA 4A/ModuleA-OPEN/ProjetPerso")
#Donc faut passer les donnees en .csv
CompNum1<-read.table("Fig1_INSEE_competences_numeriques.csv", sep=";",dec=",",header=TRUE, col.names = c("Age","Aucune", "Faible","Basique","Plus que basique" )) # fonctionnel
#OU
tableau<-read.csv2("Fig1_INSEE_competences_numeriques.csv", sep = ";", dec = ",",header = T,col.names = c("Age","Aucune", "Faible","Basique","Plus que basique" ))

### ETAPE 2 : definition des variables
AgeComp1<-CompNum1[,1]
NivComp1A<-CompNum1[,2]
NivComp1F<-CompNum1[,3]
NivComp1B<-CompNum1[,4]
NivComp1P<-CompNum1[,5]
x1<-AgeComp1[1,]
x2<-AgeComp1[6,]
### ETAPE 3 : calculs eventuels sur les variables

### ETAPE 4 : graphiques
s<-ggplot(CompNum1,aes(fl, fill=drv))
ggplot(CompNum1) +
  aes(x = AgeComp1, y = NivComp1A) +

ggplot(CompNum1) +
  aes(x = Age, y = Aucune) +
  geom_col(fill = "#112446") +
  theme_minimal()

plot(AgeComp1,NivComp1A)
plot(AgeComp1,NivComp1A, xlim = c(0,100) )
line
ggplot2::aes()
# ETAPE 5 : interpretation & explications
