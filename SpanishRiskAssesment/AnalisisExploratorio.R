
#ANALISIS EXPLORATORIO. 
install.packages("ggplot2")
library("ggplot2")
install.packages("DataExplorer")
library(DataExplorer)
head (MarcoClim2_5)
mode (MarcoClim2_5)

dim(MarcoClim2_5) #for checking the dimension
plot(MarcoClim2_5)  
plot_str(MarcoClim2_5) #visualizar estructura de los datos
is.na(MarcoClim2_5) #¿Tengo muchos datos faltantes? Entonces veremos cuales son las variables más importantes
plot_missing(MarcoClim2_5) #gráfico con missing values
plot_histogram(MarcoClim2_5)

plot_density(MarcoClim2_5)#This function visualizes density estimates for each continuous feature.


# ELIMINAR NAs
##Para eliminar todas las filas que no estan completas:
marcoclim1<- MarcoClim2_5[complete.cases(MarcoClim2_5), ]

# Ahora podemos hacer correlaciones:
install.packages("GGally")
library("GGally")
# Check correlation between variables
cor(marcoclim1) 
# Nice visualization of correlations
ggcorr(marcoclim1, method = c("everything", "pearson")) 

##Anlalisis Exploratorio Multivariante##

plot_correlation(MarcoClim1, 
                 type = "continuous") #Matriz de correlaciones con colores


install.packages("leaflet") #crear mapas
library(leaflet)
?leaflet
install.packages("ppcor") #correlacion entre variables
library(ppcor)
?ppcor

#Reduccion de la dimension. PCA, LDA? 
