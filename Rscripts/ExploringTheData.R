#Explorando la base de datos
#Los datos con las coordenadas y las variables bioclimaticas estan guardados en la misma carpeta (TODO.csv). 
# Solo hay que establecer la carpeta como working directory y cargarlos directamente. 
# Los datos salen del Script "ExtractWordClim2"

setwd("~/DataSciencePlantsESTESI")
TODO <- read_delim("TODO.csv", ";", escape_double = FALSE, 
                   +     trim_ws = TRUE)

Data <- TODO[complete.cases(TODO),]



install.packages("ggplot2")
library(ggplot2)  

TODO$genus <- as.factor(TODO$genus)

ggplot(TODO, aes(x=TODO$BIO1, fill=TODO$genus)) + geom_density(alpha=.3)



# PCA
standardisedbios <-as.data.frame(scale (Data[15:33]))

pcabIO <- prcomp(standardisedbios)
summary(pcabIO)
pcabIO$sdev
screeplot(pcabIO, type="lines")

plot(pcabIO$x[,1],pcabIO$x[,2])
text(pcabIO$x[,1],pcabIO$x[,2], Data$genus, cex=0.7, pos=4, col="red")


plot(pcabIO$x[,1],pcabIO$x[,2], col=Data$genus)



