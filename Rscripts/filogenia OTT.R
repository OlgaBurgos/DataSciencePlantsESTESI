#Empezando a trabajar con Open Tree 
install.packages("rotl")
library(rotl)
#podemos combinar algunos datos de nuestro datasets en un contexto filogenético.
#Primero debemos encontrar el código de nuestra especie de interés y el de las demás especies del dataset que queramos añadir o evaluar.

taxonomy_about()
taxonomy_subtree(ott_id =973287) #este es el codigo de Carpobrotus

#probando con dos especies...
taxa <- c("Carpobrotus edulis", "Carpobrotus chilensis")
taxa
resolved_names <- tnrs_match_names(taxa)
View(resolved_names)




#para crear arbol: https://cran.r-project.org/web/packages/rotl/vignettes/how-to-use-rotl.html
my_tree <- tol_induced_subtree(ott_ids = resolved_names$ott_id)
plot(my_tree, no.margin=TRUE)  
