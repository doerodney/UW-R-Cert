plotSpcChart <-
function(batchAverages, batchRanges, x.bar.batchAverages = NULL, sigma.batchAverages = NULL, x.bar.batchRanges = NULL, sigma.batchRanges = NULL)
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
