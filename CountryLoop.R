# COUNTRY LOOPING
# DEFINE THE STATIC ENVIRONMENT
install.packages("dismo")
library(dismo)

install.packages("ggplot2")
library(ggplot2)

install.packages("MASS")
library(MASS)

install.packages("hypervolume")
library(hypervolume)

install.packages("alphahull")
library (alphahull)

worldata <- getData("worldclim",var="bio", res=10)
e <- extent(-10,4,36,44)
s.crop <- crop(worldata, e)
a<-as.matrix(s.crop)
marcoclim <- as.data.frame(a)
names(marcoclim) <- c("BIO1", "BIO2", "BIO3", "BIO4", "BIO5", "BIO6", "BIO7", "BIO8", "BIO9",
                      "BIO10", "BIO11", "BIO12", "BIO13", "BIO14", "BIO15", "BIO16", "BIO17", "BIO18", "BIO19")
marcoclim <- marcoclim[complete.cases(marcoclim),]
pcaclim <- prcomp(marcoclim, center = TRUE, scale. = TRUE) 
e <- pcaclim$x[,1:2]
edf <- as.data.frame(e)
edf$pais <- "Spain"

hv1sp = hypervolume_gaussian(data=subset(df,pais=="Spain")[1:2730, 1:2])
plot(hv1sp)

# DINAMIC ENVIRONMENT
countrybound <- getData('GADM', country='DNK', level=0) #COUNTRY CODE!!!!
s<- crop(worldata, countrybound)
s2 <- mask(s, countrybound)
s2<-as.matrix(s2)
marcoclim.country <- as.data.frame(s2)
names(marcoclim.country) <- c("BIO1","BIO2","BIO3","BIO4", "BIO5", "BIO6", "BIO7", "BIO8", "BIO9",
                              "BIO10","BIO11","BIO12","BIO13", "BIO14", "BIO15", "BIO16", "BIO17", "BIO18", "BIO19")
marcoclim.country <- marcoclim.country[complete.cases(marcoclim.country),]
i <- predict (pcaclim, newdata = marcoclim.country) 
i <- i[,1:2]
idf <- as.data.frame(i) 
idf$pais <- "Compare"
df <- rbind(edf,idf)

hv2dn = hypervolume_gaussian(data=subset(df,pais=="Din")[1:238, 1:2]) 
setH <-hypervolume_set(hv1sp, hv2dn, check.memory = FALSE) #Genereamos valores estadÃ?sticos
volumes<-get_volume(setH)
overl<- hypervolume_overlap_statistics(setH)
dist<- hypervolume_distance(hv1sp, hv2dn, type='centroid')

#OUTPUTS:
ggplot(df, aes(x=PC1, y=PC2, col=pais)) + geom_point()
values <- c(volumes, overl, dist)
plot(hv2dn)



