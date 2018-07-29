
library(dplyr)
Volumes <- my_df_Gian
Volumes[,1] = NULL 
Vol.Names <- c('Vol.MCI', 'Vol.Country', 'Vol.Intersection', 'Vol.Union', 'Vol.Unique.MCI', 'Vol.Unique.Country', 'Jaccart', 'Sorensen', 'NormVol.MCI', 'NormVol.Country', 'Dist.Centroid', 'A3')
names(Volumes) <- Vol.Names


ord<- arrange(Volumes, desc(Vol.Intersection))
head(ord[,12])

ord<- arrange(Volumes, desc(Vol.Union))
head(ord[,12])

ord<- arrange(Volumes, desc(Jaccart))
head(ord[,12])

ord<- arrange(Volumes, desc(Sorensen))
head(ord[,12])

ord<- arrange(Volumes, desc(Dist.Centroid))
head(ord[,12])

ord<- arrange(Volumes, Dist.Centroid)
head(ord[,12])




complete<- merge(Volumes, CountryDataSum, by = "A3")

plot(complete$Dist.Centroid~ complete$distance.km, col = "black", pch=19)

plot(complete$Vol.Country~ complete$NBI, col = "black", pch=19)


library(ggplot2)
ggplot(complete, aes(Vol.Country, NBI))



library(readxl)
origeninvasoras <- read_excel("C:/Users/Erola/Downloads/origeninvasorasSum.xlsx")
countriesorigen <-origeninvasoras[,7:56]
b<-as.matrix(countriesorigen)
a<-as.vector(b)

#Para comprobar nombres de paises
sort(unique(a))

a.t<-table(a)

a.df <- as.data.frame(a.t)
df <- mutate_all(a.df, funs(toupper))
names(df) <- c("Country", "NumSpecies")

withsp<-merge(df, complete, by="Country", all.y = TRUE)



plot(withsp$NumSpecies ~ withsp$Dist.Centroid, col = "black", pch=19)

plot(withsp$NumSpecies ~ withsp$Jaccart, col = "black", pch=19)



write.csv(withsp, "withsp.csv")

