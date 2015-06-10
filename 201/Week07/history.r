vout=rep(NA,nvar)
names(vout)=colnames(xmat)
for (a in 1:nvar)
{
tmp=summary(lm(xmat[,a]~xmat[,-a]))
vout[a]=1/(1-tmp$r.squared)
}
return(vout)
}
myvif(autos.clean.x)
history()
autos.x = autos.clean[, !(colnames(autos.clean) %in% c("gp100m", "cyl", "year", "continent", "diesel" ))]
vif(autos.x)
myvif(autos.x)
# Gets non-factor covariates only (no response)
autos.x = autos.clean[, !(colnames(autos.clean) %in% c("gp100m", "cyl", "year", "continent", "diesel", "volume" ))]
vif(autos.x)
autos.x = autos.clean[, !(colnames(autos.clean) %in% c("gp100m", "cyl", "year", "continent", "diesel", "volume", "hp" ))]
vif(autos.x)
str(autos)
# New transform function without volume and hp
transformAutos <- function(autos) {
  autos.clean = data.frame(cbind(100/autos$mpg, autos$cyl, autos$weight, autos$accel ,autos$year, autos$continent, autos$diesel))
  colnames(autos.clean) = c("gp100m", "cyl", "weight", "accel", "year", "continent", "diesel")
  # Establish factors in data.
  autos.clean$continent = factor(autos.clean$continent)  # North America, Europe, Asia
  autos.clean$diesel = factor(autos.clean$diesel) # gasoline, diesel
  autos.clean$cyl = factor(autos.clean$cyl) # Number of cylinders is non-continuous
  autos.clean$year = factor(autos.clean$year) # Model years are non-continuous.
  # And return the data frame.
  autos.clean
} 
autos.clean = transformAutos(autos)
# Gets non-factor covariates only (no response)
autos.x = autos.clean[, !(colnames(autos.clean) %in% c("gp100m", "cyl", "year", "continent", "diesel" ))]
vif(autos.x)
?sample
str(autos.clean)
length(autos.clean)
length(autos.clean[,])
length(autos.clean[1,])
length(autos.clean[,1])
idxTraining = sample(autos.clean, floor(0.7 * length(autos.clean[,1]))
)
length(autos.clean[,1])
nTrainingSamples = floor(0.7 * length(autos.clean[,1]))
nTrainingSamples
idxTraining = sample(autos.clean, nTrainingSamples)
idxTraining = sample(1:length(autos.clean[,1]), nTrainingSamples)
idxTraining
length(idxTraining)
idxTrain = sample(1:length(autos.clean[,1]), nTrainingSamples)
idxTest = setdiff(idxTrain, 1:length(autos.clean[,1]))
idxTest
 1:length(autos.clean[,1])
idxTrain
?setdiff
 setdiff(1:length(autos.clean[,1]), idxTrain)
 setdiff(idxTrain, 1:length(autos.clean[,1]))
 setdiff(1:length(autos.clean[,1]), idxTrain)
 idxTest = setdiff(1:length(autos.clean[,1]), idxTrain)
nTrainingSamples = floor(0.7 * length(autos.clean[,1]))
idxTrain = sample(1:length(autos.clean[,1]), nTrainingSamples)
idxTest = setdiff(1:length(autos.clean[,1]), idxTrain) 
formula = "gp100m ~ .^2"  
# Fit a simple linear model
fit.lm.0 <- lm(formula, data=autos.train)
calculate_rms_error(fit.lm.0, autos.train, autos.test, "gp100m") 
plotFit(autos.train$gp100m, fitted(fit.lm.0))
summary.lm(fit.lm.0)
# Select data for training, testing.
autos.train = autos.clean[idxTrain,]
autos.test = autos.clean[idxTest, ]
formula = "gp100m ~ .^2"  
# Fit a simple linear model
fit.lm.0 <- lm(formula, data=autos.train)
calculate_rms_error(fit.lm.0, autos.train, autos.test, "gp100m") 
plotFit(autos.train$gp100m, fitted(fit.lm.0))
summary.lm(fit.lm.0)
# Apply step to linear model and evaluate.
fit.lm.step = step(fit.lm.0)
calculate_rms_error(fit.lm.step, autos.train, autos.test, "gp100m")
plotFit(autos.train$gp100m, fitted(fit.lm.step)) 
summary.lm(fit.lm.step)
# Apply step backwards to linear model and evaluate.
fit.lm.step.backward = step(fit.lm.0, direction=c("backward"))
calculate_rms_error(fit.lm.step.backward, autos.train, autos.test, "gp100m")
plotFit(autos.train$gp100m, fitted(fit.lm.step.backward)) 
summary.lm(fit.lm.step.backward)
# Apply step forwards to linear model and evaluate.
fit.lm.step.forward = step(fit.lm.0, direction=c("forward"))
calculate_rms_error(fit.lm.step.forward, autos.train, autos.test, "gp100m")
plotFit(autos.train$gp100m, fitted(fit.lm.step.forward)) 
summary.lm(fit.lm.step.forward)
# Fit a gaussian generalized linear model.
fit.glm.gaussian = glm(formula, family=gaussian, autos.train )
calculate_rms_error(fit.glm.gaussian, autos.train, autos.test, "gp100m")
plotFit(autos.train$gp100m, fitted(fit.glm.gaussian )) 
summary.lm(fit.glm.gaussian)
formula
ls
ls()
# Apply step to gaussian glm.
fit.glm.gaussian.step = step(fit.glm.gaussian)
calculate_rms_error(fit.glm.gaussian.step , autos.train, autos.test, "gp100m")
plotFit(autos.train$gp100m, fitted(fit.glm.gaussian.step)) 
summary.lm(fit.glm.gaussian.step)
?step
str(autos.clean)
setwd("C:/Users/Rod/SkyDrive/R/201/Week07")  # SkyDrive from home
#setwd("C:/Users/rodney.doe/SkyDrive/R/201/Week07")  # SkyDrive from work
autos = read.csv("autoMPGtrain.csv", header=TRUE)
autos$gp100m = 100 / autos$mpg
transformAutos <- function(autos) {
  autos.clean = data.frame(cbind(100/autos$mpg, autos$cyl, autos$volume, autos$hp, autos$weight, autos$accel ,autos$year, autos$continent, autos$diesel))
  colnames(autos.clean) = c("gp100m", "cyl", "volume", "hp", "weight", "accel", "year", "continent", "diesel")
  # Establish factors in data.
  autos.clean$continent = factor(autos.clean$continent)  # North America, Europe, Asia
  autos.clean$diesel = factor(autos.clean$diesel) # gasoline, diesel
  autos.clean$cyl = factor(autos.clean$cyl) # Number of cylinders is non-continuous
  autos.clean$year = factor(autos.clean$year) # Model years are non-continuous.
  # And return the data frame.
  autos.clean
}
str(autos.clean)
setwd("C:/Users/Rod/SkyDrive/R/201/Week07")  # SkyDrive from home
#setwd("C:/Users/rodney.doe/SkyDrive/R/201/Week07")  # SkyDrive from work
autos = read.csv("autoMPGtrain.csv", header=TRUE)
autos$gp100m = 100 / autos$mpg
transformAutos <- function(autos) {
  autos.clean = data.frame(cbind(100/autos$mpg, autos$cyl, autos$volume, autos$hp, autos$weight, autos$accel ,autos$year, autos$continent, autos$diesel))
  colnames(autos.clean) = c("gp100m", "cyl", "volume", "hp", "weight", "accel", "year", "continent", "diesel")
  # Establish factors in data.
  autos.clean$continent = factor(autos.clean$continent)  # North America, Europe, Asia
  autos.clean$diesel = factor(autos.clean$diesel) # gasoline, diesel
  autos.clean$cyl = factor(autos.clean$cyl) # Number of cylinders is non-continuous
  autos.clean$year = factor(autos.clean$year) # Model years are non-continuous.
  # And return the data frame.
  autos.clean
}  
autos.clean = transformAutos(autos)
str(autos.clean)
vif(autos.clean)
# New transform function without volume and hp
transformAutos.VIF <- function(autos) {
  autos.clean = data.frame(cbind(100/autos$mpg, autos$cyl, autos$weight, autos$accel ,autos$year, autos$continent, autos$diesel))
  colnames(autos.clean) = c("gp100m", "cyl", "weight", "accel", "year", "continent", "diesel")
  # Establish factors in data.
  autos.clean$continent = factor(autos.clean$continent)  # North America, Europe, Asia
  autos.clean$diesel = factor(autos.clean$diesel) # gasoline, diesel
  autos.clean$cyl = factor(autos.clean$cyl) # Number of cylinders is non-continuous
  autos.clean$year = factor(autos.clean$year) # Model years are non-continuous.
  # And return the data frame.
  autos.clean
}  
autos.vifClean = transformAutos.VIF(autos)
str(autos.vifClean)
?step
formula
fit.lm = lm(formula, data=autos.clean)
summary.lm(fit.lm)
# Fit a simple lm model with excessive VIF.
fit.lm = lm(formula=formula, data=autos.clean)
plotFit(autos.clean$gp100m, fitted(fit.lm))
summary.lm(fit.lm)

fit.lm.step.both.aic = step(fit.lm, direction=c("both"), k=2)
plotFit(autos.clean$gp100m, fitted(fit.lm.step.both.aic))
summary.lm(fit.lm.step.both.aic)

# Fit a step = both, with BIC and excessive VIF.
fit.lm.step.both.bic = step(fit.lm, direction=c("both"), k=log(length(autos.clean[,1])))
plotFit(autos.clean$gp100m, fitted(fit.lm.step.both.bic))
summary.lm(fit.lm.step.both.bic)

transformAutos.VIF <- function(autos) {
  autos.clean = data.frame(cbind(100/autos$mpg, autos$cyl, autos$weight, autos$accel ,autos$year, autos$continent, autos$diesel))
  colnames(autos.clean) = c("gp100m", "cyl", "weight", "accel", "year", "continent", "diesel")
  # Establish factors in data.
  autos.clean$continent = factor(autos.clean$continent)  # North America, Europe, Asia
  autos.clean$diesel = factor(autos.clean$diesel) # gasoline, diesel
  autos.clean$cyl = factor(autos.clean$cyl) # Number of cylinders is non-continuous
  autos.clean$year = factor(autos.clean$year) # Model years are non-continuous.
  # And return the data frame.
  autos.clean
}
ls()
str(autos.vifClean)

autos.vifClean = transformAutos.VIF(autos)
str(autos.vifClean)

# Fit a simple lm model with excessive VIF removed.
fit.lm.vif.clean = lm(formula=formula, data= autos.vifClean)
plotFit(autos.clean$gp100m, fitted(fit.lm.vif.clean))
summary.lm(fit.lm.vif.clean)

# Simple lm model with step=”both”, AIC, VIF-clean
fit.lm.vif.clean.step.aic = step(fit.lm.vif.clean, direction=c("both"), k=2)
plotFit(autos.vifClean$gp100m, fitted(fit.lm.vif.clean.step.aic))
summary.lm(fit.lm.vif.clean.step.aic)

#Simple lm model with step=”both”, BIC, VIF-clean
fit.lm.vif.clean.step.bic = step(fit.lm.vif.clean, direction=c("both"), k=log(length(autos.clean[,1])))
plotFit(autos.vifClean$gp100m, fitted(fit.lm.vif.clean.step.bic))
summary.lm(fit.lm.vif.clean.step.bic)

