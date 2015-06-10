setwd("C:/Users/rod/SkyDrive/R/301/Week01")
#setwd("C:/Users/rodney.doe/SkyDrive/R/301/Week01")

challenger = read.csv("challenger.csv")
str(challenger)
length(challenger[,1])

par(mfcol = c(1,2))
plot(challenger$tempF, challenger$Eroded)
plot(challenger$tempF, challenger$Intact)
par(mfcol = c(1,1))

# sample with no count = scramble the original
s = sample(challenger$tempF)
s == challenger$tempF

# Obtain and record the standard regression p-value for the temperature, 
# using logistic regression with only one term: 
# a linear one for the temperature (i.e., don't put pressure into the model).
fit = glm(cbind(Eroded,Intact) ~ tempF, data=challenger, family=binomial) 
fit.coefs = coef(fit)

coef(glm(cbind(Eroded,Intact) ~ tempF, data=challenger, family=binomial))

fit.bs <- boot(challenger, 
	function(x, i) { coef(glm(cbind(x$Eroded[i],x$Intact[i]) ~ x$tempF[i], data=challenger, family=binomial))}, R=100)

cor.bs <- boot(challenger, 
	function(x, i) { cor(cbind(x$Eroded[i],x$Intact[i]), x$tempF[i]) }, R=100)
	
sim.coefs <- data.frame(Intercept = numeric(), tempF=numeric())
df.loop = data.frame(Intercept=sim.coef[1], tempF=sim.coef[2])
sim.coefs = rbind(sim.coefs, df.loop)

# Definition:  p-value
# The probability of observing more extreme data given that the null hypothesis is correct.
#
nRows = 10000
sim.coefs <- data.frame(Intercept = numeric(), tempF=numeric())

for (i in 1:nRows) {
  challenger$permT = sample(challenger$tempF) 
  fit.loop = glm( cbind(Eroded,Intact) ~ permT, data=challenger, family=binomial )
  coef.loop = coef(fit.loop)
  df.loop = data.frame(Intercept=coef.loop[1], tempF=coef.loop[2])
  sim.coefs = rbind(sim.coefs, df.loop)
}   

par(mfcol = c(1,2))
hist(sim.coefs$Intercept)
hist(sim.coefs$tempF)


alphas = c(0.025, 0.975)
quantiles.Intercept = quantile(sim.coefs$Intercept, alphas)
quantiles.tempF = quantile(sim.coefs$tempF, alphas)
quantile(sim.coefs$tempF, alphas)
min(sim.coefs$Intercept)
max(sim.coefs$Intercept)
max(sim.coefs$tempF)
min(sim.coefs$tempF)

length(which(sim.coefs$tempF < -0.17949)) 

x.b = 0:23
f.b = dbinom(x.b, 23, 17/23)
plot(x.b, f.b, main="Failure Distribution", xlab="Bernoulli", ylab="pmf", type="h")
points(x.b, f.b, pch=19)



# HW01-Q02:
# Beta prior symmetric around p=0.5, whose weight is equivalent to a+ß=6 observations
# Need a beta distribution symmetric around 0.5 with alpha + beta = 6.  So, what are alpha and beta?
# "symmetric about 0.5" may imply that they are equal...
x <- seq(0, 1, 0.01)
fx <- dbeta(x, 3, 3)  

plot(x, fx, type="l", main="Beta distribution with (a,b) = (3,3)", col="red")
abline(v=0.5)  # good guess...

PlotBetaDist <- function(alpha, beta)
{
	x <- seq(0, 1, 0.01)
	fx <- dbeta(x, alpha, beta)
	plot(x, fx, type="l", 
		main=sprintf("Beta distribution with (a,b) = (%d, %d)", alpha, beta), 
		col="red")
	abline(v=0.5)
}

# Will need to plot binomial dists.

PlotBinomDist <- function(size, p)
{
	plot(0:size, dbinom(0:size, size, p),
		xlab="Successful Trials",
		ylab="Probability", type="h",
		main=sprintf("Binomial distribution of %d trials with p success = %0.2f", size, p) )
		
		points(0:size, dbinom(0:size, size, p), pch=19, col="blue")
}


PlotBinomDist(5, 0.5); 
PlotBinomDist(25, 0.5); 
PlotBinomDist(125, 0.5); 

alpha = 3
beta = 3
# Create the prior
prior.x <- seq(0, 1, 0.01)
prior.fx <- dbeta(x, alpha, beta)

# The likelihood is the binomial dist.



# Create the posterior.  
# Posterior ~ prior * likelihood
 PlotBetaDist(3,3)
 
 # I don't understand what's going on here...
> pvec=seq(1/1001,1000/1001,1/1001) ### equally-spaced theta vector
> priorvec=dbeta(pvec,3,3)  ### prior density
> posteriorvec=priorvec*pvec^4  ### posterior ~ prior*likelihood  ## Why ^4
> posteriorvec=1000*posteriorvec/sum(posteriorvec) # Normalizing   ## Why 1000?
> plot(pvec,posteriorvec,main="4 Coin Posterior, Numerically",   ## Why 4?
+      xlab='p',ylab='Posterior Density')  
> lines(pvec,dbeta(pvec,7,3),col=2)  ## Why 7,3?



 


