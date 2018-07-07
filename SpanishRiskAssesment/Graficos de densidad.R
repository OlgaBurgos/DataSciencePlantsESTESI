marcoclim <- marcoclim[2:20]

str(marcoclim)


plot(marcoclim$BIO12 ~ marcoclim$BIO1, col = "blue")

d <- density(marcoclim$BIO1) # returns the density data 
plot(d)



library(ggplot2)
install.packages("plotly")
library(plotly)
library(MASS)

dens <- kde2d(marcoclim$BIO1, marcoclim$BIO12, n=300, lims = c(0,200,0,1400))
image(dens)
filled.contour(dens,
               color.palette=colorRampPalette(c('gray94','blue','yellow','red','darkred')),
               xlab= "Annual Mean Temperature (?C)",
               ylab= "Annual Precipitation (mm)", main = "Marco Climático Ibérico")

