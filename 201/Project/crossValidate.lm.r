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