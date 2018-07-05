
#ANALISIS EXPLORATORIO. 
install.packages("ggplot2")
library("ggplot2")
install.packages("DataExplorer")
library(DataExplorer)
head (MarcoClim10)
mode (MarcoClim10)

dim(MarcoClim10) #for checking the dimension
plot(MarcoClim10)  
plot_str(MarcoClim10) #visualizar estructura de los datos
is.na(MarcoClim10) #¿Tengo muchos datos faltantes? Entonces veremos cuales son las variables más importantes
plot_missing(MarcoClim10) #gráfico con missing values
plot_histogram(MarcoClim10)

plot_density(MarcoClim10)#This function visualizes density estimates for each continuous feature.


##Anlalisis Exploratorio Multivariante##

plot_correlation(MarcoClim10, 
                 type = "continuous") #Nose si esta bien escrito


install.packages("leaflet") #crear mapas
library(leaflet)
install.packages("ppcor") #correlacion entre variables
library(ppcor)

#Reduccion de la dimension. PCA, LDA? 


# ELIMINAR NAs
##Para eliminar todas las filas que no estan completas:
marcoclim1<- MarcoClim10[complete.cases(MarcoClim10), ]

# Ahora podemos hacer correlaciones:
install.packages("GGally")
library("GGally")
# Check correlation between variables
cor(marcoclim1) 
# Nice visualization of correlations
ggcorr(marcoclim1, method = c("everything", "pearson")) 
