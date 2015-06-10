# Cross-validation code
# Cross-validation function
crossValidate.glm <- function(ds, formula, nSets, yvalue) { 
  strDesc = "model=glm"
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
	model = glm(formula, family=gaussian, data=train)
		
	# Calculate rms error for this test set.
	test.yhat <- predict.lm(object=model, newdata=test)
    test.y <- with(test, get(yvalue))
    test.err <- sqrt(mean((test.yhat - test.y)^2))

    # Accumulate test error * size of test set. 	
	total.test.err = total.test.err + test.err
  }      	

  mean.test.err = total.test.err / nSets
  
  # Return a dataframe of result information.
  result <- data.frame(description=strDesc, rms.error=mean.test.err)
  
  result
}


# Cross-validation function
crossValidate.glm.step <- function(ds, formula, nSets, yvalue, step.direction="both", use.AIC=TRUE) {
  strDesc = ""
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
	model.glm = glm(formula, family=gaussian, data=train)
	
	if (use.AIC == TRUE) { 
		model = step(model.glm, direction=c(step.direction))
		strDesc = sprintf("model=glm, step=%s, AIC", step.direction)
	}
	else {	
		model = step(model.glm, direction=c(step.direction), k=log(length(train[,1])))
		strDesc = sprintf("model=glm, step=%s, BIC", step.direction)
	}
	
	# Calculate rms error for this test set.
	test.yhat <- predict.lm(object=model, newdata=test)
    test.y <- with(test, get(yvalue))
    test.err <- sqrt(mean((test.yhat - test.y)^2))

    # Accumulate test error * size of test set. 	
	total.test.err = total.test.err + test.err
  }      	

  mean.test.err = total.test.err / nSets

  # Return a dataframe of result information.
  result <- data.frame(description=strDesc, rms.error=mean.test.err)
  
  result
}

# Cross-validation function for linear model with basic splines.
crossValidate.lm.bs <- function(ds, formula, nSets, yvalue) {
  strDesc = "model=lm.bs"
  nRows = length(ds[,1])
  nRowsPerSet = floor(nRows / nSets)
  
  # Load the splines library.
  library(splines)
    
  # Accumulate the total test error.
  total.test.err = 0
  
  # Iterate through the data set, dividing into a 
  # test dataset and training data sets.
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
		
	# Calculate rms error for this test set.
	test.yhat <- predict.lm(object=model, newdata=test)
    test.y <- with(test, get(yvalue))
    test.err <- sqrt(mean((test.yhat - test.y)^2))

    # Accumulate test error * size of test set. 	
	total.test.err = total.test.err + test.err
  }      	

  mean.test.err = total.test.err / nSets
  
  # Return a dataframe of result information.
  result <- data.frame(description=strDesc, rms.error=mean.test.err)
  
  result
}

# Cross-validation function for linear model.
crossValidate.lm <- function(ds, formula, nSets, yvalue) {
  strDesc = "model=lm"
  nRows = length(ds[,1])
  nRowsPerSet = floor(nRows / nSets)
    
  # Accumulate the total test error.
  total.test.err = 0
  
  # Iterate through the data set, dividing into a 
  # test dataset and training data sets.
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
		
	# Calculate rms error for this test set.
	test.yhat <- predict.lm(object=model, newdata=test)
    test.y <- with(test, get(yvalue))
    test.err <- sqrt(mean((test.yhat - test.y)^2))

    # Accumulate test error * size of test set. 	
	total.test.err = total.test.err + test.err
  }      	

  mean.test.err = total.test.err / nSets
  
  # Return a dataframe of result information.
  result <- data.frame(description=strDesc, rms.error=mean.test.err)
  
  result
}

# Cross-validation function for linear model with step
crossValidate.lm.step <- function(ds, formula, nSets, yvalue, step.direction="both", use.AIC=TRUE) {
  strDesc = ""
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
	model.lm = lm(formula, data=train)
	
	model = step(model.lm, direction=c("backward"))
	if (use.AIC == TRUE) { 
		model = step(model.lm, direction=c(step.direction))
		strDesc = sprintf("model=lm, step=%s, AIC", step.direction)
	}
	else {	
		model = step(model.lm, direction=c(step.direction), k=log(length(train[,1])))
		strDesc = sprintf("model=lm, step=%s, BIC", step.direction)
	}
	
	# Calculate rms error for this test set.
	test.yhat <- predict.lm(object=model, newdata=test)
    test.y <- with(test, get(yvalue))
    test.err <- sqrt(mean((test.yhat - test.y)^2))

    # Accumulate test error * size of test set. 	
	total.test.err = total.test.err + test.err
  }      	

  mean.test.err = total.test.err / nSets
  
  # Return a dataframe of result information.
  result <- data.frame(description=strDesc, rms.error=mean.test.err)
  
  result	
}

#source("crossValidate.lm.r")
#source("crossValidate.glm.r")
#source("crossValidate.lm.step.r")
#source("crossValidate.glm.step.r")
#source("crossValidate.lm.bs.r")

# General cross-validation function
crossValidate <- function(ds, formula.lm, formula.spline.bs, nSets=10, yvalue) {
  nSets <- ifelse(nSets == 0, 10, nSets) # no divide by zero...
  
  # Create an empty dataframe to store results.
  results <- data.frame(description=character(), rms.error=numeric())
  
  # Cross-validate linear model.
  result <-crossValidate.lm(ds, formula.lm, nSets, yvalue)
  results <- rbind(results, result)

  # Cross-validate generalized linear model.
  result <- crossValidate.glm(ds, formula.lm, nSets, yvalue)
  results <- rbind(results, result)  
  
 # Cross-validate linear model with forward step, AIC
  result <- crossValidate.lm.step(ds, formula.lm, nSets, yvalue, step.direction="forward", use.AIC=TRUE)  
  results <- rbind(results, result)

  # Cross-validate linear model with backward step, AIC
  result <- crossValidate.lm.step(ds, formula.lm, nSets, yvalue, step.direction="backward", use.AIC=TRUE)  
  results <- rbind(results, result)
   
  # Cross-validate linear model with forward step, BIC
  result <- crossValidate.lm.step(ds, formula.lm, nSets, yvalue, step.direction="forward", use.AIC=FALSE)  
  results <- rbind(results, result)  
  
  # Cross-validate linear model with backward step, BIC
  result <- crossValidate.lm.step(ds, formula.lm, nSets, yvalue, step.direction="backward", use.AIC=FALSE)  
  results <- rbind(results, result)
  
   # Cross-validate generalized linear model with forward step, AIC
  result <- crossValidate.glm.step(ds, formula.lm, nSets, yvalue, step.direction="forward", use.AIC=TRUE)  
  results <- rbind(results, result)

  # Cross-validate generalized linear model with backward step, AIC
  result <- crossValidate.glm.step(ds, formula.lm, nSets, yvalue, step.direction="backward", use.AIC=TRUE)  
  results <- rbind(results, result)
   
  # Cross-validate generalized linear model with forward step, BIC
  result <- crossValidate.glm.step(ds, formula.lm, nSets, yvalue, step.direction="forward", use.AIC=FALSE)  
  results <- rbind(results, result)  
  
  # Cross-validate generalized linear model with backward step, BIC
  result <- crossValidate.glm.step(ds, formula.lm, nSets, yvalue, step.direction="backward", use.AIC=FALSE)  
  results <- rbind(results, result)
  
  # Cross-validate generalized linear model with basic spline
  result = crossValidate.lm.bs(ds, formula.spline.bs,  nSets, yvalue) 
  results <- rbind(results, result)
  
  # Return results dataframe
  results
}   
 

###############################################################################
# Project code
setwd("C:/Users/Rod/SkyDrive/R/201/Project")
library(foreign)

# All crossValidate.r code is copied above, due to 3 file submission limit.
# source("crossValidate.r")

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
 
# Prediction for Model Evaluation
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
 

# Evidence of Gender Bias – A Simple Experiment
salary.r = salary[names(salary) %in% c("logsal", "startYr", "experience", "admin", "degree", "rank", "field", "gender")]
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

par(mfcol=c(1,1))
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
abline(h=log(4000))			
plot(male.new.hires$experience, predict(model.lm.bs, male.new.hires),
		xlab="Experience [Years]", 
		ylab="Predicted log(salary) 1995 $US", 
		main="Predicted New Hire Salaries (Males)",
		col=cols[male.new.hires$degree])
legend("topleft", legend=c("BS,MS", "PhD", "Professional"), col=cols, pch=19)		
abline(h=log(4000))


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
		new.row <- data.frame(	startYr=85, 
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
plot(female.startYr.85$experience, predict(model.lm.bs, female.startYr.85),
		xlab="Experience [Years]", 
		ylab="Predicted log(salary) 1995 $US", 
		main="Predicted Salaries (Females who started in 1985)",
		col=cols[female.startYr.85$degree]) 		
legend("topleft", legend=c("BS,MS", "PhD", "Professional"), col=cols, pch=19)
abline(h=log(4000))
plot(male.startYr.85$experience, predict(model.lm.bs, male.startYr.85),
		xlab="Experience [Years]", 
		ylab="Predicted log(salary) 1995 $US", 
		main="Predicted Salaries (Males who started in 1985)",
		col=cols[male.startYr.85$degree])
legend("topleft", legend=c("BS,MS", "PhD", "Professional"), col=cols, pch=19)
abline(h=log(4000))


library(gam)
formula.gam.bs = as.formula(logsal ~ bs(rank, df=3) + bs(admin, df=3) + bs(gender, df=3) + bs(degree, df=3 ) + bs(experience, df=3) + bs(startYr, df=3) + bs(field, df=3))
model.gam.bs = gam(formula.lm.bs, data=salary.train.factorless) 

par(mfrow=c(1,3))
plot(model.gam.bs, se=TRUE)

library(gam)
formula.gam.bs = as.formula(logsal ~ rank + admin + gender + degree + bs(experience, df=3) + bs(startYr, df=3) + field)
model.gam.bs = gam(formula.lm.bs, data=salary.train.factorless) 

par(mfrow=c(2,4))
plot(model.gam.bs, se=TRUE)

formula.xlm.bs = as.formula(logsal ~ (rank + admin + gender + degree + field)^2 + bs(experience, df=3) + bs(startYr, df=3))
model.xlm.bs = gam(formula.xlm.bs, data=salary.train.factorless) 
formula.lm = as.formula("logsal ~ (rank + admin + gender + degree)^2")
formula.xlm.bs = as.formula(logsal ~ (rank + admin + gender + degree + field)^2 + bs(experience, df=3) + bs(startYr, df=3))
# formula.lm.bs = as.formula(logsal ~ bs(rank, df=3) + bs(admin, df=3) + bs(gender, df=3) + bs(degree, df=3))
results = crossValidate(salary.train.factorless, formula.lm, formula.xlm.bs, nSets=10, "logsal")
