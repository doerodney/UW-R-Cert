source("crossValidate.lm.r")
source("crossValidate.glm.r")
source("crossValidate.lm.step.r")

# General cross-validation function
crossValidate <- function(ds, formula, nSets=10, yvalue) {
  nSets <- ifelse(nSets == 0, 10, nSets) # no divide by zero...
  
  # Create an empty dataframe to store results.
  results <- data.frame(description=character(), rms.error=numeric())
  
  # Cross-validate linear model.
  result <-crossValidate.lm(ds, formula, nSets, yvalue)
  results <- rbind(results, result)

  # Cross-validate generalized linear model.
  result <- crossValidate.glm(ds, formula, nSets, yvalue)
  results <- rbind(results, result)  
  
 # Cross-validate linear model with forward step, AIC
  result <- crossValidate.lm.step(ds, formula, nSets, yvalue, step.direction="forward", use.AIC=TRUE)  
  results <- rbind(results, result)

  # Cross-validate linear model with backward step, AIC
  result <- crossValidate.lm.step(ds, formula, nSets, yvalue, step.direction="backward", use.AIC=TRUE)  
  results <- rbind(results, result)
   
  # Cross-validate linear model with forward step, BIC
  result <- crossValidate.lm.step(ds, formula, nSets, yvalue, step.direction="forward", use.AIC=FALSE)  
  results <- rbind(results, result)  
  
  # Cross-validate linear model with backward step, BIC
  result <- crossValidate.lm.step(ds, formula, nSets, yvalue, step.direction="backward", use.AIC=FALSE)  
  results <- rbind(results, result)
  
  # Return results dataframe
  results
}   
 