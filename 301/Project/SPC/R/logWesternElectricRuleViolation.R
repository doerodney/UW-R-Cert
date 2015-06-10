logWesternElectricRuleViolation <-
function(results, idxInitial, idxFinal, rule) {
	result <- data.frame(idxInitial=idxInitial, idxFinal=idxFinal, rule=rule)
	results <- rbind(results, result)
	
	return(results);
}
