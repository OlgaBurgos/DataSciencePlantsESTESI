# DataSciencePlants
Project for the course Data Science UB

En la carpeta [Spanish Risk Assesment](SpanishRiskAssesment/) hay:
- [Preguntas y hipotesis iniciales](SpanishRiskAssesment/00_PreguntasyDefiniciones)
- Así como diferentes [Rscripts](SpanishRiskAssesment/): codigos de R de la realizacion del trabajo

NEW!!! He añadido un nuevo [dataset derivado del Catalogo Español de Especies exoticas](SpanishRiskAssesment/especies_invasoras_catalogo_tcm30-70022.xls). Hay que completarlo definiendo pais o paises de origen. 

## NEXT STEPS:
He colgado un script que permite [recortar WorldClim del pais que queramos](SpanishRiskAssesment/02_CortarWorldClimPorPaises.R), teniendo en cuenta las fronteras exactas y un csv con los [codigos para recortar por cada uno de los 241 paises](SpanishRiskAssesment/CountryCodes.csv) que existen.
El siguiente paso es **proyectar los datos climaticos de un pais sobre los valores del PCA Ibérico** y **determinar como se calcula si está o no está dentro** del marco climatico. **Completar los [datos de origen](SpanishRiskAssesment/especies_invasoras_catalogo_tcm30-70022.xls) de las especies actualmente invasoras**.
#
#


Como poner formato en GitHub: https://help.github.com/articles/basic-writing-and-formatting-syntax/



marcoclim <- marcoclim[complete.cases(marcoclim),]

marcoclim <- marcoclim [3:21]

pcaclim <- prcomp(marcoclim, center = TRUE, scale. = TRUE) 
print(pcaclim)
plot(pcaclim, type = "l")
summary(pcaclim)
plot(pcaclim$x[,1],pcaclim$x[,2])

e <- pcaclim$x[,1:2]

edf <- as.data.frame(e)

edf$pais <- "Spain"


install.packages("raster")
library(raster)

install.packages("dismo")
library(dismo)

worldata <- getData("worldclim",var="bio", res=10)

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
idf$pais <- "Din"

df <- rbind(edf,idf)



library(ggplot2)
ggplot(df, aes(x=PC1, y=PC2, col=pais)) + geom_point()
