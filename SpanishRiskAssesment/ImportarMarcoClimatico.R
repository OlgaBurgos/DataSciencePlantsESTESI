# SCRIPT 1
# 4/7/18
# Descarga de los datos climaticos de WorldClim y recorte de los datos pertenecientes a la Peninsula Iberica 

######### USE #####################################################
#Paquetes necesarios
install.packages("raster")
library("raster")
library(sp)
install.packages("dismo")
library("dismo")

#Download the WorldClim Data
worldata <- getData("worldclim",var="bio", res=10) # res=10 define la resolución en "minutes of a degree", var=bio descarga las 19 variables climaticas. Tambien se pueden descargar variables sueltas. Valid variables names are 'tmin', 'tmax', 'prec' and 'bio

# OPCION 1: (recortar por la frontera exacta de un pais)
#Download the Spain boundaries
#https://www.gis-blog.com/r-raster-data-acquisition/
#The country code is obtained from: http://kirste.userpage.fu-berlin.de/diverse/doc/ISO_3166.html
spain <- getData('GADM', country='ESP', level=0)
plot(spain)
s<- crop(worldata, spain) #Pero as? obtenemos espa?a entera
plot (s$bio1)

# OPCION 2: (la escogida)
#Recortamos con extent los grados de longitud y latitud que emarcan la peninsula iberica
e <- extent(-10,4,36,44) #definimos el marco
s.crop <- crop(worldata, e) #Recortamos el worlddata con el extent
plot (s.crop$bio1)

#Para sacar los valores dentro del archivo s.crop que esta en raster, usamos la funcion as.matrix del paquete raster que saca todos los valores
a<-as.matrix(s.crop) #Es una matriz de 19 variables, nos faltan las coordenadas de cada punto, aunque no son esenciales. 
plot(a[,1]) #por ejemplo los datos de la primera columna

plot(a[,1]~a[,12], pch=19, col="lightblue", xlab="Precipitaci?n Anual (mm)", ylab="Temperatura anual media (?C x10)", main="Marco clim?tico Ib?rico") #ploteamos temperatura media anual y precipitacion anual

# "a" es una matriz, lo que dificulta mucho su gestion, lo convierto en data.frame.
marcoclim <- as.data.frame(a)

# Mejor ponemos nombres a las variables para manejarlas mejor
# Aqui hay las definiciones de cada una, las temperaturas estan multiplicadas por diez: http://worldclim.org/bioclim
names(marcoclim) <- c("BIO1","BIO2","BIO3","BIO4", "BIO5", "BIO6", "BIO7", "BIO8", "BIO9",
                 "BIO10","BIO11","BIO12","BIO13", "BIO14", "BIO15", "BIO16", "BIO17", "BIO18", "BIO19")

plot(marcoclim$BIO1)

write.csv(marcoclim, file="MarcoClim10.csv") #Guardamos los datos



