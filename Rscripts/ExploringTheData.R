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


install.packages("factoextra")
library("factoextra")

plot(pcabIO$x[,1],pcabIO$x[,2], col=Data$genus)

fviz_pca_ind(pcabIO,
             geom.ind = "point", # show points only (nbut not "text")
             col.ind = Data$genus, # color by groups
             palette = "Spectral",
             addEllipses = TRUE, # Concentration ellipses
             legend.title = "Groups")




#http://www.sthda.com/english/articles/31-principal-component-methods-in-r-practical-guide/112-pca-principal-component-analysis-essentials/


