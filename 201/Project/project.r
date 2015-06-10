setwd("C:/Users/Rod/SkyDrive/R/201/Project")
library(foreign)
salary = read.dta("salary-stata.dta")

# Summary plot
plot(salary$experience, salary$salary,
	main="Faculty Salaries at a US Public University",
	xlab="Experience [Years]",
	ylab="Monthly Salary [$US 1995]")
abline(lm(salary ~ experience, data=salary))	

# Data exploration and inspection
str(salary)
table(salary$yrdeg)
table(salary$startyr)
table(salary$admin)
plot(1:length(salary$salary), sort(salary$salary))
table(salary$sex)
table(salary$degree)
table(salary$field)
table(salary$rank)
plot(1:length(salary$experience), sort(salary$experience))
which(abs(log(salary$salary) - salary$logsal) > 0.01)

plot(salary$yrdeg, salary$salary)

cols = c(rgb(0,0,1,0.4), rgb(1,0,0, 0.4), rgb(0,1,0,0.4))
plot(salary$experience, salary$salary,
	main="Faculty Salaries at a US Public University",
	xlab="Experience [Years]",
	ylab="Monthly Salary [$US 1995]")
abline(lm(salary ~ experience, data=salary, ))	

salary$gender=ifelse(salary$sex == "M", 1,2)
plot(salary$experience, salary$salary)

# Variance Inflation Factor function
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

# Check for VIF with a dateset that does not contain both salary
# and log(salary).  
# Columns experience and yrdeg correlate, so remove one.
# Also remove factors.
salary.vif = salary[, !(colnames(salary) %in% c("id", "yrdeg", "logsal", "sex", "degree", "field", "rank"))]
str(salary.vif)
vif(salary.vif)
> vif(salary.vif)            
     covariate    vif               
[1,] "startyr"    "2.69872766477552"
[2,] "admin"      "1.09852355430584"
[3,] "salary"     "1.45630498142461"
[4,] "experience" "3.13223669663568"
[5,] "gender"     "1.13444527065998"

# Choose the subset of columns to include for analysis
salary.r = salary[, (colnames(salary) %in% c("logsal", "startyr", "experience", "admin", "gender", "degree", "field", "rank", "gender"))]
str(salary.r)

# Try a few models just to see what's important
salary.r.lm.0 = lm(logsal ~ .^2, data = salary.r)
summary.lm(salary.r.lm.0)

salary.r.lm.1 = step(direction="both", salary.r.lm.0) 
summary.lm(salary.r.lm.1)

library(MASS)
salary.r.rlm.0 = lm(logsal ~ .^2, data = salary.r)
summary.lm(salary.r.rlm.0)

plot(salary$experience, salary$salary, col=cols[salary$gender])
abline(lm(salary ~ experience, data=salary))
legend(legend=c("Female", "Male"), col=cols, pch=19)
legend("topright", legend=c("Female", "Male"), col=cols, pch=19)
plot(salary$experience, log(salary$salary), col=cols[salary$gender])
abline(lm(log(salary) ~ experience, data=salary))

plot(salary$experience, salary$logsal, col=cols[salary$gender])
abline(lm(logsal ~ experience, data=salary))
legend("topleft", legend=c("Female", "Male"), col=cols, pch=19)

formula = "logsal ~ startyr + admin + degree + rank + field + gender"

model.lm.0 = lm(formula, data=salary)
summary.lm(model.0)
model.lm.1 = step(model.lm.0, direction="both")
summary.lm(model.lm.1)

model.glm.0 = glm(formula, data=salary)
summary.glm(model.0)
model.glm.1 = step(model.glm.0, direction="both")
summary.glm(model.glm.1)

####create new dataframe####
# A handy little function to visually render the fit.
 plotFit <- function(yObserved, yFitted) {
  plot(yObserved, yFitted)
  abline(1,1,lty=2, col=rgb(1,0,0))
  abline(-1,1,lty=2, col=rgb(1,0,0))
}
 
# Sample 70% of data for a training data set.
nRows = length(salary.r[,1])
idxTrain = sample(1:nRows, floor(0.7 * nRows)) 
idxTest = setdiff(1:nRows, idxTrain) 

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
 
train = salary.r[idxTrain, ]
test = salary.r[idxTest, ]

train.lm.0 = lm(logsal ~ .^2, data=train)
train.lm.1 = step(direction="both", train.lm.0)
train.glm.0 = glm(logsal ~ .^2, data=train)

calculate_rms_error(train.lm.0, train, test, "logsal")
calculate_rms_error(train.lm.1, train, test, "logsal")
calculate_rms_error(train.glm.0, train, test, "logsal")

salary.r.glm.0 = glm(logsal ~ .^2, data = salary.r)
summary.lm(salary.r.glm.0)

# Model simplified by anova on lm(logsal ^ .^2, data=salary.r
formula.1 = "logsal ~ startyr + admin + degree + field + rank + experience + gender + startyr:experience + admin:gender + degree:field + degree:experience + rank:experience"
model.lm.formula.1 = lm(formula.1, data=salary.r)
plotFit(salary.r$logsal, fitted(model.lm.formula.1))

# Tweak to add intercept argument...
 plotFit <- function(yObserved, yFitted, intercept=1) {
  plot(yObserved, yFitted)
  abline(intercept,1,lty=2, col=rgb(1,0,0))
  abline(-intercept,1,lty=2, col=rgb(1,0,0))
}
# plotFit(salary.r$logsal, fitted(model.lm.formula.1), 0.5)
# plotFit(salary.r$logsal, fitted(model.lm.formula.1), 0.6)
# This bounds all data...
plotFit(salary.r$logsal, fitted(model.lm.formula.1), 0.7)

# Step with AIC
model.lm.step.formula.1.aic = step(direction="both", model.lm.formula.1, k=2)
plotFit(salary.r$logsal, fitted(model.lm.step.formula.1.aic), 0.7)  # Not better

# Step with BIC
model.lm.step.formula.1.bic = step(direction="both", model.lm.formula.1, k=log(length(salary.r[,1])))
plotFit(salary.r$logsal, fitted(model.lm.step.formula.1.bic), 0.7)  # Maybe better

# Gaussian glm
model.glm.formula.1 = glm(formula.1, data=salary.r)
plotFit(salary.r$logsal, fitted(model.glm.formula.1), 0.7)

# library robust lmRob
library(robust)
model.lmRob.formula.1 = lmRob(formula.1, data=salary.r)
plotFit(salary.r$logsal, fitted(model.lmRob.formula.1), 0.7)

# library MASS lm.ridge
library(MASS)
model.lm.ridge.formula.1 = lm.ridge(formula.1, data=salary.r)
plotFit(salary.r$logsal, fitted(model.lm.ridge.formula.1), 0.7)  # dreadful


# Cross-validation function
crossValidate <- function(ds, formula, nSets=10, yvalue) {
  nSets = ifelse(nSets == 0, 10, nSets) # no divide by zero...
  
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
	#model = lm(formula, data=train)
	#model = glm(formula, family=gaussian, data=train)
	model.lm = lm(formula, data=train)
	model = step(model.lm, direction=c("backward"))
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
formula.1 = "logsal ~ startyr + admin + degree + field + rank + experience + gender + startyr:experience + admin:gender + degree:field + degree:experience + rank:experience"
mean.test.err = crossValidate(salary.r, formula.1, 10, "logsal")
# Fails because of unseen factors.  Must convert factors to numerics.
salary.factorless = salary.r
salary.factorless$degree = as.numeric(salary.factorless$degree)
salary.factorless$field = as.numeric(salary.factorless$field)
salary.factorless$rank = as.numeric(salary.factorless$rank)
# Test factorless invocation
formula.1 = "logsal ~ startyr + admin + degree + field + rank + experience + gender + startyr:experience + admin:gender + degree:field + degree:experience + rank:experience"
# model = lm(formula, data=train)
mean.test.err = crossValidate(salary.factorless, formula.1, 10, "logsal")
#> mean.test.err
#[1] 0.2108294

model = glm(formula, family=gaussian, data=train)
mean.test.err = crossValidate(salary.factorless, formula.1, 10, "logsal")
#> mean.test.err
#[1] 0.2108294

model.lm = lm(formula, data=train)
model = step(model.lm, direction=c("backward"))
(crossValidate(salary.factorless, formula.1, 10, "logsal"))
#  0.2114162

model.lm = lm(formula, data=train)
model = step(model.lm, direction=c("backward"), k=log(length(train[,1])))
(crossValidate(salary.factorless, formula.1, 10, "logsal"))
# [1] 0.2120233

model.lm = lm(formula, data=train)
model = step(model.lm, direction=c("forward"))
(crossValidate(salary.factorless, formula.1, 10, "logsal"))
#[1] 0.2108294

model.lm = lm(formula, data=train)
model = step(model.lm, direction=c("forward"), k=log(length(train[,1])))
(crossValidate(salary.factorless, formula.1, 10, "logsal"))
#[1] 0.2108294

model = glm(formula, family=gaussian, data=train)
(crossValidate(salary.factorless, formula.1, 10, "logsal"))
#[1] 0.2108294

model.glm = glm(formula, family=gaussian, data=train)
model = step(model.glm, direction=c("backward"))
(crossValidate(salary.factorless, formula.1, 10, "logsal"))
#[1] 0.2114162

model.glm = glm(formula, family=gaussian, data=train)
model = step(model.glm, direction=c("forward"))
(crossValidate(salary.factorless, formula.1, 10, "logsal"))
#[1] 0.2108294













setwd("C:/Users/Rod/SkyDrive/R/201/Project")
library(foreign)

stata = read.dta("salary-stata.dta")
    
salary=data.frame(cbind(stata$salary, log(stata$salary), stata$startyr, stata$experience, stata$admin, stata$degree, stata$rank, stata$field, stata$sex))
#colnames(salary) = c("salary", "logsal", "startYr", "experience", "admin", "degree", "rank", "field", "gender")

salary$gender = factor(salary$gender)
salary$admin = factor(salary$admin)
salary$rank = factor(salary$rank)
salary$field = factor(salary$field)
salary$degree = factor(salary$degree)

salary.r = salary[names(salary) %in% c("logsal", "startYr", "experience", "admin", "degree", "rank", "field", "gender")]
# Must convert factors to numerics for cross validation.
salary.factorless = salary.r
salary.factorless$degree = as.numeric(salary.factorless$degree)
salary.factorless$field = as.numeric(salary.factorless$field)
salary.factorless$rank = as.numeric(salary.factorless$rank)

# 


cols = c(rgb(1,0,0,0.4), rgb(0,0,1, 0.4), rgb(0,1,0,0.4))

formula = "salary ~ .^2"
model.lm.0 = lm(formula, data=salary)
summary.lm(model.lm.0)
plot(salary$experience, (salary$salary), col=cols[salary$gender])
legend("topleft", legend=c("Female", "Male"), col=cols, pch=19)
abline(model.lm.0)

model.lm.1 = step(model.lm.0, direction="both")
summary.lm(model.lm.1)
plot(salary$experience, salary$salary, col=cols[salary$gender])
legend("topleft", legend=c("Female", "Male"), col=cols, pch=19)
abline(model.lm.1)

logformula = "logsal ~ .^2"
model.lm.2 = lm(logformula, data=logsal)
plot(logsal$experience, logsal$salary)
legend("topleft", legend=c("Female", "Male"), col=cols[logsal$gender], pch=19)
abline(model.lm.2)

plot(salary$experience, log(salary$salary), col=cols[salary$gender])
legend("topleft", legend=c("Female", "Male"), col=cols, pch=19)
abline(model.lm.1)

plot(salary$experience, salary$salary, col=cols[salary$gender])
legend("topright", legend=c("Female", "Male"), col=cols, pch=19)
 
# Select indices for training and testing.
nTrainingSamples = floor(0.7 * length(salary[,1]))
idxTrain = sample(1:length(salary[,1]), nTrainingSamples)
idxTest = setdiff(1:length(salary[,1]), idxTrain)


# Test new cross-validation function.
setwd("C:/Users/Rod/SkyDrive/R/201/Project")
library(foreign)

source("crossValidate.r")

stata = read.dta("salary-stata.dta")
   
salary=data.frame(cbind(stata$salary, log(stata$salary), stata$startyr, stata$experience, stata$admin, stata$degree, stata$rank, stata$field, stata$sex))
colnames(salary) = c("salary", "logsal", "startYr", "experience", "admin", "degree", "rank", "field", "gender")

salary$gender = factor(salary$gender)
salary$admin = factor(salary$admin)
salary$rank = factor(salary$rank)
salary$field = factor(salary$field)
salary$degree = factor(salary$degree)

salary.r = salary[names(salary) %in% c("logsal", "startYr", "experience", "admin", "degree", "rank", "field", "gender")]
salary.r.genderless = salary[names(salary) %in% c("logsal", "startYr", "experience", "admin", "degree", "rank", "field")]
idxFemale = which(salary.r$gender == 1)
idxMale = which(salary.r$gender == 2)

# Must convert factors to numerics for cross validation.
salary.factorless = salary.r
salary.factorless$degree = as.numeric(salary.factorless$degree)
salary.factorless$field = as.numeric(salary.factorless$field)
salary.factorless$rank = as.numeric(salary.factorless$rank)

# Test cross-validation 
formula = as.formula("logsal ~ .^2")
results = crossValidate(salary.factorless, formula, nSets=10, "logsal")
# Simple lm gives best result.
# See what interactions are important.
formula = as.formula("logsal ~ .^2")
model = lm(formula, data=salary.factorless)
summary.lm(model)


# A handy little function to visually render the fit.

# Tweak to add intercept argument...
 plotFit <- function(yObserved, yFitted, intercept=1) {
  plot(yObserved, yFitted)
  abline(intercept,1,lty=2, col=rgb(1,0,0))
  abline(-intercept,1,lty=2, col=rgb(1,0,0))
}  

plotFit(salary.factorless$logsal, fitted(model), 1.0)
# plotFit(exp(salary.factorless$logsal), exp(fitted(model)), 1)

model = lm(formula, data=salary.factorless)
summary.lm(model)

model.with.gender = lm(formula, data=salary.r)
model.sans.gender = lm(formula, data=salary.r.genderless)

cols = c(rgb(0,0,1,0.4), rgb(1,0,0, 0.4), rgb(0,1,0,0.4))

legend("topright", legend=c("Female", "Male"), col=cols, pch=19)
plot(salary$experience, log(salary$salary), col=cols[salary$gender])
abline(lm(log(salary) ~ experience, data=salary))

logsal.genderless = fitted(model.sans.gender)
logsal.genderless.female = logsal.genderless[idxFemale]
logsal.genderless.male = logsal.genderless[idxMale]


logsal.gender.female = salary.r$logsal[idxFemale]
logsal.gender.male = salary.r$logsal[idxMale]

plot(logsal.genderless.female - logsal.gender.female)
plot(logsal.genderless.male - logsal.gender.male)

cols = c(rgb(1,0,0,0.4), rgb(0,0,1, 0.4), rgb(0,0,1,0.4))
plot(logsal.genderless - salary.r$logsal, col=cols[salary.r$gender],
main="Genderless model log(salary) - observed log(salary)", 
xlab="Index", ylab="log(salary) difference")
legend("topright", legend=c("Female", "Male"), col=cols, pch=19)
abline(h=0)

length(which((logsal.genderless - salary.r$logsal) >= 0))  #842
length(which((logsal.genderless - salary.r$logsal) < 0))   #755

logsal.difference = logsal.genderless - salary.r$logsal
logsal.difference.female = logsal.difference[idxFemale]
logsal.difference.male = logsal.difference[idxMale]
length(which(logsal.difference.female >= 0))  #261
length(which(logsal.difference.female < 0))   #148 

length(which(logsal.difference.male >= 0))  #581
length(which(logsal.difference.male < 0))   #607

predictors = salary[names(salary) %in% c("startYr", "experience", "admin", "degree", "rank", "field", "gender")]
x = as.matrix(as.numeric(predictors))
y = as.numeric(salary$logsal)

p = predictors
x = cbind(predictors$startYr, predictors$experience, predictors$admin, predictors$degree, predictors$rank, predictors$field, predictors$gender)
x = cbind(predictors$startYr, predictors$experience)
model = lars(x, y)
plotFit(y, fitted(model))

x = cbind( predictors$experience)
model = lars(x, y)
plotFit(y, fitted(model))
model = lm(salary.r$logsal ~ salary.r$experience)
plotFit(salary.r$logsal, fitted(model))

library(splines)
model = lm(logsal ~ bs(experience, df=1) + bs(degree, df=1), data=salary.r)
plotFit(salary.r$logsal, fitted(model))

model = lm(logsal ~ bs(experience, df=1) + bs(degree, df=4), data=salary.r)
plotFit(salary.r$logsal, fitted(model))

model = lm(logsal ~ bs(startYr, df=1) + bs(experience, df=1) + bs(admin, df=1) + bs(degree, df=1) + bs(rank, df=1) + bs(field, df=1) + bs(gender, df=1), data=salary.r )
plotFit(salary.r$logsal, fitted(model), 0.7)

model = lm(logsal ~ ., data=salary.r)
plotFit(salary.r$logsal, fitted(model), 0.7)

model = lm(logsal ~ .^2, data=salary.r)
plotFit(salary.r$logsal, fitted(model), 0.7)

library(leaps)
x1 <- regsubsets(x, y)
?regsubsets
x1 <- regsubsets(logsal ~ ., data=salary.r)
summary(x1)
summary(x1)
x2 <- regsubsets(logsal ~ .^2, data=salary.r)
x2 <- regsubsets(logsal ~ .^2, data=salary.r, really.big=TRUE)
par(mfrow=c(2,2))
plot(x1)
summary(x2)


# Project code
# Test new cross-validation function.
setwd("C:/Users/Rod/SkyDrive/R/201/Project")
library(foreign)

source("crossValidate.r")

stata = read.dta("salary-stata.dta")
   
salary=data.frame(cbind(stata$salary, log(stata$salary), stata$startyr, stata$experience, stata$admin, stata$degree, stata$rank, stata$field, stata$sex))
colnames(salary) = c("salary", "logsal", "startYr", "experience", "admin", "degree", "rank", "field", "gender")

salary$gender = factor(salary$gender)
salary$admin = factor(salary$admin)
salary$rank = factor(salary$rank)
salary$field = factor(salary$field)
salary$degree = factor(salary$degree)

salary.r = salary[names(salary) %in% c("logsal", "startYr", "experience", "admin", "degree", "rank", "field", "gender")]
# Divide salary.r into a training set and a test set.
nRowsSalary = length(salary.r)
nRowsSalary = length(salary.r[,1])
nRowsSalary
nRowsTrain = floor(0.75 * nRowsSalary)
nRowsTrain
idxTrain = sample(1:nRowsSalary, nRowsTrain, replace=FALSE)
idxTest = setdiff(1:nRowsSalary, idxTrain)
length(idxTrain)
salary.train = salary.r[idxTrain,]
salary.test = salary.r[idxTest,]


str(salary.train)
#'data.frame':   1197 obs. of  8 variables:
# $ logsal    : num  8.78 8.35 8.78 8.32 8.34 ...
# $ startYr   : num  93 76 87 91 92 80 90 84 91 88 ...
# $ experience: num  2 24 17 6 3 22 16 14 7 18 ...
# $ admin     : Factor w/ 2 levels "0","1": 1 1 1 1 1 2 1 1 1 1 ...
# $ degree    : Factor w/ 3 levels "1","2","3": 1 1 1 1 1 2 1 1 1 3 ...
# $ rank      : Factor w/ 3 levels "1","2","3": 1 2 3 1 1 2 1 3 1 3 ...
# $ field     : Factor w/ 3 levels "1","2","3": 3 1 3 3 3 3 2 3 1 1 ...
# $ gender    : Factor w/ 2 levels "1","2": 2 2 2 1 1 2 2 1 2 1 ...

salary.train$admin = as.numeric(salary.train$admin)
salary.train$degree = as.numeric(salary.train$degree)
salary.train$field = as.numeric(salary.train$field)
salary.train$rank = as.numeric(salary.train$rank)
salary.train$gender = as.numeric(salary.train$gender)

# Convert salary.train to factorless so it will work with cross-validation.
# Must convert factors to numerics for cross validation.
salary.train.factorless = salary.train
salary.train.factorless$admin = as.numeric(salary.train.factorless$admin)
salary.train.factorless$degree = as.numeric(salary.train.factorless$degree)
salary.train.factorless$field = as.numeric(salary.train.factorless$field)
salary.train.factorless$rank = as.numeric(salary.train.factorless$rank)
salary.train.factorless$gender = as.numeric(salary.train.factorless$gender)

# Convert salary.test to factorless so it will work with cross-validation.
# Must convert factors to numerics for cross validation.
salary.test.factorless = salary.test
salary.test.factorless$admin = as.numeric(salary.test.factorless$admin)
salary.test.factorless$degree = as.numeric(salary.test.factorless$degree)
salary.test.factorless$field = as.numeric(salary.test.factorless$field)
salary.test.factorless$rank = as.numeric(salary.test.factorless$rank)
salary.test.factorless$gender = as.numeric(salary.test.factorless$gender)

str(salary.train.factorless)
#'data.frame':   1597 obs. of  8 variables:
# $ logsal    : num  8.81 8.49 8.35 9.41 8.43 ...
# $ startYr   : num  95 94 95 91 71 95 87 80 64 69 ...
# $ experience: num  3 4 -1 29 25 20 13 27 31 27 ...
# $ admin     : num  1 1 1 1 1 1 1 1 1 1 ...
# $ degree    : num  3 3 1 1 1 1 1 1 1 1 ...
# $ rank      : num  1 1 1 3 2 1 2 3 3 3 ...
# $ field     : num  3 3 3 3 3 3 3 1 3 2 ...
# $ gender    : num  1 2 2 2 2 2 2 2 2 2 ...

# Summarize the data as a sanity check.
plot(1:length(salary.train.factorless$logsal), sort(salary.train.factorless$logsal))
table(salary.train.factorless$startyr)
table(salary.train.factorless$experience)
table(salary.train.factorless$admin)
table(salary.train.factorless$degree)
table(salary.train.factorless$rank)
table(salary.train.factorless$field)
table(salary.train.factorless$gender)

# Divide the data set into predictors (x) and results (y).
predictors = salary.train.factorless[names(salary.train.factorless) %in% c("startYr", "experience", "admin", "degree", "rank", "field", "gender")]
x = cbind(predictors$startYr, predictors$experience, predictors$admin, predictors$degree, predictors$rank, predictors$field, predictors$gender)
y = as.numeric(salary.train.factorless$logsal)

# Use the leaps library function regsubsets to see what's interesting.
library(leaps)
priorities <- regsubsets(logsal ~ ., data=salary.train.factorless)
summary(priorities)

# From these results, I conclude that the order to add covariates to the model is:
# 1.	rank
# 2.	admin
# 3.	gender
# 4.	degree  
# 5.	(experience, startYr)
# 6.	field 

formula.lm = as.formula("logsal ~ (rank + admin + gender)^2")
formula.lm.bs = as.formula(logsal ~ bs(rank, df=3) + bs(admin, df=3) + bs(gender, df=3))
results = crossValidate(salary.train.factorless, formula.lm, formula.lm.bs, nSets=10, "logsal")
> results
#                      description rms.error
# 1                       model=lm 0.2175399
# 2                      model=glm 0.2175399
# 3    model=lm, step=forward, AIC 0.2175399
# 4   model=lm, step=backward, AIC 0.2177437
# 5    model=lm, step=forward, BIC 0.2175399
# 6   model=lm, step=backward, BIC 0.2175649
# 7   model=glm, step=forward, AIC 0.2175399
# 8  model=glm, step=backward, AIC 0.2177437
# 9   model=glm, step=forward, BIC 0.2175399
# 10 model=glm, step=backward, BIC 0.2175649
# 11                   model=lm.bs 0.2137611
formula.lm = as.formula("logsal ~ (rank + admin + gender + degree)^2")
formula.lm.bs = as.formula(logsal ~ bs(rank, df=3) + bs(admin, df=3) + bs(gender, df=3) + bs(degree, df=3))
results = crossValidate(salary.train.factorless, formula.lm, formula.lm.bs, nSets=10, "logsal")

formula.lm = as.formula("logsal ~ (rank + admin + gender + degree + experience)^2")
formula.lm.bs = as.formula(logsal ~ bs(rank, df=3) + bs(admin, df=3) + bs(gender, df=3) + bs(degree, df=3 ) + bs(experience, df=3))
results = crossValidate(salary.train.factorless, formula.lm, formula.lm.bs, nSets=10, "logsal")

# Get a visual appreciation of the difference between models.
formula.lm.bs = as.formula(logsal ~ bs(rank, df=3) + bs(admin, df=3) + bs(gender, df=3) + bs(degree, df=3 ) + bs(experience, df=3) + bs(startYr, df=3) + bs(field, df=3) )
model = lm(formula.lm.bs, data=salary.train.factorless)

 plotFit <- function(yObserved, yFitted, intercept=1) {
  plot(yObserved, yFitted)
  abline(intercept,1,lty=2, col=rgb(1,0,0))
  abline(-intercept,1,lty=2, col=rgb(1,0,0))
} 

plotFit(salary.train.factorless$logsal, fitted(model), 0.7)

# How many df are necessary?
formula.lm.bs = as.formula(logsal ~ bs(rank, df=1) + bs(admin, df=1) + bs(gender, df=1) + bs(degree, df=1 ) + bs(experience, df=1) + bs(startYr, df=1) + bs(field, df=1))
model = lm(formula.lm.bs, data=salary.train.factorless)
# All are updated to 3.

# Prediction
# str(salary.train.factorless)
# 'data.frame':   1597 obs. of  8 variables:
#  $ logsal    : num  8.81 8.49 8.35 9.41 8.43 ...
#  $ startYr   : num  95 94 95 91 71 95 87 80 64 69 ...
#  $ experience: num  3 4 -1 29 25 20 13 27 31 27 ...
#  $ admin     : num  1 1 1 1 1 1 1 1 1 1 ...
#  $ degree    : num  3 3 1 1 1 1 1 1 1 1 ...
#  $ rank      : num  1 1 1 3 2 1 2 3 3 3 ...
#  $ field     : num  3 3 3 3 3 3 3 1 3 2 ...
#  $ gender    : num  1 2 2 2 2 2 2 2 2 2 ...
 
formula.lm.bs = as.formula(logsal ~ bs(rank, df=3) + bs(admin, df=3) + bs(gender, df=3) + bs(degree, df=3 ) + bs(experience, df=3) + bs(startYr, df=3) + bs(field, df=3))
model.lm.bs = lm(formula.lm.bs, data=salary.train.factorless) 
 
# Prediction - plot train data and test data.
 plotFit <- function(yObserved, yFitted, intercept=1) {
  plot(yObserved, yFitted)
  abline(intercept,1,lty=2, col=rgb(1,0,0))
  abline(-intercept,1,lty=2, col=rgb(1,0,0))
}
par(mfrow=c(1,2))
plot(salary.test.factorless$experience, predict(model.lm.bs, salary.test.factorless), col=rgb(0,1,0),
	xlab="Experience [Years]", ylab="log(salary) [$US 1995]", main="Observed (Train) and Fitted (Test) Data")
points(salary.train.factorless$experience, salary.train.factorless$logsal, col=rgb(0,0,1)) 
legend("topleft", legend=c("Test", "Train"), col=c(rgb(0,1,0), rgb(0,0,1)), pch=19)

plotFit(salary.test.factorless$logsal, predict(model.lm.bs, salary.test.factorless) )
 
# Prediction for gender bias.
range.startYr = c(min(salary.train.factorless$startYr), max(salary.train.factorless$startYr))
range.experience = c(min(salary.train.factorless$experience), max(salary.train.factorless$experience))
range.admin = c(min(salary.train.factorless$admin), max(salary.train.factorless$admin))
range.degree = c(min(salary.train.factorless$degree), max(salary.train.factorless$degree))
range.rank = c(min(salary.train.factorless$rank), max(salary.train.factorless$rank))
range.field = c(min(salary.train.factorless$field), max(salary.train.factorless$field))
range.gender = c(min(salary.train.factorless$gender), max(salary.train.factorless$gender)) #1 = female

# Create a dataframe of female new hires of all degrees and experience years.
female.new.hires <- data.frame(startYr = numeric(), experience=numeric(), admin=numeric(), 
						degree=numeric(), rank=numeric(), field=numeric(), gender=numeric())
for (degree in range.degree[1]:range.degree[2]) {
	for (experience in range.experience[1]:range.experience[2]) {
		new.row <- data.frame(	startYr=range.startYr[2], 
								experience=experience, 
								admin=range.admin[1],
								degree=degree,
								rank=range.rank[1], 
								field=range.field[1], 
								gender=range.gender[1] )
		female.new.hires <- rbind(female.new.hires, new.row)
	}
}	

# Create a dataframe of male new hires of all degrees and experience years.
male.new.hires <- data.frame(startYr = numeric(), experience=numeric(), admin=numeric(), 
						degree=numeric(), rank=numeric(), field=numeric(), gender=numeric())
for (degree in range.degree[1]:range.degree[2]) {
	for (experience in range.experience[1]:range.experience[2]) {
		new.row <- data.frame(	startYr=range.startYr[2], 
								experience=experience, 
								admin=range.admin[1],
								degree=degree,
								rank=range.rank[1], 
								field=range.field[1], 
								gender=range.gender[2] )
		male.new.hires <- rbind(male.new.hires, new.row)
	}
}
								
cols = c(rgb(0,0,1,0.8), rgb(1,0,0, 0.8), rgb(0,1,0,0.8))

# Predict with train dataset and plot new employee data.
par(mfrow=c(1,2))
plot(female.new.hires$experience, predict(model.lm.bs, female.new.hires),
		xlab="Experience [Years]", 
		ylab="Predicted log(salary) 1995 $US", 
		main="Predicted New Hire Salaries (Females)",
		col=cols[female.new.hires$degree]) 		
legend("topleft", legend=c("BS,MS", "PhD", "Professional"), col=cols, pch=19)
						
plot(male.new.hires$experience, predict(model.lm.bs, male.new.hires),
		xlab="Experience [Years]", 
		ylab="Predicted log(salary) 1995 $US", 
		main="Predicted New Hire Salaries (Males)",
		col=cols[male.new.hires$degree])
legend("topleft", legend=c("BS,MS", "PhD", "Professional"), col=cols, pch=19)		

# Is there gender bias?
salary.r = salary[names(salary) %in% c("logsal", "startYr", "experience", "admin", "degree", "rank", "field", "gender")]
salary.r.genderless = salary[names(salary) %in% c("logsal", "startYr", "experience", "admin", "degree", "rank", "field")]
idxFemale = which(salary.r$gender == 1)
idxMale = which(salary.r$gender == 2)

salary.r$admin = as.numeric(salary.r$admin)
salary.r$degree = as.numeric(salary.r$degree)
salary.r$field = as.numeric(salary.r$field)
salary.r$rank = as.numeric(salary.r$rank)
salary.r$gender = as.numeric(salary.r$gender)

model.with.gender = lm(logsal ~ bs(rank, df=3) + 
								bs(admin, df=3) + 
								bs(gender, df=3) + 
								bs(degree, df=3 ) + 
								bs(experience, df=3) + 
								bs(startYr, df=3) + 
								bs(field, df=3),
								data=salary.r)
model.sans.gender = lm(logsal ~ bs(rank, df=3) + 
								bs(admin, df=3) + 
								bs(degree, df=3 ) + 
								bs(experience, df=3) + 
								bs(startYr, df=3) + 
								bs(field, df=3),
								data=salary.r)
								
cols = c(rgb(0,0,1,0.4), rgb(1,0,0, 0.4), rgb(0,1,0,0.4))

logsal.genderless = fitted(model.sans.gender)
logsal.genderless.female = logsal.genderless[idxFemale]
logsal.genderless.male = logsal.genderless[idxMale]

logsal.gender.female = salary.r$logsal[idxFemale]
logsal.gender.male = salary.r$logsal[idxMale]

plot(logsal.genderless.female - logsal.gender.female)
plot(logsal.genderless.male - logsal.gender.male)
cols = c(rgb(1,0,0,0.4), rgb(0,0,1, 0.4), rgb(0,0,1,0.4))
plot(logsal.genderless - salary.r$logsal, col=cols[salary.r$gender],
main="Genderless model log(salary) - observed log(salary)", 
xlab="Index", ylab="log(salary) difference")
legend("topright", legend=c("Female", "Male"), col=cols, pch=19)
abline(h=0)

length(which((logsal.genderless - salary.r$logsal) >= 0))  #850
length(which((logsal.genderless - salary.r$logsal) < 0))   #747

logsal.difference = logsal.genderless - salary.r$logsal
logsal.difference.female = logsal.difference[idxFemale]
logsal.difference.male = logsal.difference[idxMale]
length(which(logsal.difference.female >= 0))  #263
length(which(logsal.difference.female < 0))   #146 

length(which(logsal.difference.male >= 0))  #587
length(which(logsal.difference.male < 0))   #601




# Create a dataframe of female ten year employees (started in 1985)
female.startYr.85 <- data.frame(startYr = numeric(), experience=numeric(), admin=numeric(), 
						degree=numeric(), rank=numeric(), field=numeric(), gender=numeric())
for(degree in range.degree[1]:range.degree[2]) {
	for (experience in range.experience[1]:range.experience[2]) {
		new.row <- data.frame(	startYr=85, 
								experience=experience, 
								admin=range.admin[1],
								degree=degree,
								rank=range.rank[1], 
								field=range.field[1], 
								gender=range.gender[1] )
		female.startYr.85 <- rbind(female.startYr.85, new.row)
	}
}	

# Create a dataframe of male ten year employees (started in 1985)
male.startYr.85 <- data.frame(startYr = numeric(), experience=numeric(), admin=numeric(), 
						degree=numeric(), rank=numeric(), field=numeric(), gender=numeric())
for (degree in range.degree[1]:range.degree[2]) {
	for (experience in range.experience[1]:range.experience[2]) {
		new.row <- data.frame(	startYr=range.startYr[2], 
								experience=experience, 
								admin=range.admin[1],
								degree=degree,
								rank=range.rank[1], 
								field=range.field[1], 
								gender=range.gender[2] )
		male.startYr.85 <- rbind(male.startYr.85, new.row)
	}
}

# Predict with train dataset and plot new employee data.
par(mfrow=c(1,2))
plot(female.new.hires$experience, predict(model.lm.bs, female.startYr.85),
		xlab="Experience [Years]", 
		ylab="Predicted log(salary) 1995 $US", 
		main="Predicted Salaries (Females who started in 1985)",
		col=cols[female.startYr.85$degree]) 		
legend("topleft", legend=c("BS,MS", "PhD", "Professional"), col=cols, pch=19)
						
plot(male.new.hires$experience, predict(model.lm.bs, male.startYr.85),
		xlab="Experience [Years]", 
		ylab="Predicted log(salary) 1995 $US", 
		main="Predicted Salaries (Males who started in 1985)",
		col=cols[male.startYr.85$degree])
legend("topleft", legend=c("BS,MS", "PhD", "Professional"), col=cols, pch=19)
