\name{plotSpcChart}
\alias{plotSpcChart}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
plotSpcChart
}
\description{
Plots a standard Statistical Process Control (SPC) of a series of data average values and ranges. 
}
\usage{
plotSpcChart(batchAverages, batchRanges, x.bar.batchAverages = NULL, sigma.batchAverages = NULL, x.bar.batchRanges = NULL, sigma.batchRanges = NULL)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{batchAverages}{
 a vector of numeric values that contains the average value of a series of batches
}
  \item{batchRanges}{
 a vector of numeric values that contains the range of value of a series of batches.  Must be of the same length as batchAverages. 
}
  \item{x.bar.batchAverages}{
the mean value to be used for classification of batchAverages.  Is NULL by default.  Calculated as necessary.
}
  \item{sigma.batchAverages}{
the standard deviation value to be used for classification of batchAverages.  Is NULL by default.  Calculated as necessary.
}
  \item{x.bar.batchRanges}{
the mean value to be used for classification of batchAverages.  Is NULL by default.  Calculated as necessary.
}
  \item{sigma.batchRanges}{
the standard deviation value to be used for classification of batchRanges.  Is NULL by default.  Calculated as necessary.
}
}
\details{
	Given a process in which batch average values and ranges of values are recorded, this function applies the standard Western Electric Rules
    to the data to determine SPC compliance.  The batch averages and ranges are plotted in colors associated with their SPC status.  A green
	datum indicates that the process is in control.  A non-green datum indicates a rule violation and warrants a response by the process owner.
	For specific information about the Western Electric Rules, see the associated wikipedia article. 
}
\value{
a dataframe with these numeric columns:  batchAverage, state.batchAverage, batchRange, state.batchRange
}
\references{
google wikipedia Western Electric Rules.  For a deeper dive, see 'Statistical Process Control' by Donald Wheeler.
}
\author{
Rod Doe
}
\note{
Not only is travel at the speed of light impossible, it would be highly inconvenient because one's hat would frequently blow off.
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
 None
}
\examples{
## batchAverages = c(0, 1.1,1.2,1.1,  1.3,1.4,1.3, 1.4,1.5,1.4,   0,  1.1,-1,1.1,1.2,1.1,   0,  2.2,1.1,2.3,   0,   4.1, -4.1)
## x.bar.batchAverages = 0 
## sigma.batchAverages = 1
## batchRanges = numeric(length(batchAverages))
## x.bar.batchRanges = 10
## sigma.batchRanges = 1.0
## for (i in 1:length(batchRanges)) { batchRanges[i] = x.bar.batchRanges + rnorm(1, 0, 0.5) }
## result = plotSpcChart(batchAverages, batchRanges, x.bar.batchAverages, sigma.batchAverages, x.bar.batchRanges, sigma.batchRanges)
## (result)


## The function is currently defined as
function (batchAverages, batchRanges, x.bar.batchAverages = NULL, 
    sigma.batchAverages = NULL, x.bar.batchRanges = NULL, sigma.batchRanges = NULL) 
{
    if ((is.null(x.bar.batchAverages)) || (is.null(sigma.batchAverages))) {
        x.bar.batchAverages = mean(batchAverages)
        sigma.batchAverages = sd(batchAverages)
    }
    if ((is.null(x.bar.batchRanges)) || (is.null(sigma.batchRanges))) {
        x.bar.batchRanges = mean(batchRanges)
        sigma.batchRanges = sd(batchRanges)
    }
    spc.violations.batchAverages = findWesternElectricRuleViolations(batchAverages, 
        x.bar.batchAverages, sigma.batchAverages)
    spc.violations.batchRanges = findWesternElectricRuleViolations(batchRanges, 
        x.bar.batchRanges, sigma.batchRanges)
    spc.state.batchAverages = rep(0, length(batchAverages))
    if (length(spc.violations.batchAverages[, 1]) > 0) {
        for (i in 1:length(spc.violations.batchAverages[, 1])) {
            spc.state.batchAverages[spc.violations.batchAverages$idxInitial[i]:spc.violations.batchAverages$idxFinal[i]] = spc.violations.batchAverages$rule[i]
        }
    }
    spc.state.batchRanges = rep(0, length(batchRanges))
    if (length(spc.violations.batchRanges[, 1]) > 0) {
        for (i in 1:length(spc.violations.batchRanges[, 1])) {
            spc.state.batchRanges[spc.violations.batchRanges$idxInitial[i]:spc.violations.batchRanges$idxFinal[i]] = spc.violations.batchRanges$rule[i]
        }
    }
    spcData = data.frame(batchAverage = numeric(), state.batchAverage = numeric())
    for (i in 1:length(batchAverages)) {
        nextRow = data.frame(batchAverage = batchAverages[i], 
            state.batchAverage = spc.state.batchAverages[i], 
            batchRange = batchRanges[i], state.batchRange = spc.state.batchRanges[i])
        spcData <- rbind(spcData, nextRow)
    }
    cols = c(rgb(0, 1, 0, 0.6), rgb(1, 1, 0, 0.6), rgb(1, 0.6, 
        0, 0.6), rgb(0, 0, 1, 0.6), rgb(1, 0, 1, 0.6))
    prevOp <- par(fig = c(0, 1, 0.5, 1))
    par(mar = c(0, 5, 2, 2))
    par(cex = 0.64)
    plot(spcData$batchAverage, col = cols[spcData$state.batchAverage + 
        1], xlab = "", xaxt = "n", type = "b", main = "SPC Chart", 
        ylab = "Batch Averages", pch = 19)
    legend("topleft", horiz = TRUE, legend = c("In Control", 
        "Rule 1", "Rule 2", "Rule 3", "Rule 4"), col = cols, 
        pch = 19)
    abline(h = x.bar.batchAverages)
    abline(h = (x.bar.batchAverages + (1 * sigma.batchAverages)), 
        lty = "dashed", col = rgb(0, 0, 0, 0.4))
    abline(h = (x.bar.batchAverages + (2 * sigma.batchAverages)), 
        lty = "dashed", col = rgb(0, 0, 0, 0.4))
    abline(h = (x.bar.batchAverages + (3 * sigma.batchAverages)), 
        lty = "dashed", col = rgb(0, 0, 0, 0.4))
    abline(h = (x.bar.batchAverages - (1 * sigma.batchAverages)), 
        lty = "dashed", col = rgb(0, 0, 0, 0.4))
    abline(h = (x.bar.batchAverages - (2 * sigma.batchAverages)), 
        lty = "dashed", col = rgb(0, 0, 0, 0.4))
    abline(h = (x.bar.batchAverages - (3 * sigma.batchAverages)), 
        lty = "dashed", col = rgb(0, 0, 0, 0.4))
    par(fig = c(0, 1, 0, 0.5), new = TRUE)
    par(mar = c(5, 5, 0, 2))
    plot(spcData$batchRange, col = cols[spcData$state.batchRange + 
        1], xlab = "", ylab = "Batch Ranges", type = "b", pch = 19)
    abline(h = x.bar.batchRanges)
    abline(h = (x.bar.batchRanges + (1 * sigma.batchRanges)), 
        lty = "dashed", col = rgb(0, 0, 0, 0.4))
    abline(h = (x.bar.batchRanges + (2 * sigma.batchRanges)), 
        lty = "dashed", col = rgb(0, 0, 0, 0.4))
    abline(h = (x.bar.batchRanges + (3 * sigma.batchRanges)), 
        lty = "dashed", col = rgb(0, 0, 0, 0.4))
    abline(h = (x.bar.batchRanges - (1 * sigma.batchRanges)), 
        lty = "dashed", col = rgb(0, 0, 0, 0.4))
    abline(h = (x.bar.batchRanges - (2 * sigma.batchRanges)), 
        lty = "dashed", col = rgb(0, 0, 0, 0.4))
    abline(h = (x.bar.batchRanges - (3 * sigma.batchRanges)), 
        lty = "dashed", col = rgb(0, 0, 0, 0.4))
    par(prevOp)
    return(spcData)
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
