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