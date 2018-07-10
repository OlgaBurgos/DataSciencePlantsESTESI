#Como sacar los datos de WordClim de un pais concreto
#Basado en :http://www.jamieafflerbach.com/post/cropping-rasters-down-to-size/
#Se tienen que hacer dos pasos: primero cortar y luego emascarar
#La función crop corta una caja inclyendo el poligono a cortar
#La función mask aplica una mascara seleccionando solo los puntos dentro del poligono.

install.packages("raster")
library("raster")
library(sp)
install.packages("dismo")
library("dismo")

#Download the WorldClim Data
worldata <- getData("worldclim",var="bio", res=10) # res=10 define la resolución en "minutes of a degree", var=bio descarga las 19 variables climaticas. Tambien se pueden descargar variables sueltas. Valid variables names are 'tmin', 'tmax', 'prec' and 'bio

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


#Download the Spain boundaries
#https://www.gis-blog.com/r-raster-data-acquisition/
#The country code is obtained from: http://kirste.userpage.fu-berlin.de/diverse/doc/ISO_3166.html

spain <- getData('GADM', country='ESP', level=0)
plot(spain)
s<- crop(worldata, spain)
s2 <- mask(s, spain)
plot (s2$bio1)


#Para otro Pais:
russia <- getData('GADM', country='RUS', level=0)
plot(russia)
r<- crop(worldata, russia)
r2 <- mask(r, russia)
plot (r2$bio1)

