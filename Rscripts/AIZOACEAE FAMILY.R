library(ggplot2)
library(dplyr)
library(tidyr)
library(readr)
library(DataExplorer)

DATOS <- read_delim("C:/Users/RAMON/Desktop/Curs DATA/TREBALL DATA SCIENCE/DADES/DATOS.csv", 
                    "\t", escape_double = FALSE, trim_ws = TRUE)
View(DATOS)
#Le doy un nombre a los datos, más corto para que sea más manejable. 
dat<- DATOS
#DATA-WWRANGLING
##Primero ver las variables y los datos
summary(DATOS)
plot_str(DATOS)
plot_missing(DATOS) #ayuda a decidir las variables a eliminar( las que más NA's tengan)

kingdom<-unique(dat$kingdom) ##Reino "Planteae"
phylum<- unique(dat$phylum) ## fílum "Traqueofitos"
class<- unique(dat$class)  ##clase "Magnoliopsida"
order<- unique(dat$order) ##  ordren "Caryophyllales"
family<- unique(dat$family) ## família Aizoaceae
genus<- unique(dat$genus) ## 133 generos
species <- unique(dat$species)##1753 especies 

##Vamos a eliminar algunas columnas(variables que no nos són útiles)
##Eliminar columnas--> mirando los datos, podemos eliminar aquellas columnas que no nos interesen
dat2 <- dat[, -c(2:8, 11:13,15:16,19:24,29,32:34:41:43)] ##subset data, eliminando las columans que no me sirven.
View(dat2)

###Aquí las que he eliminado(entre parentesis el número de columna que ocupaban y en algunas he puesto NA's por ser la razón de su deletion)
###datasetkey(2), Occurrenceid(3),infraespecificepithet(11,Na’s),taxonrank,scientificname(repetido) ,locality(15, ja tenim countrycode) publishingorgkey(16), 
###coodinateuncertaintyinmeters(19), coordinateprecision, elevation, elevationaccuracy, depth,depthacc(24) tenen molts NA’s,
###taxonkey(29),instutioncode(32), collectioncode(33)
###catalognumber(34), recordnumber(NA’s), identifiedby, license,rightsolder, recordedby, typestatus(NA’s), establishmentmeans(41,NA’s),lastintep(42) ,mediatype(43)
###Hay algunas variables que no sabia si eliminar: institutioncode&collectioncode porque quizas nos puede estar hablando de un mal o buen muestreo?
###Issue habla sobre coordenadas, nos puede servir de ayuda cara a hacer un mapa?
###datasetkey, puede que nos ayude a clasificar de otra forma. 


##Transformar variables
summary(dat2) ##Hago un summary para ver de nuevo las variables 
plot_str(dat2)



##Vamos a transformar alguna variable en categórica 

taxonrank <- unique(dat2$taxonrank) #tiene 6 variables diferentes, vamos a categorizar
dat2$taxonrank=as.character(dat2$taxonrank)
View(dat2)

country<- unique(dat2$countrycode)
length(country)
##Hacer histogramas
plot_density(dat2) ##simplemente lo hago para ver si pudiésemos sacar algo de info.

##Hacer gráfico relcionando géneros y countrycode, especie y country code
##usar las coordenadas para posicionarlo en un mapa(usar como plantilla el ejemplo del Toni)

table(dat2$genus)
barplot(prop.table(table(dat2$genus))) ##solo estoy probando 

##Me gustaría trabaja un poco más los diferentes gráficos que podemos extraer de estos datos, relacionado las variables entre si(este finde me pondré)
##Feelfree de modificar y "wranglear" todo lo que querais!! 
