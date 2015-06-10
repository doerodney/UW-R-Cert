require(lattice)
xyplot(homeval ~ rooms | factor(river, labels = c("Not Charles River Waterfront", "Charles River Waterfront")), pch = 1, data=boston.reduced, scales = list(alternating = 3)) 

# Homework 2, week 4
buswait = function(x) { dexp(x, rate=(1/35)) }
curve(buswait, 0, 120, 
	main=bquote(paste("Exponential distribution with estimated rate:  ", hat(lambda), " = 1/35" ) ),
	xlab="Waiting time [Minutes]",
	ylab="Probability of bus arrival" )

	
integrate(buswait, 0, 60)
integrate(buswait, 0, 120)
integrate(buswait, 0, 10)

x = runif(1000, 0, 120)

plot(x, ifelse(x < 20, 0, buswait(x)), main="Bus wait time with the shortest observation removed")
abline(v=20)

d <- data.frame(x=c(0:9), y=c(1:10), z=c(rep(c(10, 20), times=5)))
library(lattice)
xyplot(y~x|z, data=d)

x = matrix(rnorm(100), nrow = 10)
y = matrix(rnorm(100), nrow = 10)
fit = lm(y ~ x)


coefficients(fit)

x = matrix(rnorm(1000), nrow = 10)
y = matrix(rnorm(1000), nrow = 10)
fit = lm(y ~ x)
coefficients(fit)

x = cumsum(c(0, runif(100, -1, 1)))
y = cumsum(c(0, runif(100, -1, 1)))
fit = lm(y ~ x)
summary(fit)

x = cumsum(c(0, runif(100, -1, +1)))
y = cumsum(c(0, runif(100, -1, +1)))
fit = lm(y ~ x)
summary(fit)$coefficients
summary(fit)$coefficients[,4]


x = cumsum(c(0, runif(100000, -1, +1)))
y = cumsum(c(0, runif(100000, -1, +1)))
fit = lm(y ~ x)
summary(fit)$coefficients
summary(fit)$coefficients[,4]


x = matrix(rnorm(1e+05), nrow = 10)
y = matrix(rnorm(1e+05), nrow = 10)
pvals = mapply(function(z,w) summary(lm(w~z))$coef[2, 4], split(x, col(x)), split(y, col(y)))
plot(-log10(pvals), pch=19, cex=0.3, main= "Manhattan:  Null Normal Case", xlab = "Test Number:")
abline(h=c(-log10(0.05), 3, 5), col=2)

fit = lm(y ~ x)
summary(fit)$coefficients
summary(fit)$coefficients[,4]


> fit = lm(x~y)
> summary(fit)$coef[2,4]
Error: cannot allocate vector of size 763.0 Mb
In addition: Warning messages:
1: In summary.mlm(fit) :
  Reached total allocation of 3406Mb: see help(memory.size)
2: In summary.mlm(fit) :
  Reached total allocation of 3406Mb: see help(memory.size)
3: In summary.mlm(fit) :
  Reached total allocation of 3406Mb: see help(memory.size)
4: In summary.mlm(fit) :
  Reached total allocation of 3406Mb: see help(memory.size)

#==============================================================================  
x=matrix(rnorm(10000), nrow=10)
y=2*x + matrix(rnorm(10000), nrow=10)
betas=mapply(function(z,w) {summary(lm(w~z))$coef[2,]}, split(x,col(x)),split(y,col(y)))
b = betas[4,]
length(which(b < 0.05))

#x=matrix(rt(10000, 4)/sqrt(2), nrow=10)
y=matrix(rt(10000, 4)/sqrt(2), nrow=10)
betas=mapply(function(z,w) {summary(lm(w~z))$coef[2,]}, split(x,col(x)),split(y,col(y)))
b = betas[4,]
length(which(b < 0.05))

#x=matrix(rexp(10000, 4), nrow=10)
y=matrix(rexp(10000, 4), nrow=10)
betas=mapply(function(z,w) {summary(lm(w~z))$coef[2,]}, split(x,col(x)),split(y,col(y)))
b = betas[4,]
length(which(b < 0.05))

#x=matrix(rcauchy(10000)/2, nrow=10)
y=matrix(rcauchy(10000)/2, nrow=10)
betas=mapply(function(z,w) {summary(lm(w~z))$coef[2,]}, split(x,col(x)),split(y,col(y)))
b = betas[4,]
length(which(b < 0.05))

#==============================================================================
x=matrix(rnorm(10000), nrow=100)
y=matrix(rnorm(10000), nrow=100)
betas=mapply(function(z,w) {summary(lm(w~z))$coef[2,]}, split(x,col(x)),split(y,col(y)))
b = betas[4,]
length(which(b < 0.05))

#x=matrix(rt(10000, 4)/sqrt(2), nrow=100)
y=matrix(rt(10000, 4)/sqrt(2), nrow=100)
betas=mapply(function(z,w) {summary(lm(w~z))$coef[2,]}, split(x,col(x)),split(y,col(y)))
b = betas[4,]
length(which(b < 0.05))

#x=matrix(rexp(10000, 4), nrow=100)
y=matrix(rexp(10000, 4), nrow=100)
betas=mapply(function(z,w) {summary(lm(w~z))$coef[2,]}, split(x,col(x)),split(y,col(y)))
b = betas[4,]
length(which(b < 0.05))

#x=matrix(rcauchy(10000)/2, nrow=100)
y=matrix(rcauchy(10000)/2, nrow=100)
betas=mapply(function(z,w) {summary(lm(w~z))$coef[2,]}, split(x,col(x)),split(y,col(y)))
b = betas[4,]
length(which(b < 0.05))




x=matrix(rnorm(10000),nrow=10)
y=matrix(rnorm(10000),nrow=10)
betas=mapply(function(z,w) {summary(lm(w~z))$coef[2,]}, split(x,col(x)),split(y,col(y)))
b = betas[4,]
length(which(b < 0.05))
[1] 51
x=matrix(rt(10000, 4),nrow=10)
y=matrix(rt(10000, 4),nrow=10)
betas=mapply(function(z,w) {summary(lm(w~z))$coef[2,]}, split(x,col(x)),split(y,col(y)))
b = betas[4,]
length(which(b < 0.05))
[1] 54
x=matrix(rt(10000, 4)/sqrt(2), nrow=10)
y=matrix(rt(10000, 4)/sqrt(2), nrow=10)
betas=mapply(function(z,w) {summary(lm(w~z))$coef[2,]}, split(x,col(x)),split(y,col(y)))
b = betas[4,]
length(which(b < 0.05))
[1] 53
x=matrix(rexp(10000, 4), nrow=10)
y=matrix(rexp(10000, 4), nrow=10)
betas=mapply(function(z,w) {summary(lm(w~z))$coef[2,]}, split(x,col(x)),split(y,col(y)))
b = betas[4,]
length(which(b < 0.05))
[1] 52
x=matrix(rcauchy(10000)/2, nrow=10)
y=matrix(rcauchy(10000)/2, nrow=10)
betas=mapply(function(z,w) {summary(lm(w~z))$coef[2,]}, split(x,col(x)),split(y,col(y)))
b = betas[4,]
length(which(b < 0.05))
[1] 88
#==============================================================================
x=matrix(rnorm(10000), nrow=100)
y=matrix(rnorm(10000), nrow=100)
betas=mapply(function(z,w) {summary(lm(w~z))$coef[2,]}, split(x,col(x)),split(y,col(y)))
b = betas[4,]
length(which(b < 0.05))


x=matrix(rt(10000, 4)/sqrt(2), nrow=100)
y=matrix(rt(10000, 4)/sqrt(2), nrow=100)
betas=mapply(function(z,w) {summary(lm(w~z))$coef[2,]}, split(x,col(x)),split(y,col(y)))
b = betas[4,]
length(which(b < 0.05))

x=matrix(rexp(10000, 4), nrow=100)
y=matrix(rexp(10000, 4), nrow=100)
betas=mapply(function(z,w) {summary(lm(w~z))$coef[2,]}, split(x,col(x)),split(y,col(y)))
b = betas[4,]
length(which(b < 0.05))

x=matrix(rcauchy(10000)/2, nrow=100)
y=matrix(rcauchy(10000)/2, nrow=100)
betas=mapply(function(z,w) {summary(lm(w~z))$coef[2,]}, split(x,col(x)),split(y,col(y)))
b = betas[4,]
length(which(b < 0.05))

x=matrix(rnorm(10000), nrow=100)
y=matrix(rnorm(10000), nrow=100)
betas=mapply(function(z,w) {summary(lm(w~z))$coef[2,]}, split(x,col(x)),split(y,col(y)))
b = betas[4,]
length(which(b < 0.05))
[1] 5

x=matrix(rt(10000, 4)/sqrt(2), nrow=100)
y=matrix(rt(10000, 4)/sqrt(2), nrow=100)
betas=mapply(function(z,w) {summary(lm(w~z))$coef[2,]}, split(x,col(x)),split(y,col(y)))
b = betas[4,]
length(which(b < 0.05))
[1] 8

x=matrix(rexp(10000, 4), nrow=100)
y=matrix(rexp(10000, 4), nrow=100)
betas=mapply(function(z,w) {summary(lm(w~z))$coef[2,]}, split(x,col(x)),split(y,col(y)))
b = betas[4,]
length(which(b < 0.05))
[1] 3

x=matrix(rcauchy(10000)/2, nrow=100)
y=matrix(rcauchy(10000)/2, nrow=100)
betas=mapply(function(z,w) {summary(lm(w~z))$coef[2,]}, split(x,col(x)),split(y,col(y)))
b = betas[4,]
length(which(b < 0.05))
[1] 5

#==============================================================================
x=matrix(rnorm(10000),nrow=10)
y=matrix(2 * x +  ,nrow=10)
betas=mapply(function(z,w) {summary(lm(w~z))$coef[2,]}, split(x,col(x)),split(y,col(y)))
b = betas[4,]
length(which(b < 0.05))



#===============================================================================
SignalWithNoise <- function(x) { 
	y = numeric(length(x))
	for (i in 1:length(x) ) {
		y[i] = 2 * x[i] + rexp(1);  
	}	
	return(y)
}

#==============================================================================  
x=matrix(rnorm(10000), nrow=10)
y=2*x + matrix(rnorm(10000), nrow=10)
betas=mapply(function(z,w) {summary(lm(w~z))$coef[2,]}, split(x,col(x)),split(y,col(y)))
estimates = betas[1, ]
stdErrs = betas[2, ]
tvals = betas[3, ]
pvals = betas[4, ]
pwr = length(which(tvals > qt(0.975, 8))) / length(tvals)
bias = mean(estimates) - 2
nTooLow = length(which(estimates + qt(0.975, 8) < 2))
nTooHigh = length(which(estimates - qt(0.975, 8) > 2))
(pwr)
(bias)
(nTooLow)
(nTooHigh)

#x=matrix(rt(10000, 4)/sqrt(2), nrow=10)
y=2*x + matrix(rt(10000, 4)/sqrt(2), nrow=10)
betas=mapply(function(z,w) {summary(lm(w~z))$coef[2,]}, split(x,col(x)),split(y,col(y)))
estimates = betas[1, ]
stdErrs = betas[2, ]
tvals = betas[3, ]
pvals = betas[4, ]
pwr = length(which(tvals > qt(0.975, 8))) / length(tvals)
bias = mean(estimates) - 2
nTooLow = length(which(estimates + qt(0.975, 8) < 2))
nTooHigh = length(which(estimates - qt(0.975, 8) > 2))
(pwr)
(bias)
(nTooLow)
(nTooHigh)

#x=matrix(rexp(10000, 4), nrow=10)
y=2*x + matrix(rexp(10000, 4), nrow=10)
betas=mapply(function(z,w) {summary(lm(w~z))$coef[2,]}, split(x,col(x)),split(y,col(y)))
estimates = betas[1, ]
stdErrs = betas[2, ]
tvals = betas[3, ]
pvals = betas[4, ]
pwr = length(which(tvals > qt(0.975, 8))) / length(tvals)
bias = mean(estimates) - 2
nTooLow = length(which(estimates + qt(0.975, 8) < 2))
nTooHigh = length(which(estimates - qt(0.975, 8) > 2))
(pwr)
(bias)
(nTooLow)
(nTooHigh)

#x=matrix(rcauchy(10000)/2, nrow=10)
y=2*x + matrix(rcauchy(10000)/2, nrow=10)
betas=mapply(function(z,w) {summary(lm(w~z))$coef[2,]}, split(x,col(x)),split(y,col(y)))
estimates = betas[1, ]
stdErrs = betas[2, ]
tvals = betas[3, ]
pvals = betas[4, ]
pwr = length(which(tvals > qt(0.975, 8))) / length(tvals)
bias = mean(estimates) - 2
nTooLow = length(which(estimates + qt(0.975, 8) < 2))
nTooHigh = length(which(estimates - qt(0.975, 8) > 2))
(pwr)
(bias)
(nTooLow)
(nTooHigh)

#==============================================================================
x=matrix(rnorm(10000), nrow=100)
y=2*x + matrix(rnorm(10000), nrow=100)
betas=mapply(function(z,w) {summary(lm(w~z))$coef[2,]}, split(x,col(x)),split(y,col(y)))
estimates = betas[1, ]
stdErrs = betas[2, ]
tvals = betas[3, ]
pvals = betas[4, ]
pwr = length(which(tvals > qt(0.975, 98))) / length(tvals)
bias = mean(estimates) - 2
nTooLow = length(which(estimates + qt(0.975, 98) < 2))
nTooHigh = length(which(estimates - qt(0.975, 98) > 2))
(pwr)
(bias)
(nTooLow)
(nTooHigh)

#x=matrix(rt(10000, 4)/sqrt(2), nrow=100)
y=2*x + matrix(rt(10000, 4)/sqrt(2), nrow=100)
betas=mapply(function(z,w) {summary(lm(w~z))$coef[2,]}, split(x,col(x)),split(y,col(y)))
estimates = betas[1, ]
stdErrs = betas[2, ]
tvals = betas[3, ]
pvals = betas[4, ]
pwr = length(which(tvals > qt(0.975, 98))) / length(tvals)
bias = mean(estimates) - 2
nTooLow = length(which(estimates + qt(0.975, 98) < 2))
nTooHigh = length(which(estimates - qt(0.975, 98) > 2))
(pwr)
(bias)
(nTooLow)
(nTooHigh)

#x=matrix(rexp(10000, 4), nrow=100)
y=2*x + matrix(rexp(10000, 4), nrow=100)
betas=mapply(function(z,w) {summary(lm(w~z))$coef[2,]}, split(x,col(x)),split(y,col(y)))
estimates = betas[1, ]
stdErrs = betas[2, ]
tvals = betas[3, ]
pvals = betas[4, ]
pwr = length(which(tvals > qt(0.975, 98))) / length(tvals)
bias = mean(estimates) - 2
nTooLow = length(which(estimates + qt(0.975, 98) < 2))
nTooHigh = length(which(estimates - qt(0.975, 98) > 2))
(pwr)
(bias)
(nTooLow)
(nTooHigh)

#x=matrix(rcauchy(10000)/2, nrow=10)
y=2*x + matrix(rcauchy(10000)/2, nrow=100)
betas=mapply(function(z,w) {summary(lm(w~z))$coef[2,]}, split(x,col(x)),split(y,col(y)))
estimates = betas[1, ]
stdErrs = betas[2, ]
tvals = betas[3, ]
pvals = betas[4, ]
pwr = length(which(tvals > qt(0.975, 98))) / length(tvals)
bias = mean(estimates) - 2
nTooLow = length(which(estimates + qt(0.975, 98) < 2))
nTooHigh = length(which(estimates - qt(0.975, 98) > 2))
(pwr)
(bias)
(nTooLow)
(nTooHigh)


par(mfrow=c(2,2))

for (i in 1:4) {
	# Beta is the period [minutes] between consecutive buses 
	# as they leave the base.  In my case, that is about 30 minutes.
	beta = 30

	# Let's assume that there are n fellow passengers waiting.
	nWaiting = 5  # AKA sample size
	y = runif(nWaiting, 0, beta)

	# Generate data on the x axis up to two intervals of beta. 
	x = seq(0, 2 * beta, 0.01)

	# Plot all data less than the maximum wait experienced as 0.  Why?  
	# Because if the bus came before then, all the passengers would be on it.
	plot(x, ifelse( x < max(y), 0, x^(-beta)), pch=19, col=2, cex=0.5, xlab='Beta', ylab='Likelihood', 
		main=sprintf("(sample size, max wait time [min]) = (%2d, %5.2f)", nWaiting, max(y)))
	abline(v = max(y), lwd = 2)
}

# Back to Boston
setwd("C:/Users/Rod/SkyDrive/R/201/Week02")  
boston = read.csv("Boston.csv")

full.model = lm(homeval ~ crime + biglots + indust + river + nox + rooms + old + jobdist + tax + teachratio + lowSES, data=boston)
summary(full.model)
step.model = step(full.model, direction="backward")
summary(step.model)

reduced.model = lm(homeval ~ river + nox + rooms + jobdist + teachratio + lowSES, data=boston)
summary(reduced.model)

boston.reduced = data.frame(cbind(boston$homeval, boston$river, boston$nox, boston$rooms, boston$jobdist, boston$teachratio, boston$lowSES))
names(boston.reduced) = c('homeval', 'river', 'nox', 'rooms', 'jobdist', 'teachratio', 'lowSES')
pairsPlus(boston.reduced)
cs = cor(boston.reduced)

covs = sort(abs(cs[,1]))
covs
     river    jobdist        nox teachratio      rooms     lowSES    homeval 
 0.1752602  0.2499287  0.4273208  0.5077867  0.6953599  0.7376627  1.0000000 

fit1 = lm(homeval ~ lowSES, data = boston.reduced)
fit2 = lm(homeval ~ lowSES + rooms, data = boston.reduced)
fit3 = lm(homeval ~ lowSES + rooms + teachratio, data = boston.reduced)
fit4 = lm(homeval ~ lowSES + rooms + teachratio + nox, data = boston.reduced)
fit5 = lm(homeval ~ lowSES + rooms + teachratio + nox + jobdist, data = boston.reduced)
fit6 = lm(homeval ~ lowSES + rooms + teachratio + nox + jobdist + river, data = boston.reduced)

fit7 = lm(homeval ~ lowSES + rooms + nox, data = boston.reduced)
fit8 = lm(homeval ~ lowSES + rooms + nox + jobdist, data = boston.reduced)
fit9 = lm(homeval ~ lowSES + rooms + nox + jobdist + river, data = boston.reduced)

waldtest(fit1, fit2, fit3, fit4, fit5, fit6)

lrtest(fit1, fit2, fit3, fit4, fit5, fit6)


