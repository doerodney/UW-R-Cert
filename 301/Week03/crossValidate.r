source("crossValidate.bic.glm.r")

# General cross-validation function
crossValidate <- function(ds, formula, nSets=5, yvalue) {
  nSets <- ifelse(nSets == 0, 10, nSets) # no divide by zero...
  
  # Create an empty dataframe to store results.
  results <- data.frame(description=character(), rms.error=numeric())
  
  # Cross-validate bic.glm (Bayesian Model Averaging).
  for ( OR.value in c(5, 10, 20, 50, 100) ) {
	result <-crossValidate.bic.glm(ds, formula, nSets, OR.value, TRUE, yvalue)
	results <- rbind(results, result)
  }

  result <-crossValidate.bic.glm(ds, formula, nSets, 20, FALSE, yvalue)
  results <- rbind(results, result)
 	
  # Return results dataframe
  results
}   
 