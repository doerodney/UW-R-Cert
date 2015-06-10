setwd("C:/Users/Rod/SkyDrive/R/301/Week03")
autos = read.csv("autoMPGtrain.csv", as.is = TRUE)

autos$gp100m = 100/autos$mpg
autos$continent = factor(autos$continent)
autos$name = tolower(autos$name)
autos$diesel = grepl("diesel", autos$name)
autos$diesel[autos$name == "mercedes-benz 240d"] = TRUE
autos$wagon = grepl("[(]sw[)]", autos$name)
autos$cylgroup = cut(autos$cyl, c(2, 5.5, 6.5, 9))

str(autos)

library(BMA)
# ?bic.glm

# From class code...
options(width = 132)
bma1 = bicreg(autos[, c(3:8, 11:13)], autos$gp100m)
round(bma1$postprob, 2)

autos.clean = autos[, (colnames(autos) %in% c("volume", "hp", "weight", "accel", "year", "continent", "gp100m", "diesel", "wagon", "cylgroup") ) ]

# From help vignette...
#bic.glm(f, data, glm.family, wt = rep(1, nrow(data)), strict = FALSE, 
#	 prior.param = c(rep(0.5, ncol(x))), OR = 20, maxCol = 30, OR.fix = 2, 
#	 nbest = 150, dispersion = , factor.type = TRUE, 
#	 factor.prior.adjust = FALSE, occam.window = TRUE, ...)

# From help vignette...
# bicreg(x, y, wt = rep(1, length(y)), strict = FALSE, OR = 20, maxCol = 31, 
#       drop.factor.levels = TRUE, nbest = 10)


bma1 = bicreg(autos[, c(3:8, 11:13)], autos$gp100m)	
formula = as.formula("gp100m ~ volume + hp + weight + accel + year + continent + diesel + wagon + cylgroup")	
bma2 = bic.glm(f = formula, data = autos, glm.family=gaussian()) 
round(bma1$postprob, 2)
round(bma2$postprob, 2)
bma1$which
bma2$which


# From help vignette...
# bic.glm(f, data, glm.family, wt = rep(1, nrow(data)), strict = FALSE, 
#	 prior.param = c(rep(0.5, ncol(data))), OR = 20, maxCol = 30, OR.fix = 2, 
#	 nbest = 150, dispersion = , factor.type = TRUE, 
#	 factor.prior.adjust = FALSE, occam.window = TRUE, ...)

# From help vignette...
# bicreg(x, y, wt = rep(1, length(y)), strict = FALSE, OR = 20, maxCol = 31, 
#       drop.factor.levels = TRUE, nbest = 10)


# Cross-validation (part c)====================================================
 
 plotFit <- function(yObserved, yFitted, intercept=1) {
  plot(yObserved, yFitted)
  abline(intercept,1,lty=2, col=rgb(1,0,0))
  abline(-intercept,1,lty=2, col=rgb(1,0,0))
}

autos = read.csv("autoMPGtrain.csv", as.is = TRUE)

autos$gp100m = 100/autos$mpg
autos$continent = factor(autos$continent)
autos$name = tolower(autos$name)
autos$diesel = grepl("diesel", autos$name)
autos$diesel[autos$name == "mercedes-benz 240d"] = TRUE
autos$wagon = grepl("[(]sw[)]", autos$name)
autos$cylgroup = cut(autos$cyl, c(2, 5.5, 6.5, 9))

# Convert factors to numeric for cross validation to work?
autos.clean = autos[, (colnames(autos) %in% c("volume", "hp", "weight", "accel", "year", "continent", "gp100m", "diesel", "wagon", "cylgroup") ) ]

formula = as.formula("gp100m ~ volume + hp + weight + accel + year + continent + diesel + wagon + cylgroup")
source("crossValidate.r")
result = crossValidate(autos.clean, formula, nSets=5, "gp100m") 

# Best result came with OR=100
# Create the model for this training set.
model = bic.glm(formula, glm.family=gaussian(), data=autos.clean, OR=100)

plotFit(autos.clean$gp100m, fitted(model))

