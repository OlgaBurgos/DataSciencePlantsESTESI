#hypervolume

install.packages("hypervolume")
library(hypervolume)

#creamos los hipervolúmenes, uno con Spain y el segundo con Denmark

hv1sp = hypervolume_gaussian(data=subset(df,pais=="Spain")[1:2730, 1:2])
hv2dn = hypervolume_gaussian(data=subset(df,pais=="Din")[1:238, 1:2]) 

setH <-hypervolume_set(hv1sp, hv2dn, check.memory = FALSE) #Genereamos valores estadísticos
(volumes<-get_volume(setH))

# nos devolverá una lista con los volúmenes de interés siguientes:
# 1. hv1sp; 2. hv2dn; 3. Intersección; 4. Unión

(overl<- hypervolume_overlap_statistics(setH)) #printa directamente índices de similitus entre los dos volúmenes
#jaccard Jaccard similarity (volume of intersection of 1 and 2 divided by volume of union
#of 1 and 2)
#sorensen Sorensen similarity (twice the volume of intersection of 1 and 2 divided by volume
#of 1 plus volume of 2)
#frac_unique_1 Unique fraction 1 (volume of unique component of 1 divided by volume of 1))
#frac_unique_2 Unique fraction 2 (volume of unique component of 2 divided by volume of 2))

(dist<- hypervolume_distance(hv1sp, hv2dn, type='centroid')) #distancia entre centroides 


#Vector que recoja los resultados de estos análisis para Dinamarca, así cuando tengamos otro país podremos comparar las tablas directamente

dinamarca <- c(volumes, overl, dist)
dinamarca

#Probaremos con otro país, con mayor similitud de clima con España, por ejemplo, Portugal

#necesitamos cargar los datos de portugal, PCA y de nuevo crear un hypervolumen, 


#Otras opciones para probar los hiperolumenes, porque dudamos de si está teniendo en cuenta la densidad como variable (z)
#1. probar a crear hypervolumenes con datos dense (españa), densi(dinamarca) que si tienen 3 dimensiones (están en la carpeta Datos)
#2. probar a la manera antigua(sin paquete Hypervolume), con x, y, z comparando cuánto coinciden entre ambos grupos (España y Dinamarca, también con dense y densi)



