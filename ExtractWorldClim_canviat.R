## Como extraer los datos de WorldClim para las coordenadas seleccionadas.

#Cargamos los datos del GBIF, que incluyen las coordenadas
library(readr)
gbif <- read_delim("DATOS.csv", 
                   "\t", escape_double = FALSE, trim_ws = TRUE)
View(gbif)
#Un poco de data wrangling
gbif2 <- gbif[, -c(3:8, 11,16,19:24,34:41,43)]
gbif2$taxonrank=as.character(gbif2$taxonrank)
View(gbif2)

cord <- data.frame (lon = gbif2$decimallongitude, lat=gbif2$decimallatitude) #Df con solo las cordenadas

install.packages("dismo")
library ("dismo")
library(raster)
library(sp)

r2.5 <- getData("worldclim",var="bio",res=2.5)
View(r2.5)
names(r2.5) <- c("BIO1","BIO2","BIO3","BIO4", "BIO5", "BIO6", "BIO7", "BIO8", "BIO9",
                 "BIO10","BIO11","BIO12","BIO13", "BIO14", "BIO15", "BIO16", "BIO17", "BIO18", "BIO19")

#Nota: las variables de temperatura estan multiplicadas por 10
#Nota: significado de las variables
#BIO1 = Annual Mean Temperature
#BIO2 = Mean Diurnal Range (Mean of monthly (max temp - min temp))
#BIO3 = Isothermality (BIO2/BIO7) (* 100)
#BIO4 = Temperature Seasonality (standard deviation *100)
#BIO5 = Max Temperature of Warmest Month
#BIO6 = Min Temperature of Coldest Month
#BIO7 = Temperature Annual Range (BIO5-BIO6)
#BIO8 = Mean Temperature of Wettest Quarter
#BIO9 = Mean Temperature of Driest Quarter
#BIO10 = Mean Temperature of Warmest Quarter
#BIO11 = Mean Temperature of Coldest Quarter
#BIO12 = Annual Precipitation
#BIO13 = Precipitation of Wettest Month
#BIO14 = Precipitation of Driest Month
#BIO15 = Precipitation Seasonality (Coefficient of Variation)
#BIO16 = Precipitation of Wettest Quarter
#BIO17 = Precipitation of Driest Quarter
#BIO18 = Precipitation of Warmest Quarter
#BIO19 = Precipitation of Coldest Quarter

plot(r2.5$BIO1, main="Mean Annual temperature")#graficos bonitos del mundo con las variables bioclimaticas

#Aquí se generan los spatialpoints a partir de las coordenadas de gbif y unimos con el dataframe de Worldclim
points <- SpatialPoints(cord, proj4string = r2.5@crs)
values <- extract(r2.5,points)
df <- cbind.data.frame(coordinates(points),values) #df con las coordenadas y sus valores de las variables bioclimaticas

View(df)


#Cuando generamos el mapa, podemos decirle que nos represente también los puntos(las plantas)
plot(r2.5[["BIO1"]])
plot(points,add=T)
read.csv("cord_clima.csv")

summary(df) #Hay muchos NA, hay que explorar porque. 

library(DataExplorer)
dim(df)
plot_missing(df2) # Tenemos un 5 % de NA's. Pensáis que son muchos? 
#Podemos eliminar directamente los NA's, 
df2 <- na.omit(df)
View(df2)
dim(df2) # Vemos que se han eliminado unas 5000 lineas de las 105000 lineas originales
summary(df2) ## nos puede dar una idea de las condiciones bioclimáticas más favorables para la família
plot_histogram(df2) ## también nos puede informar de lo mismo, pero de una manera más visual.
plot_density(df2)

plot_correlation(df2) ##Correlación entre las variables

##hacer algun mapa?

