## Como extraer los datos de WorldClim para las coordenadas seleccionadas.

#Cargamos los datos del GBIF, que incluyen las coordenadas
library(readr)
gbif <- read_delim("0022664-180508205500799.csv", 
                   "\t", escape_double = FALSE, trim_ws = TRUE)
View(gbif)

cord <- data.frame (lon = gbif$decimallongitude, lat=gbif$decimallatitude) #Df con solo las coordenadas

install.packages("dismo")
library ("dismo")
library(raster)
library(sp)

r2.5 <- getData("worldclim",var="bio",res=2.5)
names(r2.5) <- c("BIO1","BIO2","BIO3","BIO4", "BIO5", "BIO6", "BIO7", "BIO8", "BIO9",
                 "BIO10","BIO11","BIO12","BIO13", "BIO14", "BIO15", "BIO16", "BIO17", "BIO18", "BIO19")

#Nota: las variables de temperatura estan multiplicadas por 10

plot(r2.5$BIO1, main="Mean Annual temperature") #graficos bonitos del mundo con las variables bioclimaticas


points <- SpatialPoints(cord, proj4string = r2.5@crs)
values <- extract(r2.5,points)
df <- cbind.data.frame(coordinates(points),values) #df con las coordenadas y sus valores de las variables bioclimaticas

View(df)
summary(df) #Hay muchos NA, hay que explorar porque. 

