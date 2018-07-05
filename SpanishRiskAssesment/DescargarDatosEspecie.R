# Descargar los datos de occurencias de una especie


install.packages("rgbif")
library("rgbif")
knitr::opts_chunk$set(echo = TRUE)
library(rgbif)
install.packages("tidyverse")
library(tidyverse)
install.packages("dismo")
library(raster)
library(sp)
library ("dismo")


occs<-occ_search(scientificName = "Urtica dioica") #Descargamos los datos de gbif para la Ortiga
occs<- occs$data #Extraemos los datos 
View(occs)

#guardamos un dataframe con solo las coordenadas
cord <- data.frame (lon = occs$decimalLongitude, lat=occs$decimalLatitude) 

#Descargamos WorldClim
r2.5 <- getData("worldclim",var="bio",res=2.5)

#NO FUNCIONA CON NAs!
points <- SpatialPoints(cord, proj4string = r2.5@crs) #definimos puntos con las coordenadas

values <- extract(r2.5,points) #Extramos los datos climaticos de las coordenadas donde esta la especie

df <- cbind.data.frame(coordinates(points),values) #rejuntamos el dataframe con los valores extraidos y los puntos

