# COUNTRY LOOPING
# DEFINE THE STATIC ENVIRONMENT

list.of.packages <- c("dismo", "ggplot2", "MASS", "hypervolume", "alphahull")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)

library(dismo)
library(ggplot2)
library(MASS)
library(hypervolume)
library (alphahull)

worldata <- getData("worldclim",var="bio", res=10)
e <- extent(-10,4,36,44)
s.crop <- crop(worldata, e)
a<-as.matrix(s.crop)
marcoclim <- as.data.frame(a)

BIOs <- paste('BIO', (1:19), sep = '')
names(marcoclim) <- BIOs

marcoclim <- marcoclim[complete.cases(marcoclim),]
pcaclim <- prcomp(marcoclim, center = TRUE, scale. = TRUE) 
e <- pcaclim$x[,1:2]
edf <- as.data.frame(e)
edf$pais <- "Spain"

hv1sp = hypervolume_gaussian(data=edf[1:nrow(edf), 1:2])
plot(hv1sp)

CountryCodesSum <- read.csv("C:/Users/Gian/GitHub_Projects/DataSciencePlantsESTESI/SumCountryCodes.csv", header=FALSE, sep=";", skip = 1)

my_df <- data.frame()

counter=1

for(ID_cntry in CountryCodesSum$V2) {
  print(ID_cntry)

# DINAMIC ENVIRONMENT
countrybound <- getData('GADM', country=ID_cntry, level=0) #COUNTRY CODE!!!!
s<- crop(worldata, countrybound)
s2 <- mask(s, countrybound)
marcoclim.country <- as.data.frame(s2)

names(marcoclim.country) <- BIOs

marcoclim.country <- marcoclim.country[complete.cases(marcoclim.country),]
i <- predict (pcaclim, newdata = marcoclim.country) 
i <- i[,1:2]
idf <- as.data.frame(i)
ID_label <- paste("Spain vs.", ID_cntry, sep=' ')
idf$pais <- ID_label
df <- rbind(edf,idf)

hv2dn = hypervolume_gaussian(data = subset(df,pais == ID_label)[1:nrow(idf), 1:2]) 
setH <-hypervolume_set(hv1sp, hv2dn, check.memory = FALSE) #Genereamos valores estadÃ?sticos
volumes<-get_volume(setH)
overl<- hypervolume_overlap_statistics(setH)
dist<- hypervolume_distance(hv1sp, hv2dn, type='centroid')

#OUTPUTS:
#ggplot(df, aes(x=PC1, y=PC2, col=pais)) + geom_point()
values <- c(volumes, overl, dist)
#plot(hv2dn)

my_df <- rbind(my_df, values)
my_df[counter, "Country"] <- ID_cntry

counter = counter + 1

print(my_df)

}

rm(counter)


