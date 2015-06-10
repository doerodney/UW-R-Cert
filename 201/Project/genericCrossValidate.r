ds = read.csv("foo.csv")

formula = as.formula("y ~ .^2")

model = lm(formula, data=train)
rmsErr = crossValidate(ds, model, nSets=10, "yName")

#model = glm(formula, family=gaussian, data=train)
rmsErr = crossValidate(ds, model, nSets=10, "yName")

#model.lm = lm(formula, data=train)
#model = step(model.lm, direction=c("backward"))
rmsErr = crossValidate(ds, model, nSets=10, "yName")

#model = step(model.lm, direction=c("backward"), k=log(length(train[,1])))
rmsErr = crossValidate(ds, model, nSets=10, "yName")

#model = step(model.lm, direction=c("forward"), k=log(length(train[,1])))
rmsErr = crossValidate(ds, model, nSets=10, "yName")

#model = step(model.lm, direction=c("forward"))
rmsErr = crossValidate(ds, model, nSets=10, "yName")

#model = glm(formula, family=gaussian, data=train)
rmsErr = crossValidate(ds, model, nSets=10, "yName")

#model.glm = glm(formula, family=gaussian, data=train)
rmsErr = crossValidate(ds, model, nSets=10, "yName")

#model = step(model.glm, direction=c("backward"))
rmsErr = crossValidate(ds, model, nSets=10, "yName")

#model = step(model.glm, direction=c("forward"))
rmsErr = crossValidate(ds, model, nSets=10, "yName")
	



# Cross-validation function
crossValidate <- function(ds, model, nSets=10, yvalue) {
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