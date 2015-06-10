###############################################################################
# Load data frame.
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

# Colors to use in plots.
cols = c(rgb(1,0,0,0.4), rgb(0,1,0,0.4), rgb(0,0,1,0.4))
		 
# Plot fuel consumption by continent of manufacturer.
plot(jitter(autos$gp100m), col=cols[autos$continent], 
		xlab="", 
		ylab="Fuel consumed per 100 miles [US Gallons]", 
		main="Fuel Consumption by Continent of Manufacturer", pch=19)
legend("topright", legend=c("North America", "Europe", "Asia"), col=cols, pch=19)

# Plot fuel consumption by fuel type.
plot(jitter(autos$gp100m), col=cols[1 + autos$diesel], 
		xlab="", 
		ylab="Fuel consumed per 100 miles [US Gallons]", 
		main="Fuel Consumption by Fuel Type", pch=19)
legend("topright", legend=c("gasoline", "diesel"), col=cols, pch=19)

# Plot fuel consumption by engine type.
plot(jitter(autos$gp100m), col=cols[1 + autos$piston], 
		xlab="", 
		ylab="Fuel consumed per 100 miles [US Gallons]", 
		main="Fuel Consumption by Engine Type", pch=19)
legend("topright", legend=c("rotary piston", "reciprocating piston"), col=cols, pch=19)

# Plot fuel consumption by vehicle weight.
plot(autos$weight, autos$gp100m, 
		xlab="Vehicle Weight [lbs]", 
		ylab="Fuel consumed per 100 miles [US Gallons]", 
		main="Fuel Consumption by Vehicle Weight", pch=19)
fit = lm(autos$gp100m ~ autos$weight)
abline(fit)		

# Plot fuel consumption by model year.
yearRange = range(autos$year)
yearNumbers = yearRange[1]:yearRange[2] 
yearLabels = character(length(yearNumbers))
for (i in 1:length(yearNumbers)) {
	yearLabels[i] = sprintf("19%d", yearNumbers[i])
}
yearColors = rainbow( length(yearNumbers)) 
plot(jitter(autos$gp100m), col=yearCols[autos$year - min(autos$year) + 1], 
		ylim=c(2,20),
		xlab="", 
		ylab="Fuel consumed per 100 miles [US Gallons]", 
		main="Fuel Consumption by Model Year", pch=19)
legend("topright", legend=yearLabels, col=yearColors, pch=19)

# Establish factors in data.
autos$continent=factor(autos$continent)  # North America, Europe, Asia
autos$diesel = factor(autos$diesel) # gasoline, diesel
autos$cyl = factor(autos$cyl) # Number of cylinders is non-continuous
autos$year = factor(autos$year) # Model years are non-continuous.
 
 # A handy little function to visually render the fit.
 plotFit <- function(yObserved, yFitted) {
  plot(yObserved, yFitted)
  abline(1,1,lty=2, col=rgb(1,0,0))
  abline(-1,1,lty=2, col=rgb(1,0,0))
}
 
# Returns the Variance Inflation Factor for each covariate 
# in a linear regression model.
# Values over 5 merit concern.
vif <- function(df) { # df is of type data.frame.
	# Get the count of columns in the data frame.
	covariate = names(df)
	nCols = length(covariate)
	colIndices = 1:nCols
	
	# Results go here.
	vif = numeric(nCols)
	
	for (i in 1:nCols) {
		# The i'th column in the data frame is the outcome.
		outcomeName = covariate[i]
		
		# All other columns are covariates.
		covariateNames = covariate[which(colIndices != i)]
		
		# Construct a string that will be the lm formula.
		formulaText = paste(outcomeName,  " ~ ", paste(covariateNames, collapse="+"))
		
		# Generate the linear model with the formula string.
		# Capture the result.
		smry = summary( lm(as.formula(formulaText), data=df) )
		
		# Capture r-squared from from the model.
		rsq = smry$r.squared
		
		# Calculate and store the variance inflation factor for this outcome.
		vif[i] =  1 / (1 - rsq)
	}	
		
	result = cbind(covariate, vif)	
	
	result	
} 
 
# Create a data subset based upon important columns in the data.  
# This omits engine type.   
autos.clean = data.frame(cbind(autos$gp100m, autos$cyl, autos$volume, autos$hp, autos$weight, autos$accel ,autos$year, autos$continent, autos$diesel))
colnames(autos.clean) = c("gp100m", "cyl", "volume", "hp", "weight", "accel", "year", "continent", "diesel")

cor(autos.clean)
pairs(autos.clean)

# Gets covariates only (no response)
autos.clean.x = autos.clean[, !(colnames(autos.clean) %in% c("gp100m"))]
# VIFs too high.  Remove "volume"
# Gets non-factor covariates only (no response)
autos.x = autos.clean[, !(colnames(autos.clean) %in% c("gp100m", "cyl", "year", "continent", "diesel", "volume" ))]
# VIFs too high.  Remove "hp"
autos.x = autos.clean[, !(colnames(autos.clean) %in% c("gp100m", "cyl", "year", "continent", "diesel", "volume", "hp" ))]

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

# Gets non-factor covariates only (no response)
autos.x = autos.clean[, !(colnames(autos.clean) %in% c("gp100m", "cyl", "year", "continent", "diesel" ))]
# VIFs are OK (vif < 1.3)

# Select indices for training and testing.
nTrainingSamples = floor(0.7 * length(autos.clean[,1]))
idxTrain = sample(1:length(autos.clean[,1]), nTrainingSamples)
idxTest = setdiff(1:length(autos.clean[,1]), idxTrain) 

# Select data for training, testing.
autos.train = autos.clean[idxTrain,]
autos.test = autos.clean[idxTest, ]

# Specify the formula
formula = "gp100m ~ .^2"  

# Fit a simple lm model with excessive VIF.
fit.lm = lm(formula=formula, data=autos.clean)
plotFit(autos.clean$gp100m, fitted(fit.lm))
summary.lm(fit.lm)

# Fit a step = both, with AIC and excessive VIF.
fit.lm.step.both.aic = step(fit.lm, direction=c("both"), k=2)
plotFit(autos.clean$gp100m, fitted(fit.lm.step.both.aic))
summary.lm(fit.lm.step.both.aic)

# Fit a step = both, with BIC and excessive VIF.
fit.lm.step.both.bic = step(fit.lm, direction=c("both"), k=log(length(autos.clean[,1])))
plotFit(autos.clean$gp100m, fitted(fit.lm.step.both.bic))
summary.lm(fit.lm.step.both.bic)

# Fit a step = both with AIC and clean VIF.


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

# Apply step to gaussian glm.
fit.glm.gaussian.step = step(fit.glm.gaussian)
calculate_rms_error(fit.glm.gaussian.step , autos.train, autos.test, "gp100m")
plotFit(autos.train$gp100m, fitted(fit.glm.gaussian.step)) 
summary.lm(fit.glm.gaussian.step)

# Customized by Sum Dum Guy
fit.glm.gaussian.custom = glm(formula = gp100m ~ cyl + volume + hp + weight + accel + year + 
    continent + volume:weight + volume:continent + 
    hp:weight + hp:accel + weight:year + weight:continent + accel:year + 
    accel:continent + year:continent, family = gaussian, data = autos.train)
calculate_rms_error(fit.glm.gaussian.custom, autos.train, autos.test, "gp100m")
plotFit(autos.train$gp100m, fitted(fit.glm.gaussian.custom)) 
summary.lm(fit.glm.gaussian.custom)

# Customized by Sum Dum Guy
fit.glm.gaussian.custom = glm(formula = gp100m ~ volume + hp + weight + accel + year + 
    continent + volume:weight + volume:continent + 
    hp:weight + hp:accel + weight:year + accel:year + 
    accel:continent, family = gaussian, data = autos.train)
calculate_rms_error(fit.glm.gaussian.custom, autos.train, autos.test, "gp100m")
plotFit(autos.train$gp100m, fitted(fit.glm.gaussian.custom)) 
summary.lm(fit.glm.gaussian.custom)	
	
# glmnet
keeps = c("cyl", "volume", "hp", "weight", "accel", "year", "continent", "fuel")
autos.train.x = autos.train[keeps]
autos.train.y = autos.train$gp100m
library(glmnet)
fit.glmnet.gaussian = glmnet(as.matrix(autos.train.x), autos.train.y, 
	family="gaussian", alpha=1, nlambda=1000, standardize=TRUE, maxit=10000)
calculate_rms_error(fit.glmnet.gaussian, autos.train, autos.test, "gp100m")
plotFit(autos.train$gp100m, fitted(fit.glmnet.gaussian)) 
summary.lm(fit.glmnet.gaussian)	

fit.lm.assaf = lm(formula = gp100m ~ cyl + hp + weight + accel + year + 
hp:accel + hp:year + accel:year, data = data.frame(cbind(autos$continent,
scale(autos[, -c(1, 8, 9, 10, 11)]))))

calculate_rms_error(fit.lm.assaf, autos.train, autos.test, "gp100m")
plotFit(autos.train$gp100m, fitted(fit.lm.assaf)) 
summary.lm(fit.lm.assaf)
	
	
summary.lm(fit.lm.0)
summary.lm(fit.lm.step)
summary.lm(fit.lm.step.backward)
summary.lm(fit.lm.step.forward)
summary.lm(fit.glm.gaussian)


# Cross-validation function
crossValidate <- function(ds, formula, nSets=5, yvalue) {
  nSets = ifelse(nSets == 0, 5, nSets) # no divide by zero...
  
  nRows = length(ds[,1])
  nRowsPerSet = floor(nRows / nSets)
    
  # Accumulate the total test error.
  total.test.err = 0
  
  # Iterate through the data set, dividing into test and training data sets.)
  for (nSet in 1:nSets) {
	# Identify the test set indices.
	idxFirst = ((nSet - 1) * nRowsPerSet + 1)
	idxLast = nSet * nRowsPerSet
	
	# Don't read past the end of the data.
	idxLast = ifelse(idxLast > nRows, nRows, idxLast)
	idxSetTest = idxFirst:idxLast
	
	# The training set is everything but the test set.
	idxSetTrain = setdiff(1:nRows, idxSetTest) 
	
	# Select data for training, testing.
	train = ds[idxSetTrain,]
	test = ds[idxSetTest, ]
	
	# Create the model for this training set.
	model = lm(formula, data=train)
	#model = glm(formula, family=gaussian, data=train)
	#model.lm = lm(formula, data=train)
	#model = step(model.lm, direction=c("backward"))
	#model = step(model.lm, direction=c("forward"))
	#model = glm(formula, family=gaussian, data=train)
	#model.glm = glm(formula, family=gaussian, data=train)
	#model = step(model.glm, direction=c("backward"))
	#model = step(model.glm, direction=c("forward"))
	
	# Calculate rms error for this test set.
	test.yhat <- predict.lm(object=model, newdata=test)
    test.y <- with(test, get(yvalue))
    test.err <- sqrt(mean((test.yhat - test.y)^2))

    # Accumulate test error * size of test set. 	
	total.test.err = total.test.err + test.err
  }      	

  mean.test.err = total.test.err / nSets
  # Return the mean rms error of the test sets.
  mean.test.err	
}

# Test invocation
mean.test.err = crossValidate(ds, formula, 5, "gp100m")
	
# Plagiarized from R in a Nutshell.  Nice way to quantify quality of models.
calculate_rms_error <- function(model, train, test, yvalue) {
  train.yhat <- predict.lm(object=model, newdata=train)
  test.yhat <- predict.lm(object=model, newdata=test)
  train.y <- with(train, get(yvalue)) 	
  test.y <- with(test, get(yvalue))
  train.err <- sqrt(mean((train.yhat - train.y)^2))
  test.err <- sqrt(mean((test.yhat - test.y)^2))

  c(train.err=train.err, test.err=test.err)
 } 

 
ds = data.frame(train.err=numeric(nSets), test.err=numeric(nSets))

transformAutos.sans.factors <- function(autos) {
  autos.clean = data.frame(cbind(100/autos$mpg, autos$cyl, autos$volume, autos$hp, autos$weight, autos$accel ,autos$year, autos$continent, autos$diesel))
  colnames(autos.clean) = c("gp100m", "cyl", "volume", "hp", "weight", "accel", "year", "continent", "diesel")
  
  # Establish factors in data.
  #autos.clean$continent = factor(autos.clean$continent)  # North America, Europe, Asia
  #autos.clean$diesel = factor(autos.clean$diesel) # gasoline, diesel
  #autos.clean$cyl = factor(autos.clean$cyl) # Number of cylinders is non-continuous
  #autos.clean$year = factor(autos.clean$year) # Model years are non-continuous.
  
  # And return the data frame.
  autos.clean
} 

autos.clean.factorless = transformAutos.sans.factors(autos)

# Fit a simple lm model with excessive VIF.
fit.lm.factorless = lm(formula=formula, data=autos.clean.factorless)
plotFit(autos.clean.factorless$gp100m, fitted(fit.lm.factorless))
summary.lm(fit.lm.factorless)

# Fit a step = both, with AIC and excessive VIF.
fit.lm.factorless.step.both.aic = step(fit.lm.factorless, direction=c("both"), k=2)
plotFit(autos.clean$gp100m, fitted(fit.lm.factorless.step.both.aic))
summary.lm(fit.lm.factorless.step.both.aic)
abline(fit.lm.factorless.step.both.aic)


# Fit a step = both, with BIC and excessive VIF.
fit.lm.factorless.step.both.bic = step(fit.lm.factorless, direction=c("both"), k=log(length(autos.clean[,1])))
plotFit(autos.clean$gp100m, fitted(fit.lm.factorless.step.both.bic))
summary.lm(fit.lm.factorless.step.both.bic)
	

set.seed(42) 
m <- sample(0:9,42,TRUE) 
S <- "which(m==4)" 
eval(parse(text=S)) 
[1] 11 15 19 29 42 

S <- "sfit = lm(gp100m ~ .^2, data=autos.clean.factorless)"
eval(parse(test=S))
str(sfit)


# Cross-validation function
crossValidate <- function(ds, formula, nSets=5, yvalue) {
  nSets = ifelse(nSets == 0, 5, nSets) # no divide by zero...
  
  nRows = length(ds[,1])
  nRowsPerSet = floor(nRows / nSets)
    
  # Accumulate the total test error.
  total.test.err = 0
  
  # Iterate through the data set, dividing into test and training data sets.)
  for (nSet in 1:nSets) {
	# Identify the test set indices.
	idxFirst = ((nSet - 1) * nRowsPerSet + 1)
	idxLast = nSet * nRowsPerSet
	
	# Don't read past the end of the data.
	idxLast = ifelse(idxLast > nRows, nRows, idxLast)
	idxSetTest = idxFirst:idxLast
	
	# The training set is everything but the test set.
	idxSetTrain = setdiff(1:nRows, idxSetTest) 
	
	# Select data for training, testing.
	train = ds[idxSetTrain,]
	test = ds[idxSetTest, ]
	
	# Create the model for this training set.
	model = lm(formula, data=train)
	#model.lm = lm(formula, data=train)
	#model = step(model.lm, direction=c("backward"))
	#model.lm = lm(formula, data=train)
	#model = step(model.lm, direction=c("forward"))
	#model.lm = lm(formula, data=train)
	#model = step(model.lm, direction=c("both"))
	#model = glm(formula, family=gaussian, data=train)
	#model.glm = glm(formula, family=gaussian, data=train)
	#model = step(model.glm, direction=c("backward"))
	#model.glm = glm(formula, family=gaussian, data=train)
	#model = step(model.glm, direction=c("forward"))
	#model.glm = glm(formula, family=gaussian, data=train)
	#model = step(model.glm, direction=c("both"))
	#model = lm(gp100m ~ cyl + weight + accel + year + continent + diesel, data=train)
	#model = lm(gp100m ~ weight + year + continent + diesel, data=train)
	
	# Calculate rms error for this test set.
	test.yhat <- predict.lm(object=model, newdata=test)
    test.y <- with(test, get(yvalue))
    test.err <- sqrt(mean((test.yhat - test.y)^2))

    # Accumulate test error * size of test set. 	
	total.test.err = total.test.err + test.err
  }      	

  mean.test.err = total.test.err / nSets
  # Return the mean rms error of the test sets.
  mean.test.err	
}
(crossValidate(ds, formula, 5, "gp100m"))

automat = model.matrix(lm(gp100m ~ ., data = autos[, -c(1, 9)]))[, -1]


# Gets covariates only (no response)
ds.x = ds[, !(colnames(ds) %in% c("gp100m"))]
ds.x = model.matrix(lm(gp100m ~ ., data=ds))
ds.y = ds$gp100m

library(lars)
lars.lasso = lars(as.matrix(ds.x), ds.y, type="lasso")
plotFit(ds.y, fitted(lars.lasso))
summary.lm(lars.lasso)

# Lasso from glmnet
library(glmnet)
glmnet.lasso = glmnet(x = as.matrix(ds.x), y = ds.y)
plotFit(ds.y, fitted(glmnet.lasso))
summary.lm(glmnet.lasso)
names(glmnet.lasso)

#----Lasso hell----------------------------------------------------------------
# Load data frame.
setwd("C:/Users/Rod/SkyDrive/R/201/Week07")  # SkyDrive from home
autos = read.csv("autoMPGtrain.csv", header=TRUE)
autos$gp100m = 100 / autos$mpg

transformAutos.sans.factors <- function(autos) {
  autos.clean = data.frame(cbind(100/autos$mpg, autos$cyl, autos$volume, autos$hp, autos$weight, autos$accel ,autos$year, autos$continent, autos$diesel))
  colnames(autos.clean) = c("gp100m", "cyl", "volume", "hp", "weight", "accel", "year", "continent", "diesel")
  # Establish factors in data.
  #autos.clean$continent = factor(autos.clean$continent)  # North America, Europe, Asia
  #autos.clean$diesel = factor(autos.clean$diesel) # gasoline, diesel
  #autos.clean$cyl = factor(autos.clean$cyl) # Number of cylinders is non-continuous
  #autos.clean$year = factor(autos.clean$year) # Model years are non-continuous.
  # And return the data frame.
  autos.clean
} 

ds = transformAutos.sans.factors(autos)
str(ds)

# A handy little function to visually render the fit.
 plotFit <- function(yObserved, yFitted) {
  plot(yObserved, yFitted)
  abline(1,1,lty=2, col=rgb(1,0,0))
  abline(-1,1,lty=2, col=rgb(1,0,0))
}

# Gets covariates only (no response)
ds.x = ds[, !(colnames(ds) %in% c("gp100m"))]
ds.y = ds$gp100m
str(ds.x)

# Lasso from glmnet
library(glmnet)
lasso.0 = glmnet(x = as.matrix(ds.x), y = ds.y)
plotFit(ds.y, fitted(lasso.0))

# Lasso from lars
library(lars)
lars.lasso = lars(as.matrix(ds.x), ds.y, type="lasso")
plotFit(ds.y, fitted(lars.lasso))


  