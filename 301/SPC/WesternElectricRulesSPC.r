setwd("C:/Users/Rod/SkyDrive/R/301/SPC")

#------------------------------------------------------------------------------
#' classifyByWesternElectricRuleZones.numeric
#' @param x a vector of numeric values that are to be classified into Western Electric Rule zones
#' @param x.bar the mean value to be used for classification.  Is NULL by default.  Calculated as necessary.
#' @param sigma the standard deviation to be used for classification.  Is NULL by default.  Calculated as necessary.
#' @return a vector with these positive/negative values: |4| = outlier, |3| = zone A, |2| = zone B, |1| = zone C, 0 = x.bar
#' @examples x = c(3.1, 2.1, 1.1, 0.1, 0, -0.1, -1.1, -2.1, -3.1)
#' @examples x.bar = 0
#' @examples sigma = 1
#' @examples xclass = classifyByWesternElectricRuleZones.numeric(x, x.bar, sigma)
#' @examples (xclass)
#' @examples [1]  4  3  2  1  0 -1 -2 -3 -4
classifyByWesternElectricRuleZones.numeric <- function(x, x.bar = NULL, sigma = NULL) {
  if (is.null(x.bar) || is.null(sigma)) {
	x.bar = mean(x)
	sigma = sd(x)
  }

  # Identify the zone of each point.	
  gt.pos.three.sigma = which(x > (x.bar + (3 * sigma)))
  gt.pos.two.sigma = which(x > (x.bar + (2 * sigma)))
  gt.pos.one.sigma = which(x > (x.bar + sigma))
  gt.xbar = which(x > x.bar)
  eq.xbar = which(x == x.bar)
  lt.x.bar = which(x < x.bar)
  lt.neg.one.sigma = which(x < (x.bar - sigma))
  lt.neg.two.sigma = which(x < (x.bar - (2 * sigma)))
  lt.neg.three.sigma = which(x < (x.bar - (3 * sigma)))
   
  outliers = union(gt.pos.three.sigma, lt.neg.three.sigma)
  
  pos.A = setdiff(gt.pos.two.sigma, gt.pos.three.sigma)
  pos.B = setdiff(gt.pos.one.sigma, gt.pos.two.sigma)
  pos.C = setdiff(gt.xbar, gt.pos.one.sigma)
  
  neg.C = setdiff(lt.x.bar, lt.neg.one.sigma)
  neg.B = setdiff(lt.neg.one.sigma, lt.neg.two.sigma)
  neg.A = setdiff(lt.neg.two.sigma, lt.neg.three.sigma)
  
  zones = numeric(length(x))
  zones[gt.pos.three.sigma] = 4
  zones[pos.A] = 3
  zones[pos.B] = 2
  zones[pos.C] = 1
  zones[eq.xbar] = 0
  zones[neg.C] = -1
  zones[neg.B] = -2
  zones[neg.A] = -3
  zones[lt.neg.three.sigma] = -4 

  return(zones);
}

# x = c(3.1, 3.0,  2.1, 2.0, 1.1, 1.0,  0.1, 0, -0.1, -1.0, -1.1, -2.0, -2.1, -3.0, -3.1)
# x.bar = 0
# sigma = 1
# xclass = classifyByWesternElectricRuleZones.numeric(x, x.bar, sigma)
# (xclass)

#------------------------------------------------------------------------------
#' classifyByWesternElectricRuleZones
#' @param x a vector of numeric values that are to be classified into Western Electric Rule zones
#' @param x.bar the mean value to be used for classification.  Is NULL by default.  Calculated as necessary.
#' @param sigma the standard deviation to be used for classification.  Is NULL by default.  Calculated as necessary.
#' @return a vector with these values: 'O' = outlier, 'A' = zone A, 'B' = zone B, 'C' = zone C
#' @examples x = c(3.1, 2.1, 1.1, 0.1, 0, -0.1, -1.1, -2.1, -3.1)
#' @examples x.bar = 0
#' @examples sigma = 1
#' @examples xclass = classifyByWesternElectricRuleZones(x, x.bar, sigma)
#' @examples (xclass)
#' @examples [1] "O" "A" "B" "C" "C" "C" "B" "A" "O"
classifyByWesternElectricRuleZones <- function(x, x.bar=NULL, sigma=NULL) {
  zones.numeric = classifyByWesternElectricRuleZones.numeric(x, x.bar, sigma)
  
  zone.A = union(which(zones.numeric == 3), which(zones.numeric == -3))
  zone.B = union(which(zones.numeric == 2), which(zones.numeric == -2))
  zone.C = union(which(zones.numeric == 1), which(zones.numeric == -1))
  zone.C = union(zone.C, which(zones.numeric == 0))
  zone.Outlier = union(which(zones.numeric == 4), which(zones.numeric == -4))
  
  zones = character(length(x))
  zones[zone.A] = 'A'
  zones[zone.B] = 'B'
  zones[zone.C] = 'C'
  zones[zone.Outlier] = 'O'  

  return(zones); 
}

# x = c(3.1, 2.1, 1.1, 0.1, 0, -0.1, -1.1, -2.1, -3.1)
# x = c(3.1, 3.0,  2.1, 2.0, 1.1, 1.0,  0.1, 0, -0.1, -1.0, -1.1, -2.0, -2.1, -3.0, -3.1)
# x.bar = 0
# sigma = 1
# xclass = classifyByWesternElectricRuleZones(x, x.bar, sigma)
# (xclass)

#------------------------------------------------------------------------------
#' logWesternElectricRuleViolation
#' @param results a (possibly empty) dataframe with these numeric columns:  idxInitial, idxFinal, rule
#' @param idxInitial the index of the value in the source vector where a violation was initially detected
#' @param idxFinal the index of the value in the source vector where the violation was last detected
#' @param rule the Western Electric Rule number that was violated in the range idxInitial:idxFinal (inclusive)
#' @return the original results dataframe with one additional row added to it
#' @examples results <- data.frame(idxInitial = numeric(), idxFinal = numeric(), rule = numeric())
#' @examples results <- logWesternElectricRuleViolation(results, 5, 5, 1)
#' @examples results <- logWesternElectricRuleViolation(results, 2, 4, 2) 
#' @examples results <- logWesternElectricRuleViolation(results, 6, 10, 3)
#' @examples results <- logWesternElectricRuleViolation(results, 11, 19, 4)
#' @examples (results) 
logWesternElectricRuleViolation <- function(results, idxInitial, idxFinal, rule) {
	result <- data.frame(idxInitial=idxInitial, idxFinal=idxFinal, rule=rule)
	results <- rbind(results, result)
	
	return(results);
} 	

# results <- data.frame(idxInitial = numeric(), idxFinal = numeric(), rule = numeric())
# results <- logWesternElectricRuleViolation(results, 5, 5, 1)
# results <- logWesternElectricRuleViolation(results, 2, 4, 2) 
# results <- logWesternElectricRuleViolation(results, 6, 10, 3)
# results <- logWesternElectricRuleViolation(results, 11, 19, 4)
# (results)

#------------------------------------------------------------------------------
#' findWesternElectricRuleViolations
#' @param x a vector of numeric values that are to be classified into Western Electric Rule zones
#' @param x.bar the mean value to be used for classification.  Is NULL by default.  Calculated as necessary.
#' @param sigma the standard deviation to be used for classification.  Is NULL by default.  Calculated as necessary.
#' @return a (possibly empty) dataframe with these numeric columns:  idxInitial, idxFinal, rule
findWesternElectricRuleViolations <- function(x, x.bar = NULL, sigma = NULL) {
	if (is.null(x.bar) || is.null(sigma)) {
		x.bar = mean(x)
		sigma = sd(x)
    }
	
	 # Create an empty dataframe to store results.
	results <- data.frame(idxInitial = numeric(), idxFinal = numeric(), rule = numeric())
	
	nItems = length(x)
	zones.numeric = classifyByWesternElectricRuleZones.numeric(x, x.bar, sigma)
	
	#--------------------------------------------------------------------------
	# Test for Rule 4 violation.
	# This is 9 consecutive points that fall on the same side
	# of the centerline (Zone C or beyond).
	#--------------------------------------------------------------------------
	minRunLen = 9
	for (idxInitial in 1:(nItems - minRunLen + 1)) {
	
		idxFinal = (idxInitial + minRunLen - 1)
	
		if ( (all(zones.numeric[idxInitial:idxFinal] > 0)) ||
		     (all(zones.numeric[idxInitial:idxFinal] < 0)) )
		{
			results = logWesternElectricRuleViolation(results, idxInitial, idxFinal, 4)
		}
	}
	
	#--------------------------------------------------------------------------
	# Test for Rule 3 violation.
	# This is 4 out of 5 points that fall beyond the 1 sigma
	# limit (Zone B or beyond) on the same side of the centerline.
	#--------------------------------------------------------------------------
	minRunLen = 5
	for (idxInitial in 1:(nItems - minRunLen + 1)) 
	{
		idxFinal = (idxInitial + minRunLen - 1)
			
		# Do an initial screen to determine if any points are in zone B
		if ( (any(zones.numeric[idxInitial:idxFinal] > 1)) ||
			 (any(zones.numeric[idxInitial:idxFinal] < -1)) ) 
		{	 
			# Some of the data in the range are in zone B.  Investigate.
			countZoneB = 0
			countOpposite = 0
			matched = 0
			
			# Test the positive case.
			for (i in idxInitial:idxFinal) {
				if (zones.numeric[i] > 1) { countZoneB = countZoneB + 1 }
				else if (zones.numeric[i] < 0) { countOpposite = countOpposite + 1 }
			}
			
			# Did it match?
			if ((countZoneB == 4) && (countOpposite == 1)) {
				matched = 1
			}
			
			# If not matched, test the negative case.
			if (matched == 0) {
				countZoneB = 0
				countOpposite = 0
				
				for (i in idxInitial:idxFinal) {
					if (zones.numeric[i] < -1) { countZoneB = countZoneB + 1 }
					else if (zones.numeric[i] > 0) { countOpposite = countOpposite + 1 }
					
					if ((countZoneB == 4) && (countOpposite == 1)) {
						matched = 1
					}
				}
			}
            
			# If positive or negative match detected, log it.
			if (matched == 1) { 
				results = logWesternElectricRuleViolation(results, idxInitial, idxFinal, 3) 
			}	
		}
	}
	
	#--------------------------------------------------------------------------
	# Test for Rule 2 violation.
	# This is 2 out of 3 consecutive points that fall beyond the 2 sigma
	# limit (Zone B or beyond) on the same side of the centerline.
	#--------------------------------------------------------------------------
	minRunLen = 3
	for (idxInitial in 1:(nItems - minRunLen + 1)) 
	{
		idxFinal = (idxInitial + minRunLen - 1)
			
		# Do an initial screen to determine if any points are in zone A
		if ( (any(zones.numeric[idxInitial:idxFinal] > 2)) ||
			 (any(zones.numeric[idxInitial:idxFinal] < -2)) ) 
		{	 
			# Some of the data in the range are in zone A.  Investigate.
			countZoneA = 0
			countSameSide = 0
			matched = 0
			
			# Test the positive case.
			for (i in idxInitial:idxFinal) {
				if (zones.numeric[i] > 2) { countZoneA = countZoneA + 1 }
				else if (zones.numeric[i] > 0) { countSameSide = countSameSide + 1 }
			}
			
			# Did it match?
			if ((countZoneA == 2) && (countSameSide == 1)) {
				matched = 1
			}
			
			# If not matched, test the negative case.
			if (matched == 0) {
				countZoneA = 0
				countSameSide = 0
				
				for (i in idxInitial:idxFinal) {
					if (zones.numeric[i] < -2) { countZoneA = countZoneA + 1 }
					else if (zones.numeric[i] < 0) { countSameSide = countSameSide + 1 }
					
					if ((countZoneB == 2) && (countSameSide == 1)) {
						matched = 1
					}
				}
			}
			
			# If positive or negative match detected, log it.
			if (matched == 1) { 
				results = logWesternElectricRuleViolation(results, idxInitial, idxFinal, 2) 
			}	
		}	
	}
	
	#--------------------------------------------------------------------------
	# Test for Rule 1 violation.
	# This is any point that falls beyond the 3 sigma limit (Zone C or beyond).
	#--------------------------------------------------------------------------
	violations = sort(union(which(zones.numeric == 4), which(zones.numeric == -4)))
	if (length(violations) > 0) {
		for (i in 1:length(violations)) {
			results = logWesternElectricRuleViolation(results, violations[i], violations[i], 1)
		}
	}
	return(results);
}
 
# x.bar = 0 
# sigma = 1	
# x = c(0, 1.1,1.2,1.1,  1.3,1.4,1.3, 1.4,1.5,1.4, 0,  1.1,-1.0,1.1,1.2,1.1, 0.0, 2.2,1.1,2.3, 0, 4.1, -4.1)

# results =  findWesternElectricRuleViolations(x, x.bar, sigma)
# (results)

#------------------------------------------------------------------------------
#' plotSpcChart
#' @param batchAverages a vector of numeric values that contains the average value of a series of batches. 
#' @param batchRanges a vector of numeric values that contains the range of value of a series of batches.  Must be of the same length as batchAverages. 
#' @param x.bar.batchAverages the mean value to be used for classification of batchAverages.  Is NULL by default.  Calculated as necessary.
#' @param sigma.batchAverages the standard deviation value to be used for classification of batchAverages.  Is NULL by default.  Calculated as necessary.
#' @param x.bar.batchRanges the mean value to be used for classification of batchAverages.  Is NULL by default.  Calculated as necessary.
#' @param sigma.batchRanges the standard deviation value to be used for classification of batchRanges.  Is NULL by default.  Calculated as necessary.
#' @param sigma the standard deviation to be used for classification of batchRanges.  Is NULL by default.  Calculated as necessary.
#' @return a dataframe with these numeric columns:  batchAverage, state.batchAverage, batchRange, state.batchRange
plotSpcChart <- function(batchAverages, batchRanges, x.bar.batchAverages = NULL, sigma.batchAverages = NULL, x.bar.batchRanges = NULL, sigma.batchRanges = NULL)
{
	if ((is.null(x.bar.batchAverages)) || (is.null(sigma.batchAverages)) ) {
		x.bar.batchAverages = mean(batchAverages)
		sigma.batchAverages = sd(batchAverages)
	}
	
	if ((is.null(x.bar.batchRanges)) || (is.null(sigma.batchRanges))) {
		x.bar.batchRanges = mean(batchRanges)
		sigma.batchRanges = sd(batchRanges)
	}
	
	# Find SPC violations in batch averages.
	spc.violations.batchAverages =  findWesternElectricRuleViolations(batchAverages, x.bar.batchAverages, sigma.batchAverages)
	
	# Find SPC violations in batch ranges.
	spc.violations.batchRanges =  findWesternElectricRuleViolations(batchRanges, x.bar.batchRanges, sigma.batchRanges)
	
	# Create a vector of all batch average SPC states.  Set state (rule) to 0 by default.
	spc.state.batchAverages = rep(0, length(batchAverages))
	if (length(spc.violations.batchAverages[,1]) > 0) {
		for( i in 1:length(spc.violations.batchAverages[,1])) {
			spc.state.batchAverages[spc.violations.batchAverages$idxInitial[i]:spc.violations.batchAverages$idxFinal[i]] = spc.violations.batchAverages$rule[i]
		}
	}
	
	# Create a vector of all batch range SPC states.  Set state (rule) to 0 by default.
	spc.state.batchRanges = rep(0, length(batchRanges))
	if (length(spc.violations.batchRanges[,1]) > 0) {
		for( i in 1:length(spc.violations.batchRanges[,1])) {
			spc.state.batchRanges[spc.violations.batchRanges$idxInitial[i]:spc.violations.batchRanges$idxFinal[i]] = spc.violations.batchRanges$rule[i]
		}
	}
		
	# Create a dataframe of values and SPC states.
	spcData = data.frame(batchAverage = numeric(), state.batchAverage = numeric() ) #, batchRange=numeric(), state.batchRange=numeric())
	for (i in 1:length(batchAverages)) {
		nextRow = data.frame(	batchAverage=batchAverages[i], 
								state.batchAverage=spc.state.batchAverages[i],
								batchRange=batchRanges[i],
								state.batchRange=spc.state.batchRanges[i] )
		spcData <- rbind(spcData, nextRow)
	}

	# Colors to use in plots.
	#            black           green              yellow          orange            red         purple
	# cols = c(rgb(0,0,0,0.4), rgb(0,0,1,0.4), rgb(1,1,0,0.4), rgb(1,0.6,0,0.4), rgb(0,0,1,0.4), rgb(1,0,1,0.4))
	#            green           yellow          orange            red             purple
	cols = c(rgb(0,1,0,0.6), rgb(1,1,0,0.6), rgb(1,0.6,0,0.6), rgb(0,0,1,0.6), rgb(1,0,1,0.6))
	prevOp <- par(fig=c(0,1,0.5,1))
	par(mar=c(0,5,2,2))
	par(cex=0.64)
		 
	plot(spcData$batchAverage, col=cols[spcData$state.batchAverage + 1], 
		xlab="", 
		xaxt="n", 
		type="b",
		main="SPC Chart",
		ylab="Batch Averages", 
		pch=19)
	legend("topleft", horiz=TRUE, legend=c("In Control", "Rule 1", "Rule 2", "Rule 3", "Rule 4"), col=cols, pch=19)
	abline(h = x.bar.batchAverages)	
	abline(h = (x.bar.batchAverages + (1 * sigma.batchAverages)), lty="dashed", col=rgb(0,0,0,0.4))
	abline(h = (x.bar.batchAverages + (2 * sigma.batchAverages)), lty="dashed", col=rgb(0,0,0,0.4))
	abline(h = (x.bar.batchAverages + (3 * sigma.batchAverages)), lty="dashed", col=rgb(0,0,0,0.4))
	abline(h = (x.bar.batchAverages - (1 * sigma.batchAverages)), lty="dashed", col=rgb(0,0,0,0.4))
	abline(h = (x.bar.batchAverages - (2 * sigma.batchAverages)), lty="dashed", col=rgb(0,0,0,0.4))
	abline(h = (x.bar.batchAverages - (3 * sigma.batchAverages)), lty="dashed", col=rgb(0,0,0,0.4))
		
	par(fig=c(0,1,0,0.5), new=TRUE)
	par(mar=c(5,5,0,2))
	
	plot(spcData$batchRange, col=cols[spcData$state.batchRange + 1], 
		xlab="",
		ylab="Batch Ranges",
		type="b",	
		pch=19)
	abline(h = x.bar.batchRanges)	
	abline(h = (x.bar.batchRanges + (1 * sigma.batchRanges)), lty="dashed", col=rgb(0,0,0,0.4))
	abline(h = (x.bar.batchRanges + (2 * sigma.batchRanges)), lty="dashed", col=rgb(0,0,0,0.4))
	abline(h = (x.bar.batchRanges + (3 * sigma.batchRanges)), lty="dashed", col=rgb(0,0,0,0.4))
	abline(h = (x.bar.batchRanges - (1 * sigma.batchRanges)), lty="dashed", col=rgb(0,0,0,0.4))
	abline(h = (x.bar.batchRanges - (2 * sigma.batchRanges)), lty="dashed", col=rgb(0,0,0,0.4))
	abline(h = (x.bar.batchRanges - (3 * sigma.batchRanges)), lty="dashed", col=rgb(0,0,0,0.4))
		
	par(prevOp)
	
	return(spcData)
}	

batchAverages = c(0, 1.1,1.2,1.1,  1.3,1.4,1.3, 1.4,1.5,1.4,   0,  1.1,-1,1.1,1.2,1.1,   0,  2.2,1.1,2.3,   0,   4.1, -4.1)
x.bar.batchAverages = 0 
sigma.batchAverages = 1

batchRanges = numeric(length(batchAverages))
x.bar.batchRanges = 10
sigma.batchRanges = 1.0
for (i in 1:length(batchRanges)) { batchRanges[i] = x.bar.batchRanges + rnorm(1, 0, 0.5) }

spcSampleData = plotSpcChart(batchAverages, batchRanges, x.bar.batchAverages, sigma.batchAverages, x.bar.batchRanges, sigma.batchRanges)

rm(i)
rm(batchAverages)
rm(x.bar.batchAverages)
rm(sigma.batchAverages)

rm(batchRanges)
rm(x.bar.batchRanges)
rm(sigma.batchRanges)


#------------------------------------------------------------------------------
	
	