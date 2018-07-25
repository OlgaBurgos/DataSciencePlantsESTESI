#   R code for:
#   What's the optimal sample size in ecophysioogy? A case study using a comon functinal trait
#   New Phytologist
#
#   Marina Pérez-Llorca (1), Erola Fenollosa (1), Roberto Salguero-Gómez (2,3), Sergi Munné-Bosch * (1)
#
#   1 
#   2 
#   3 
#
#   *Correspondance: smunne@ub.edu
#
#   This file was produced by:
#   Marina Pérez-Llorca and Erola Fenollosa 
#   www.antiox-ecophys.com
#
######################################################################
#
#    The R code below was tested on R version 3.5.0
#    May 2018



#Data is imported, our variable is called RWC2014
cistus <- read.table(file = "C:/Cistus/data.txt", header = TRUE, dec = ".")


##############################Figure 1########################################

#1. Resampling for representativeness_____________________________________________________________ 
#1.1. Resampling function.Number of interations=1000 

V<- c(cistus$RWC2014)
x<- length(V)
z <- matrix(ncol=x, nrow=1000) #the mean of the resampled values is stored in z
for (i in 1:x) {
  for(j in 1:1000){
    sub <- sample (V, i, replace = FALSE)
    z[j,i]<- mean (sub)
  }}

#1.2. Calculate the absolute mean difference, min and max between each n and n=328 

MeanPop<- z[1000,328]
Dz <- abs (((z-MeanPop)*100)/MeanPop)

meandif <- matrix(ncol=1, nrow=328)
for (i in 1:328) { 
  meandif[i]<- mean(Dz[,i]) }

mindif <- matrix(ncol=1, nrow=328)
for (i in 1:328) { 
  mindif[i]<- min(Dz[,i])}

maxdif <- matrix(ncol=1, nrow=328)
for (i in 1:328) { 
  maxdif[i]<- max(Dz[,i])}

#1.3. Visualisation

y<- max(maxdif)+1

plot((meandif), lty= 1, pch= 19, cex=0.5, type="b", xlab="Sampling size (n)", ylab ="Percentual Mean difference", xlim=c(0.0,330.0), ylim=c(0.0,y))
par(new=T)
plot((maxdif), col="darkgrey", lty= 1, type="l", xlab="Sampling size (n)", ylab ="Percentual Mean difference", xlim=c(0.0,330.0), ylim=c(0.0,y))
par(new=T)
plot((mindif), col="darkgrey", lty= 1, type="l", xlab="Sampling size (n)", ylab ="Percentual Mean difference", xlim=c(0.0,330.0), ylim=c(0.0,y), 
     main="RWC 2014")
legend("topright",inset=.01, legend=c("Min and Max", "Mean"),
       col=c("grey", "black"), fill= c("grey", "black"), cex=1)
par(new=F)

#2. Confidence level estimation_____________________________________________________________
# T-Test comparing N=i randomly chosen and i samples obtained from a normal distribution of the 328 samples.
# 10000 iterations are used

V<- c(cistus$RWC2014)
Psig <- matrix(ncol=328, nrow=1000) #We store in Psig the significance of the comparation between samples

#It is going to take a while...27' aproximately
for (i in 2:328) {
  for(j in 1:1000){
    Vnorm<- rnorm(i, mean=mean(V), sd=sd(V))
    S <- sample (V, i, replace = FALSE)
    t1<- t.test(Vnorm, S)
    p1<-t1$p.value
    S<-if(p1){p1<0.05}
    Psig[j,i]<- S
  }}

ProbPsig <- matrix(ncol=1, nrow=328)
for (i in 1:328) { 
  ProbPsig[i]<- ((sum(Psig[,i])*100)/1000)
}

plot((ProbPsig), lty= 1, pch= 19, cex=0.5, type="b", xlab="Sampling size (n)", ylab ="Psig (%)", main = "Probability of finding significant differences")
#the confidence level would be obtained using the opposite values. 1% would mean a 99% of confidence level.

#Searching for the n value that corresponds to 95% of confidence level (i.e. 5% Psig). We adjusted a linear regression around the disered interval
#Consider deleting the lowest n values to avoid to bias

ProbPsig1st <- ProbPsig [5:105]
N1 <- c(5:105) #N1 corresponds to the approximate linear interval we expect to find the n corresponding to Psig=5, according to the previous graph
LinearFit<- lm(ProbPsig1st~N1)
summary(LinearFit)

plot((ProbPsig), lty= 1, pch= 19, cex=0.5, type="b", xlab="Sampling size (n)", ylab ="Psig (%)", main = "Probability of finding significant differences")
abline(LinearFit)
text(x=200, y = 8, labels="Psig = 4.8871690 - 0.0157511*n")

N95 <- (4.8871690-5)/0.0157511 #x and y parameters from the linear model
N95

#Searching for the n value that corresponds to 99% of confidence level (i.e. 1% Psig). We adjusted a linear regression around the disered interval

ProbPsig2nd <- ProbPsig [200:300]
N2 <- c(200:300)
LinearFit2<- lm(ProbPsig2nd~N2)
summary(LinearFit2)

plot((ProbPsig), lty= 1, pch= 19, cex=0.5, type="b", xlab="Sampling size (n)", ylab ="Psig (%)", main = "Probability of finding significant differences")
abline(LinearFit2)
text(x=260, y = 4.5, labels="Psig = 4.0596331 -0.0110001*n")

N99 <- (4.0596331-1)/0.0110001 #x and y parameters from te linear model
N99

#Plot them together
plot((ProbPsig), lty= 1, pch= 19, cex=0.5, type="b", xlab="Sampling size (n)", ylab ="Psig (%)", main = "Probability of finding significant differences")
abline(LinearFit)
abline(LinearFit2)
text(x=125, y = 4.5, labels="Psig = 4.8871690 - 0.0157511*n")
text(x=260, y = 2.3, labels="Psig = 4.0596331 -0.0110001*n")

##############################Figure 2########################################
# Effect of sampling size to the contrast of two analoge populations (real and simulated) with different mean values. 
V <- c(cistus$RWC2014)

# As the mean value of the real population is 65.5 we decided to contrast it with populations with mean of:
# 60, 55, 50, 45, 40, 35 ... 10.

Nd60 <- matrix(ncol=328, nrow=1000) #Create a matrix to store for each n (from 2 to 328), 1000 test of significance between the real population and a simulated population.
for (i in 2:328) {
  for(j in 1:1000){
    Vn <- rnorm (i, mean=mean(V), sd=sd(V)) 
    S <- rnorm (i, mean=60, sd=sd(Vn))
    test <- t.test(Vn, S) 
    p <- test$p.value
    Sig <- if(p){p<0.05} 
    Nd60[j,i]<- Sig
  }}
Nd55 <- matrix(ncol=328, nrow=1000)
for (i in 2:328) {
  for(j in 1:1000){
    Vn <- rnorm (i, mean=mean(V), sd=sd(V)) 
    S <- rnorm (i, mean=55, sd=sd(Vn))
    test <- t.test(Vn, S) 
    p <- test$p.value
    Sig <- if(p){p<0.05} 
    Nd55[j,i]<- Sig
  }}
Nd50 <- matrix(ncol=328, nrow=1000)
for (i in 2:328) {
  for(j in 1:1000){
    Vn <- rnorm (i, mean=mean(V), sd=sd(V)) 
    S <- rnorm (i, mean=50, sd=sd(Vn))
    test <- t.test(Vn, S) 
    p <- test$p.value
    Sig <- if(p){p<0.05} 
    Nd50[j,i]<- Sig
  }}
Nd45 <- matrix(ncol=328, nrow=1000)
for (i in 2:328) {
  for(j in 1:1000){
    Vn <- rnorm (i, mean=mean(V), sd=sd(V)) 
    S <- rnorm (i, mean=45, sd=sd(Vn))
    test <- t.test(Vn, S) 
    p <- test$p.value
    Sig <- if(p){p<0.05} 
    Nd45[j,i]<- Sig
  }}
Nd40 <- matrix(ncol=328, nrow=1000)
for (i in 2:328) {
  for(j in 1:1000){
    Vn <- rnorm (i, mean=mean(V), sd=sd(V)) 
    S <- rnorm (i, mean=40, sd=sd(Vn))
    test <- t.test(Vn, S) 
    p <- test$p.value
    Sig <- if(p){p<0.05} 
    Nd40[j,i]<- Sig
  }}
Nd35 <- matrix(ncol=328, nrow=1000)
for (i in 2:328) {
  for(j in 1:1000){
    Vn <- rnorm (i, mean=mean(V), sd=sd(V)) 
    S <- rnorm (i, mean=35, sd=sd(Vn))
    test <- t.test(Vn, S) 
    p <- test$p.value
    Sig <- if(p){p<0.05} 
    Nd35[j,i]<- Sig
  }}
Nd30 <- matrix(ncol=328, nrow=1000)
for (i in 2:328) {
  for(j in 1:1000){
    Vn <- rnorm (i, mean=mean(V), sd=sd(V)) 
    S <- rnorm (i, mean=30, sd=sd(Vn))
    test <- t.test(Vn, S) 
    p <- test$p.value
    Sig <- if(p){p<0.05} 
    Nd30[j,i]<- Sig
  }}
Nd25 <- matrix(ncol=328, nrow=1000)
for (i in 2:328) {
  for(j in 1:1000){
    Vn <- rnorm (i, mean=mean(V), sd=sd(V)) 
    S <- rnorm (i, mean=25, sd=sd(Vn))
    test <- t.test(Vn, S) 
    p <- test$p.value
    Sig <- if(p){p<0.05} 
    Nd25[j,i]<- Sig
  }}
Nd20 <- matrix(ncol=328, nrow=1000)
for (i in 2:328) {
  for(j in 1:1000){
    Vn <- rnorm (i, mean=mean(V), sd=sd(V)) 
    S <- rnorm (i, mean=20, sd=sd(Vn))
    test <- t.test(Vn, S) 
    p <- test$p.value
    Sig <- if(p){p<0.05} 
    Nd20[j,i]<- Sig
  }}
Nd15 <- matrix(ncol=328, nrow=1000)
for (i in 2:328) {
  for(j in 1:1000){
    Vn <- rnorm (i, mean=mean(V), sd=sd(V)) 
    S <- rnorm (i, mean=15, sd=sd(Vn))
    test <- t.test(Vn, S) 
    p <- test$p.value
    Sig <- if(p){p<0.05} 
    Nd15[j,i]<- Sig
  }}
Nd10 <- matrix(ncol=328, nrow=1000)
for (i in 2:328) {
  for(j in 1:1000){
    Vn <- rnorm (i, mean=mean(V), sd=sd(V)) 
    S <- rnorm (i, mean=10, sd=sd(Vn))
    test <- t.test(Vn, S) 
    p <- test$p.value
    Sig <- if(p){p<0.05} 
    Nd10[j,i]<- Sig
  }}

#For each mean contrast, calculate the probability of being significant at each n.
NdGl60 <- matrix(ncol=1, nrow=328)
for (i in 1:328) {NdGl60[i]<- ((sum(Nd60[,i])*100)/1000)}
NdGl55 <- matrix(ncol=1, nrow=328)
for (i in 1:328) {NdGl55[i]<- ((sum(Nd55[,i])*100)/1000)}
NdGl50 <- matrix(ncol=1, nrow=328)
for (i in 1:328) {NdGl50[i]<- ((sum(Nd50[,i])*100)/1000)}
NdGl45 <- matrix(ncol=1, nrow=328)
for (i in 1:328) {NdGl45[i]<- ((sum(Nd45[,i])*100)/1000)}
NdGl40 <- matrix(ncol=1, nrow=328)
for (i in 1:328) {NdGl40[i]<- ((sum(Nd40[,i])*100)/1000)}
NdGl35 <- matrix(ncol=1, nrow=328)
for (i in 1:328) {NdGl35[i]<- ((sum(Nd35[,i])*100)/1000)}
NdGl30 <- matrix(ncol=1, nrow=328)
for (i in 1:328) {NdGl30[i]<- ((sum(Nd30[,i])*100)/1000)}
NdGl25 <- matrix(ncol=1, nrow=328)
for (i in 1:328) {NdGl25[i]<- ((sum(Nd25[,i])*100)/1000)}
NdGl20 <- matrix(ncol=1, nrow=328)
for (i in 1:328) {NdGl20[i]<- ((sum(Nd20[,i])*100)/1000)}
NdGl15 <- matrix(ncol=1, nrow=328)
for (i in 1:328) {NdGl15[i]<- ((sum(Nd15[,i])*100)/1000)}
NdGl10 <- matrix(ncol=1, nrow=328)
for (i in 1:328) {NdGl10[i]<- ((sum(Nd10[,i])*100)/1000)}

# Select the first N to have 100% Prob in each NdGl:
NdGl60sel<- which.max(NdGl60 == 100)
NdGl55sel<- which.max(NdGl55 == 100)
NdGl50sel<- which.max(NdGl50 == 100)
NdGl45sel<- which.max(NdGl45 == 100)
NdGl40sel<- which.max(NdGl40 == 100)
NdGl35sel<- which.max(NdGl35 == 100)
NdGl30sel<- which.max(NdGl30 == 100)
NdGl25sel<- which.max(NdGl25 == 100)
NdGl20sel<- which.max(NdGl20 == 100)
NdGl15sel<- which.max(NdGl15 == 100)
NdGl10sel<- which.max(NdGl10 == 100)

Nds <- c(NdGl60sel, 
                  NdGl55sel, NdGl50sel, NdGl45sel, NdGl40sel, NdGl35sel, NdGl30sel, 
                  NdGl25sel, NdGl20sel, NdGl15sel, NdGl10sel)

MeanB <- c(60,55,50,45,40,35,30,25,20,15,10)

plot(Nds ~ MeanB, col="black", lty= 1, pch= 19, cex=0.8, type="b", xlab="RWC of the B population (%)", ylab ="N to detect differences between A and B", main = "Statistical power")
text(x=30, y = 140, labels="Population A RWC = 65.55%")


##############################The end########################################
