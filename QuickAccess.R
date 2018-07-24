install.packages("dismo")
library(dismo)

install.packages("ggplot2")
library(ggplot2)

install.packages("MASS")
library(MASS)

#Download the WorldClim Data
worldata <- getData("worldclim",var="bio", res=10)

e <- extent(-10,4,36,44) #definimos el marco
s.crop <- crop(worldata, e)

a<-as.matrix(s.crop) #Es una matriz de 19 variables, nos faltan las coordenadas de cada punto, aunque no son esenciales. 
marcoclim <- as.data.frame(a)
names(marcoclim) <- c("BIO1", "BIO2", "BIO3", "BIO4", "BIO5", "BIO6", "BIO7", "BIO8", "BIO9",
                      "BIO10", "BIO11", "BIO12", "BIO13", "BIO14", "BIO15", "BIO16", "BIO17", "BIO18", "BIO19")

marcoclim <- marcoclim[complete.cases(marcoclim),]

pcaclim <- prcomp(marcoclim, center = TRUE, scale. = TRUE) 
print(pcaclim)
plot(pcaclim, type = "l")
summary(pcaclim)
plot(pcaclim$x[,1],pcaclim$x[,2], col = "lightblue")

e <- pcaclim$x[,1:2]
edf <- as.data.frame(e)
edf$pais <- "Spain" #A?adimos una varaible de Pais, con todas las etiquetes "Spain"

denmark <- getData('GADM', country='DNK', level=0)
plot(denmark)
s<- crop(worldata, denmark)
s2 <- mask(s, denmark)
s2<-as.matrix(s2)
marcoclim.denmark <- as.data.frame(s2)
names(marcoclim.denmark) <- c("BIO1","BIO2","BIO3","BIO4", "BIO5", "BIO6", "BIO7", "BIO8", "BIO9",
                              "BIO10","BIO11","BIO12","BIO13", "BIO14", "BIO15", "BIO16", "BIO17", "BIO18", "BIO19")

marcoclim.denmark <- marcoclim.denmark[complete.cases(marcoclim.denmark),]

i <- predict (pcaclim, newdata = marcoclim.denmark) 
i <- i[,1:2]

idf <- as.data.frame(i) 
idf$pais <- "Din" #Generamos la variable pais, con el nombre de la etiqueta del mismo.

df <- rbind(edf,idf) #Combinamos los dos data frames, con los datos de PC1 y 2 de espa?a y el pais seleccionado

ggplot(df, aes(x=PC1, y=PC2, col=pais)) + geom_point()

#ESPAÑA
dense <- kde2d(edf$PC1, edf$PC2, n=1000, lims = c(-12,7,-10,10))
image(dense)
filled.contour(dense,
               color.palette=colorRampPalette(c('gray94','blue','yellow','red','darkred')),
               xlab= "PC1",
               ylab= "PC2", main = "Marco clim?tico Ib?rico")

#AHORA SOLO EL PAIS PROYECTADO:
densi <- kde2d(idf$PC1, idf$PC2, n=1000, lims = c(-12,7,-10,10))
image(densi)
filled.contour(densi,
               color.palette=colorRampPalette(c('gray94','blue','yellow','red','darkred')),
               xlab= "PC1",
               ylab= "PC2", main = "Marco clim?tico Ib?rico del pais proyectado")


d<-as.data.frame(densi$x)
d$y<- densi$y

plot(densi$x~d$y)



head(densi$y)
head(dense$y)
#Les y i les x son les mateixos per a les dues densitats amb els mateixos limits


#PRUEBA
densipeq <- kde2d(idf$PC1, idf$PC2, n=100, lims = c(-12,7,-10,10))

ab<-(densipeq$z)


