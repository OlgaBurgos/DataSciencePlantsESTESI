#Con todos los datos
pcaclim <- prcomp(marcoclim, center = TRUE, scale. = TRUE) 
print(pcaclim)
plot(pcaclim, type = "l")
summary(pcaclim)
plot(pcaclim$x[,1],pcaclim$x[,2])



#solo con las variables que VIF < 5

marcoclimVIF <- marcoclim[,c(2,3,8,9,13,15)]

pcaclim2 <- prcomp(marcoclimVIF, center = TRUE, scale. = TRUE) 
print(pcaclim2)
plot(pcaclim2, type = "l")
summary(pcaclim2)

plot(pcaclim2$x[,1],pcaclim2$x[,2])
