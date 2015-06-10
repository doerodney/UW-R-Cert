setwd("C:/Users/Rod/SkyDrive/R/101/Week08")
CLT <- function(FUN, n, k=1000, ..., hist.args = NULL)
{
	Y <- rep(0, k)
	for(i in 1:n) { Y <- Y + FUN(k, ...) }
	par(mfrow=c(1,2))
	# Make hist indicate density, not counts.
	do.call(hist, c(list(x=quote(Y)), prob=TRUE, hist.args))
	# Generate data with which to plot a normal distribution around the sampled data.
	nx = seq(from = mean(Y) - 3*sd(Y), to = mean(Y) + 3 * sd(Y), length.out=100)
	ny = dnorm(nx, mean(Y), sd(Y))
	# Plot a normal curve on top of the data.
	lines(nx, ny, col=2)
	qqnorm(Y); qqline(Y, col=2)
}


CLT(rbeta, n=1, shape1=0.5, shape2=0.5)
CLT(rbeta, n=2, shape1=0.5, shape2=0.5)
CLT(rbeta, n=10, shape1=0.5, shape2=0.5)
CLT(rbeta, n=20, shape1=0.5, shape2=0.5)

CLT(rbeta, n=1, shape1=0.5, shape2=1.0)
CLT(rbeta, n=2, shape1=0.5, shape2=1.0)
CLT(rbeta, n=10, shape1=0.5, shape2=1.0)
CLT(rbeta, n=20, shape1=0.5, shape2=1.0)

SampleMean <- function(X, n=30, k=10000, ...)
{
	X.bar <- c()
	for(i in 1:k) { X.bar <- c(X.bar, mean(sample(X, n))) }
	hist(X.bar, prob=TRUE, ...)
	nx = seq(from = mean(X) - 3*sd(X), to = mean(X) + 3 * sd(X), length.out=100)
	ny = dnorm(nx, mean(X), sd(X))
	# Plot a normal curve on top of the data.
	lines(nx, ny, col=2)
}

SampleMean(dT.mins, n=5, k=1000, main="dT.Mins sample size = 5")
SampleMean(dT.mins, n=10, k=1000, main="dT.Mins sample size = 10")
SampleMean(dT.mins, n=30, k=1000, main="dT.Mins sample size = 30")
SampleMean(dT.mins, n=100, k=1000, main="dT.Mins sample size = 100")


eq <- read.csv("http://neic.usgs.gov/neis/gis/qed.asc")

Date <- strptime(eq$Date, format="%Y/%m/%d")
Time <- strptime(eq$Time, format="%H:%M:%S")
	# see the help file for "strptime" for interpretation of format definitions
		
	# Note that the "Time" interprets this as today!
	
DateTime <- strptime(paste(eq$Date, eq$Time), format="%Y/%m/%d %H:%M:%S")
range(DateTime)
diff(DateTime)
		
# note, this is in seconds.  That was a choice made by R
D.mins <- difftime(DateTime[-1], DateTime[-length(DateTime)], units="mins")
		
hist(-as.numeric(D.mins), breaks=100, col="grey", freq=FALSE)
curve(dexp(x, -1/mean(as.numeric(D.mins))), add=TRUE, n=10000, lwd=2, col=2)
    

eq <- read.csv("http://neic.usgs.gov/neis/gis/qed.asc")
DateTime <- strptime(paste(eq$Date, eq$Time), format="%Y/%m/%d %H:%M:%S")
D.mins <- difftime(DateTime[-1], DateTime[-length(DateTime)], units="mins")
curve(dnorm(x, mean =-mean(D.mins), sd=sd(D.mins)/sqrt(30)), xlim=c(0,100))
abline(v=15, lwd=2)
pnorm(15, -mean(D.mins), sd(D.mins)/sqrt(30))

curve(dnorm(x, mean =-mean(D.mins), sd=sd(D.mins)/sqrt(100)), xlim=c(0,100))
abline(v=15, lwd=2)
pnorm(15, -mean(D.mins), sd(D.mins)/sqrt(100))

peq = numeric(30)
for (i in 1:30) { peq[i] = pnorm(15, -mean(D.mins), sd(D.mins)/sqrt(i)) }

