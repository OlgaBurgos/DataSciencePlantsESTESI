#Empezando a trabajar con Open Tree 
install.packages("rotl")
library(rotl)
#podemos combinar algunos datos de nuestro datasets en un contexto filogenético.
#un enfoque comparativo filogenético para dar cuenta de la historia evolutiva compartida entre algunas de las especies estudiadas.
#Primero debemos encontrar el código de nuestra especie de interés y el de las demás especies del dataset que queramos añadir o evaluar.

taxonomy_about()
taxonomy_subtree(ott_id =973287) #este es el codigo de Carpobrotus
#Hay que crear un vector con las especies que queremos presentar en el arbol, a partir del data set de la familia Aizoaceae, 
#cogemos columna con el nombre cientifico y convertimos en vector(c),y comprobamos que tengan el mismo nombre que en OTT
#Todas estas especies están en OTT, pero algunas de ellas tienen nombres diferentes en el árbol abierto que los que tenemos en nuestro conjunto de datos. 
#Debido a que las recuperaciones del árbol rotl tendrán nombres de Open Tree, necesitamos crear un vector nombrado que mapee los nombres que tenemos para cada especie con los nombres que Open Tree usa para ellos:

taxon_map <- structure(taxa$search_string, names=taxa$unique_name)
#Ahora podemos usar este mapa para recuperar "nombres de conjuntos de datos" de "nombres OTT":
  
taxon_map["Carpobrotus edulis"]




#probando con dos especies...
taxa <- c("Carpobrotus edulis", "Carpobrotus chilensis")
taxa
resolved_names <- tnrs_match_names(taxa)
View(resolved_names)




#para crear arbol: https://cran.r-project.org/web/packages/rotl/vignettes/how-to-use-rotl.html
my_tree <- tol_induced_subtree(ott_ids = resolved_names$ott_id)
plot(my_tree, no.margin=TRUE)  

#ootra forma: 
tr <- tol_induced_subtree(ott_id(taxa)[is_in_tree(ott_id(taxa))])
plot(tr, show.tip.label=FALSE)


#poner etiquetas
tr$tip.label[1:20] #el numero de especies que hemos cargado

