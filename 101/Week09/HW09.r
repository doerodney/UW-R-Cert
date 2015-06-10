setwd("C:/Users/Rod/SkyDrive/R/101/Week09")

earthquakes <- read.csv("http://neic.usgs.gov/neis/gis/qed.asc")
DateTime <- strptime(paste(earthquakes$Date, earthquakes$Time),
format="%Y/%m/%d %H:%M:%S")
W <- difftime(DateTime[-length(DateTime)], DateTime[-1], units="mins")
W.5 <- sample(W,5)
W.10 <-sample(W,10)
W.30 <- sample(W,30)

GetCI <- function(X, sd, confidencePercent, bootstrap=FALSE, bootstrap.sample.size = 30, bootstrap.iterations = 10000) {
	n = length(X)
	stdErr = sd / sqrt(n)  # standard error of the mean.
	meanX = mean(X)
	upper = meanX
	lower = meanX	
	ci = 0
	alpha = (1 - (confidencePercent/100)) / 2
	
	if (bootstrap == FALSE) {
		# Use theoretical distributions.
		
		# Determine which theoretical distribution to use.
		if (n < 30) {
			# Use Student's t distribution for small samples.
			dof = n - 1
			tValue = qt(1 - alpha, dof)
			ci = tValue * stdErr 	
		} else {
			# Use the normal distribution for large samples.
			zValue = qnorm(1 - alpha, meanX, sd, lower.tail=TRUE)
			ci = zValue * stdErr
		}
		upper = as.numeric(meanX + ci)
		lower = as.numeric(meanX - ci)
	}
	else {
		# Get a bootstrap confidence interval.
		a <- numeric(bootstrap.iterations)
		for (i in 1:bootstrap.iterations) {
			a[i] = mean(sample(X, bootstrap.sample.size, replace=TRUE))
		}	
		lower = as.numeric(quantile(a, alpha))
		upper = as.numeric(quantile(a, 1 - alpha))
		ci = NA
	}
	list(mean=meanX, ci=ci, percent=confidencePercent, n=n, alpha=alpha, lower=lower, upper=upper) 
}



trueSigma = 38
trueMean = 29
spanTrueMean = numeric(10000)
for (i in 1:length(spanTrueMean))
{
	W.X <- sample(W,5)
	r = GetCI(W.X, trueSigma, 95)
	if ((r$lower < trueMean) && (r$upper > trueMean)) {spanTrueMean[i] = TRUE}
	else {spanTrueMean[i] = FALSE}
}	
length(which(spanTrueMean == TRUE))	

trueSigma = 38
trueMean = 29
spanTrueMean = numeric(10000)
for (i in 1:length(spanTrueMean))
{
	W.X <- sample(W,10)
	r = GetCI(W.X, trueSigma, 95)
	if ((r$lower < trueMean) && (r$upper > trueMean)) {spanTrueMean[i] = TRUE}
	else {spanTrueMean[i] = FALSE}
}
length(which(spanTrueMean == TRUE))

trueSigma = 38
trueMean = 29
spanTrueMean = numeric(10000)
for (i in 1:length(spanTrueMean))
{
	W.X <- sample(W,30)
	r = GetCI(W.X, trueSigma, 95)
	if ((r$lower < trueMean) && (r$upper > trueMean)) {spanTrueMean[i] = TRUE}
	else {spanTrueMean[i] = FALSE}
}	
length(which(spanTrueMean == TRUE))

trueSigma = 38
trueMean = 29
spanTrueMean = numeric(10000)
for (i in 1:length(spanTrueMean))
{
	W.X <- sample(W,30)
	r = GetCI(W.X, trueSigma, 95)
	if ((r$lower < trueMean) && (r$upper > trueMean)) {spanTrueMean[i] = TRUE}
	else {spanTrueMean[i] = FALSE}
}	
length(which(spanTrueMean == TRUE))	