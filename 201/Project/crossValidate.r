source("crossValidate.lm.r")
source("crossValidate.glm.r")
source("crossValidate.lm.step.r")
source("crossValidate.glm.step.r")
source("crossValidate.lm.bs.r")

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
 