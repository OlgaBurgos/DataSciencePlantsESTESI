#Explorando la base de datos
#Los datos con las coordenadas y las variables bioclimaticas estan guardados en la misma carpeta (TODO.csv). 
# Solo hay que establecer la carpeta como working directory y cargarlos directamente. 
# Los datos salen del Script "ExtractWordClim2"
library(readr)
setwd("~/DataSciencePlantsESTESI")
TODO <- read_delim("TODO.csv", ";", escape_double = FALSE, 
                   +     trimws = TRUE)

Data <- TODO[complete.cases(TODO),]


install.packages("ggplot2")
library(ggplot2)  

TODO$genus <- as.factor(TODO$genus)

ggplot(TODO, aes(x=TODO$BIO1, fill=TODO$genus)) + geom_density(alpha=.3) ## demasiados géneros



# PCA
standardisedbios <-as.data.frame(scale (Data[15:33]))

pcabIO <- prcomp(standardisedbios)
summary(pcabIO)
pcabIO$sdev
screeplot(pcabIO, type="lines")

plot(pcabIO$x[,1],pcabIO$x[,2])
text(pcabIO$x[,1],pcabIO$x[,2], Data$genus, cex=0.7, pos=4, col="red")


install.packages("factoextra")
library("factoextra")

plot(pcabIO$x[,1],pcabIO$x[,2], col=Data$genus)
qplot(pcabIO$x[,1],pcabIO$x[,2],data=Data,colour=Data$genus) ##d'aquesta manera si que deixa fer el gráfic

fviz_pca_ind(pcabIO,
             geom.ind = "point", # show points only (nbut not "text")
             col.ind = Data$genus, # color by groups
             palette = "Spectral",
             addEllipses = TRUE, # Concentration ellipses
             legend.title = "Groups")




#http://www.sthda.com/english/articles/31-principal-component-methods-in-r-practical-guide/112-pca-principal-component-analysis-essentials/

##Podemos escoger aquellos géneros que tengan más de un 1 % ( también podríamos trabajar con 
# aquellos de los que se tenga constancia de la presencia de alguna sp invasora?)
library(descr)
freq(Data$genus, plot = T)
generos <- table(Data$genus)
generos
View(generos)

prop.table(generos)
tbl <- table(Data$genus)

ea<- unique(Data$genus)
ea
taula<- cbind(tbl,round(prop.table(tbl)*100,2))

taula   ## A partir de esta tabla podemos escoger los géneros mayores a 1!
dim(taula)
taula2<- as.data.frame.matrix(taula) 
Generos_abun <- taula2%>%
  filter(V2>=1)
Generos_abun ## pero ahora no me salen los géneros... no sé como conseguir que salgan! Hay 17 géneros por encima de 1%,

## He encontrado otra forma de hacerlo, mejor! 

library(dplyr)

freqtable<- TODO %>%
  count(genus) %>%
  mutate(prop = round(prop.table(n)*100,2))
freqtable

freqtable2 <- freqtable%>%
  filter(prop>=1)
freqtable2
## Entonces los género má abundantes son: "Aizoanthemum","Aizoon", "Antimima","Carpobrotus","Conophytum"
#"Delosperma", "Disphyma", "Drosanthemum", Erepsia,"Galenia", "Gunniopsis", "Lampranthus", "Mesembryanthemum",
#"Ruschia", "Sesuvium", "Tetragonia","Trianthema  "Zaleya"

# Ahora intentemos hacer un subset con estos géneros

datared<- TODO%>%
  filter(genus==c("Aizoanthemum","Aizoon", "Antimima","Carpobrotus","Conophytum",
                 "Delosperma", "Disphyma", "Drosanthemum", "Erepsia","Galenia", "Gunniopsis", "Lampranthus", "Mesembryanthemum",
                 "Ruschia", "Sesuvium", "Tetragonia","Trianthema" ,"Zaleya"))

## no me deja no se porqueee 