#Como sacar los datos de WordClim de un pais concreto
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

