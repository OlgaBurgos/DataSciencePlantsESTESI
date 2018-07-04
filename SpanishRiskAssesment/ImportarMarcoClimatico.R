
#How to extract data from WordlClim
install.packages("raster")
library("raster")
library(sp)

install.packages("dismo")
library("dismo")


#Download the WorldClim Data
worldata <- getData("worldclim",var="bio", res=10)

names(r2.5) <- c("BIO1","BIO2","BIO3","BIO4", "BIO5", "BIO6", "BIO7", "BIO8", "BIO9",
                 "BIO10","BIO11","BIO12","BIO13", "BIO14", "BIO15", "BIO16", "BIO17", "BIO18", "BIO19")

#Download the Spain boundaries
#https://www.gis-blog.com/r-raster-data-acquisition/
#The country code is obtained from: http://kirste.userpage.fu-berlin.de/diverse/doc/ISO_3166.html
spain <- getData('GADM', country='ESP', level=0)
plot(spain)
s<- crop(worldata, spain) #Pero as? obtenemos espa?a entera
plot (s$bio1)

#Recortamos con extent
e <- extent(-10,4,36,44)
s.crop <- crop(worldata, e)
plot (s.crop$bio1)

#Para sacar los valores dentro del archivo s.crop que esta en raster, usamos la funcion as.matrix del paquete raster que saca todos los valores
a<-as.matrix(s.crop) #Es una matriz de 19 variables, nos faltan las coordenadas de cada punto, aunque no son esenciales. 
plot(a[,1]) #por ejemplo los datos de la primera columna

plot(a[,1]~a[,12], pch=19, col="lightblue", xlab="Precipitaci?n Anual (mm)", ylab="Temperatura anual media (?C x10)", main="Marco clim?tico Ib?rico") #ploteamos temperatura media anual y precipitacion anual

# "a" es una matriz, lo que dificulta mucho su gesti?n, lo convierto en data.frame.
marcoclim <- as.data.frame(a)


# Mejor ponemos nombres a las variables para manejarlas mejor
# Aqu? hay las definiciones de cada una, las temperaturas estan multiplicadas por diez: http://worldclim.org/bioclim
names(marcoclim) <- c("BIO1","BIO2","BIO3","BIO4", "BIO5", "BIO6", "BIO7", "BIO8", "BIO9",
                 "BIO10","BIO11","BIO12","BIO13", "BIO14", "BIO15", "BIO16", "BIO17", "BIO18", "BIO19")

plot(marcoclim$BIO1)

write.csv(MarcoClim10, file="MarcoClim10.csv")



