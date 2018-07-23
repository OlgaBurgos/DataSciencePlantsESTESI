##EXEMPLE 1 https://stats.stackexchange.com/questions/63447/integrating-kernel-density-estimator-in-2d 
#no estoy muy seguro de si lo podremos usar pero tiene relación con lo que dijo Erola sobre la 
#resolución de nuestro gráfico (modificando n y bandwidth)

library(MASS)     # kde2d
library(spatstat) # im class
f <- function(xy, n, x, y, ...) {
  #
  # Estimate the total where the density does not exceed that at (x,y).
  #
  # `xy` is a 2 by ... array of points.
  # `n`  specifies the numbers of rows and columns to use.
  # `x` and `y` are coordinates of "probe" points.
  # `...` is passed on to `kde2d`.
  #
  # Returns a list:
  #   image:    a raster of the kernel density
  #   integral: the estimates at the probe points.
  #   density:  the estimated densities at the probe points.
  #
  xy.kde <- kde2d(xy[1,], xy[2,], n=n, ...)
  xy.im <- im(t(xy.kde$z), xcol=xy.kde$x, yrow=xy.kde$y) # Allows interpolation $
  z <- interp.im(xy.im, x, y)                            # Densities at the probe points
  c.0 <- sum(xy.kde$z)                                   # Normalization factor $
  i <- sapply(z, function(a) sum(xy.kde$z[xy.kde$z < a])) / c.0
  return(list(image=xy.im, integral=i, density=z))
}
#
# Generate data.
#
n <- 256
set.seed(17)
xy <- matrix(c(rnorm(k <- ceiling(2*n * 0.8), mean=c(6,3), sd=c(3/2, 1)), 
               rnorm(2*n-k, mean=c(2,6), sd=1/2)), nrow=2)
#
# Example of using `f`.
#
y.probe <- 1:6
x.probe <- rep(6, length(y.probe))
lims <- c(min(xy[1,])-15, max(xy[1,])+15, min(xy[2,])-15, max(xy[2,]+15))
ex <- f(xy, 200, x.probe, y.probe, lim=lims)
ex$density; ex$integral
#
# Compare the effects of raster resolution and bandwidth.
#
res <- c(8, 40, 200, 1000)
system.time(
  est.0 <- sapply(res, 
                  function(i) f(xy, i, x.probe, y.probe, lims=lims)$integral))
est.0
system.time(
  est.1 <- sapply(res, 
                  function(i) f(xy, i, x.probe, y.probe, h=1, lims=lims)$integral))
est.1
system.time(
  est.2 <- sapply(res, 
                  function(i) f(xy, i, x.probe, y.probe, h=1/2, lims=lims)$integral))
est.2
system.time(
  est.3 <- sapply(res, 
                  function(i) f(xy, i, x.probe, y.probe, h=5, lims=lims)$integral))
est.3
results <- data.frame(Default=est.0[,4], Hp5=est.2[,4], 
                      H1=est.1[,4], H5=est.3[,4])
#
# Compare the integrals at the highest resolution.
#
par(mfrow=c(1,1))
panel <- function(x, y, ...) {
  points(x, y)
  abline(c(0,1), col="Red")
}
pairs(results, lower.panel=panel)
#
# Display two of the density estimates, the data, and the probe points.
#
par(mfrow=c(1,2))
xy.im <- f(xy, 200, x.probe, y.probe, h=0.5)$image
plot(xy.im, main="Bandwidth=1/2", col=terrain.colors(256))
points(t(xy), pch=".", col="Black")
points(x.probe, y.probe, pch=19, col="Red", cex=.5)

xy.im <- f(xy, 200, x.probe, y.probe, h=5)$image
plot(xy.im, main="Bandwidth=5", col=terrain.colors(256))
points(t(xy), pch=".", col="Black")
points(x.probe, y.probe, pch=19, col="Red", cex=.5)

##EXEMPLE 2 https://stackoverflow.com/questions/16201906/how-can-i-get-the-value-of-a-kernel-density-estimate-at-specific-points
# Me gusta el planteamiento

#If I understand what you want to do, it could be achieved by fitting a smoothing model to 
#the grid density estimate and then using that to predict the density at each point you are 
#interested in. For example:



  # Simulate some data and put in data frame DF
  n <- 100
  x <- rnorm(n)
  y <- 3 + 2* x * rexp(n) + rnorm(n)
  # add some outliers
  y[sample(1:n,20)] <- rnorm(20,20,20)
  DF <- data.frame(x,y)
  
  # Calculate 2d density over a grid
  library(MASS)
  dens <- kde2d(x,y)
  
  # create a new data frame of that 2d density grid
  # (needs checking that I haven't stuffed up the order here of z?)
  gr <- data.frame(with(dens, expand.grid(x,y)), as.vector(dens$z))
  names(gr) <- c("xgr", "ygr", "zgr")
  
  # Fit a model
  mod <- loess(zgr~xgr*ygr, data=gr)
  
  # Apply the model to the original data to estimate density at that point
  DF$pointdens <- predict(mod, newdata=data.frame(xgr=x, ygr=y))
  DF
  # Draw plot
  library(ggplot2)
  ggplot(DF, aes(x=x,y=y, color=pointdens)) + geom_point()
  
# EXEMPLE 3 https://stackoverflow.com/questions/37356825/calculate-the-volume-under-a-plot-of-kernel-bivariate-density-estimation
#Ejemplo en el que un hombre quiere encontrar la "información mutua" usando una doble integral
# para descubrir el volumen bajo la superficie. Otra persona le responde (mirar el link)
# Aun así creo que no nos acaba de servir porque compara x e y y nosotros queremos comparar país
 
   ## sample data: bivariate normal, with covariance/correlation 0
  set.seed(123); x <- rnorm(1000, 0, 2)  ## marginal variance: 4
  set.seed(456); y <- rnorm(1000, 0, 2)  ## marginal variance: 4
  
  ## load MASS
  library(MASS)
  
  ## domain:
  xlim <- range(x)
  ylim <- range(y)
  ## 2D Kernel Density Estimation
  den <- kde2d(x, y, n = 100, lims = c(xlim, ylim))
  ##persp(den$x,den$y,den$z)
  z <- den$z  ## extract density
  
  ## den$x, den$y expands a 2D grid, with den$z being density on each grid cell
  ## numerical integration is straighforward, by aggregation over all cells
  ## the size of each grid cell (a rectangular cell) is:
  cell_size <- (diff(xlim) / 100) * (diff(ylim) / 100)
  
  ## normalizing constant; ideally should be 1, but actually only close to 1 due to discretization
  norm <- sum(z) * cell_size
  
  ## your integrand: z * log(z) * (-1):
  integrand <- z * log(z) * (-1)
  
  ## get numerical integral by summation:
  entropy <- sum(integrand) * cell_size
  
  ## self-normalization:
  entropy <- entropy / norm
  
## Articulo sobre kernel y PCA, no consigo verlo entero, pero me gustaria ver la parte de metodos
  #https://www.researchgate.net/publication/223217377_The_application_of_principal_component_analysis_and_kernel_density_estimation_to_enhance_process_monitoring
  
##Calculando solapamiento en Kernel pero 1D, podria darnos una idea de como hacerlo en 2D?
  #https://stats.stackexchange.com/questions/97596/how-to-calculate-overlap-between-empirical-probability-densities 
  
## Habla de una función "PCAbipl.density" aunque no la consigo encontrar
  #https://books.google.es/books?id=66gQCi5JOKYC&pg=PA116&lpg=PA116&dq=density+of+PCA+kde2d&source=bl&ots=t9y7WApjA8&sig=LxJrPOohiyt2_C8B8hS-Z5Xej78&hl=es&sa=X&ved=0ahUKEwixt53Ag7XcAhUEIVAKHUa8C2AQ6AEITTAE#v=onepage&q=density%20of%20PCA%20kde2d&f=false
  
## Plots de densidad con isolineas de densidad, para echar un ojo 
  #https://stats.stackexchange.com/questions/31726/scatterplot-with-contour-heat-overlay

## Solapamiento de dos distribuciones 2D diferente, ejemplo
  #https://stats.stackexchange.com/questions/31726/scatterplot-with-contour-heat-overlay 
  
 
## Un paquete con una función "overlap", pero tengo que mirarlo mejor y el ejemplo se basa en 
   #interacción entre animales 
  #http://phylodiversity.net/azanne/csfar/images/e/e6/Adehabitat.pdf
   ??kerneloverlap

## Paquete SynRNASeqNet con la función parMIKD(parallel Kernel density mutual info. estimate)
  #aun así es con kernel 1D, no 2D 
  #https://cran.r-project.org/web/packages/synRNASeqNet/synRNASeqNet.pdf
  
#dar un vistazo: 

##Eliminación de puntos cuando hay alta densidad (solo si usamos plantas), ahora no interesa
#https://www.rdocumentation.org/packages/ggpmisc/versions/0.2.17/topics/stat_dens2d_filter

##http://adegenet.r-forge.r-project.org/files/practical-day3.1.1.pdf (hacer un vistazo)