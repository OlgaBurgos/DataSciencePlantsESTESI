marcoclim<- MarcoClim2_5[complete.cases(MarcoClim2_5), ]

# El de 2.5 se queda con 41.573 observaciones

#Quitamos la primera columna que no sirve para nada
marcoclim <- marcoclim[2:20]


library("ggplot2")
install.packages("factoextra")
library(factoextra)
# HACER PCA:
pcaclim <- prcomp(marcoclim, center = TRUE, scale. = TRUE) 
print(pcaclim)
plot(pcaclim, type = "l")
summary(pcaclim)
pcaclim$rotation[,1]
pcaclim$rotation[,2]
pcaclim$rotation[,3]
plot(pcaclim$x[,1],pcaclim$x[,2])


fviz_pca_var(pcaclim,
             col.var = "contrib", # Color by contributions to the PC
             gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),
             repel = TRUE     # Avoid text overlapping
)  ##Función para ver la contribución de cada variable en esta PCA

## Manera de representar la PCA extraído de https://tgmstat.wordpress.com/2013/11/28/computing-and-visualizing-pca-in-r/
library(devtools)
install_github("ggbiplot", "vqv")

library(ggbiplot)
?ggbiplot
g <- ggbiplot(pcaclim, obs.scale = 1, var.scale = 1, 
               ellipse = TRUE, alpha=0.1, 
              circle = TRUE)
g <- g + scale_color_discrete(name = '')
g <- g + theme(legend.direction = 'horizontal', 
               legend.position = 'top')
print(g)

##Aquí PCA con con las variables de VIF<5 
marcoclimVIF <- marcoclim[,c(2,3,8,9,13,15)]

pcaclim2 <- prcomp(marcoclimVIF, center = TRUE, scale. = TRUE) 
print(pcaclim2)
plot(pcaclim2, type = "l")
summary(pcaclim2)
plot(pcaclim2$x[,1],pcaclim2$x[,2])
