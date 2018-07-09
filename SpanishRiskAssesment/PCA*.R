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
plot(pcaclim$x[,1],pcaclim$x[,13])
text(pcaclim$x[,3],pcaclim$x[,13], col="blue")

fviz_pca_var(pcaclim,
             col.var = "contrib", # Color by contributions to the PC
             gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),
             repel = TRUE     # Avoid text overlapping
)

marcoclimVIF <- marcoclim[,c(2,3,8,9,13,15)]

pcaclim2 <- prcomp(marcoclimVIF, center = TRUE, scale. = TRUE) 
print(pcaclim2)
plot(pcaclim2, type = "l")
summary(pcaclim2)
plot(pcaclim2$x[,1],pcaclim2$x[,2])
