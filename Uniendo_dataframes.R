#Primero pondremos el mismo nombre a las variables de longitud y latitud

library(plyr)
names(gbif2)
names(df2) #usamos df y luego ya limpiamos de NA's para que en el mergin coincidan 
gbif3<- rename(gbif2,c('decimallatitude'='lat', 'decimallongitude'='lon'))
View(gbif3)

merge(gbif3,df,by="lat")# "Error= cannot allocate vector of size 80.6 Mb". No sé si es mi ordenador o que no se pueden unir
#INTENTARÉ EXTRAER LOS dos csv y modificarlo directamente ahí! 

read.csv("TODO.csv") #He unido las dos bases de datos, la de gbif ya un poco modificada. 
View(TODO)
library(DataExplorer)
plot_missing(TODO)
TODO2 <- na.omit(TODO)
View(TODO2)
dim.data.frame(TODO)
dim.data.frame(TODO2)
##Si eliminamos directament los missing values, perdemos demasiada información.
