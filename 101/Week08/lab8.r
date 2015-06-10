# StatR 101
# Eli Gurarie
# Lab 8

#################################################
# Pramble on Earthquakes, Volcanoes, and Plates
#################################################
  
# Recall the "maps" package we loaded once upon a time.  
# We can use this package to very quickly and easily map 
# the location of earthquakes world-wide

# These are the data I downloaded last week:
	eq <- read.csv("http://faculty.washington.edu/eliezg/data/earthquakes.csv")

# Here, I found ALL epicenters (including < magnitude 2) over the past month
	
	eq <- read.csv("http://neic.usgs.gov/neis/gis/qed.asc")

  require(maps)
  map("world", fill=TRUE, col="grey", bor="grey")
	
# It is extremely easy to add geographic locations to a map
	points(eq$Lon, eq$Lat)
	
# You can make them more informative by scaling according to magnitude
	map("world", fill=TRUE, col="grey", bor="grey")
  points(eq$Lon, eq$Lat, cex=eq$Mag/5, pch=19, col=rgb(.2,.2,.7,.2))
	
# From this website, I also downloaded a summary of global  volcanoes:
#	 	http://www.volcano.si.edu/world/list_allnames.htm
	
	vol <- read.csv("http://faculty.washington.edu/eliezg/data/volcanoes.csv")
  points(vol$LON, vol$LAT, pch=17, col=rgb(1,0,0,.2))
	box()

	
# Plate boundary data here are here: http://www.ig.utexas.edu/research/projects/plates/data.htm
# It would be nice to load these data directly from this repository, but this requires some playing around

	# Load the raw data - making it only one column (separate with tab, "\t", though there are no tabs)
		ridge.raw <- read.table("ftp://ftp.ig.utexas.edu/pub/PLATES/Data/plate_boundaries/ridge.gmt", sep="\t")	
	# Create a dummy data.frame that will contain our "x" and "y" coordinates
		ridge <- data.frame(x=rep(NA, nrow(ridge.raw)), y=NA)
	# Fill them with the fixed with substring of the data.  Notice that the header entries ("> Name of Ridge") become NA's
		ridge$x <- as.numeric(substr(ridge.raw[,1],1,10))
	# Only thing to note here is that the "substring()" function does not require a stopping point
		ridge$y <- as.numeric(substring(ridge.raw[,1],12))
		
	# Now, do the same with trenches and transform plates
		trench.raw <- read.table("ftp://ftp.ig.utexas.edu/pub/PLATES/Data/plate_boundaries/trench.gmt", sep="\t")
		trench <- data.frame(x=rep(NA, nrow(trench.raw)), y=NA)
		trench$x <- as.numeric(substr(trench.raw[,1],1,10))
		trench$y <- as.numeric(substring(trench.raw[,1],12))
		
		transform.raw <- read.table("ftp://ftp.ig.utexas.edu/pub/PLATES/Data/plate_boundaries/transform.gmt", sep="\t")
		transform <- data.frame(x=rep(NA, nrow(transform.raw)), y=NA)
		transform$x <- as.numeric(substr(transform.raw[,1],1,10))
		transform$y <- as.numeric(substring(transform.raw[,1],12))

	# OK, lets map these
		map("world", fill=TRUE, col="grey", bor="grey")
		lines(ridge, col=2)
		lines(trench, col=3)
		lines(transform, col=4)
		
	# If you don't like the cross international dateline, we can filter these out of the "ridge" and "trench" data
		trench$x[abs(diff(trench$x))>180] <- NA
		ridge$x[abs(diff(ridge$x))>180] <- NA
	
	# Try again
		win.graph(16,12)
		
		map("world", fill=TRUE, col="grey", bor="grey")
		lines(ridge, col="darkblue", lwd=2)
		lines(trench, col="darkred", lwd=2)
		lines(transform, col="darkgreen", lwd=2)
		
		points(eq$Lon, eq$Lat, cex = eq$Mag/5, pch=19, col=rgb(0,.5,.5,.3))
		points(vol$LON, vol$LAT, pch=17, col=rgb(.5,0,.5,.3))
		
	# This is, I think, a very informative visualization of tectonic activity on Earth. 
		
		box()
		
	# Note that the data repositories are presumably updated regularly, so 
	# every time you run this code, you will get an updated visual.
	
	# A comment on dates:
	
		Date <- strptime(eq$Date, format="%Y/%m/%d")
		Time <- strptime(eq$Time, format="%H:%M:%S")
	# see the help file for "strptime" for interpretation of format definitions
		
	# Note that the "Time" interprets this as today!
	
		DateTime <- strptime(paste(eq$Date, eq$Time), 
												format="%Y/%m/%d %H:%M:%S")
		range(DateTime)
		diff(DateTime)
		
	# note, this is in seconds.  That was a choice made by R
		D.mins <- difftime(DateTime[-1], DateTime[-length(DateTime)], units="mins")
		
		hist(-as.numeric(D.mins), breaks=100, col="grey", freq=FALSE)
		curve(dexp(x, -1/mean(as.numeric(D.mins))), add=TRUE, n=10000, lwd=2, col=2)

		mean(D.mins)
		sd(D.mins)
		length(D.mins)

		# OK, back to statistics

		
######################################
# Part I:  Central Limit Theorem
######################################


	# Sample any random variable a bunch ("k") of times
		
			k <- 10000
			X <- runif(k)
			
	# Sum it several ("n") of times
	
			n <- 10
			Y <- rep(0, k)
			for(i in 1:n)
				Y <- Y + runif(k)

	# plot the histogram and qqplot
			par(mfrow=c(1,2))
			hist(Y, col="grey")
			qqnorm(Y)
			
	# summary statistics
			mean(Y)
			var(Y)
			
	# Compare to theoretical prediction
			n * 0.5
			n * 1/12
	
	###################################################################################
	# EXERCISE 1: Write a function that sums random draws from the standard uniform
	# distribution, sums them "n" times, and plots the histogram and qqnorm plot.
	###################################################################################
	
	# We can pass a function as an argument in R. 
	
		CLT <- function(FUN, n, k=1000)
		{
			Y <- rep(0,k)
			for(i in 1:n)
					Y <- Y + FUN(k)
			par(mfrow=c(1,2))
			hist(Y, col="grey")
			qqnorm(Y); qqline(Y, col=2)
		}
		
		CLT(runif,1)
		CLT(runif,2)
		CLT(runif,5)
		CLT(runif,10)

	# it works for other functions too
		CLT(rexp,1)
		CLT(rexp,2)
		CLT(rexp,4)
		CLT(rexp,10)	
		CLT(rexp,100)
		CLT(rnorm,10)

	###################################################################################
	# EXERCISE 2: Modify this function so that it also draws the normal approximation to
	# the distribution of the sums.
	###################################################################################
		
		
	# Note that this function falls apart quickly when we need new parameters!
		CLT(rgeom,10)	
		CLT(rgamma,10)	
		CLT(rbinom,10)	

	# The solution is a unique "R" feature ... "..." (the ellipsis)
		
		CLT <- function(FUN, n, k=1000, ...)
		{
			Y <- rep(0, k)
			for(i in 1:n)
					Y <- Y + FUN(k, ...)
			par(mfrow=c(1,2))
			hist(Y, col="grey")
			qqnorm(Y); qqline(Y, col=2)
		}

	# This extremely convenient little feature allows you to add ANY 
	# other arguments to a function that also calls it. It is treated like any other argument.
	
		CLT(rbinom, n=1, size=200, prob=0.1)
		CLT(rgamma, n=10, shape=2)
	
	# or modify the parameters of other functions with known defaults
	
		CLT(runif, n=10, min=0, max=2000)
		
		
  ###################################################################################
  # EXERCISE 3: Show (using this function) that the sum of "n" Bernoulli's is equivalent to
	# a single Binomial(size = n), and that the sum of "n" exponentials is equivalent to a 
	# single Gamma(shape = n).
  ###################################################################################

		# Thus:	
			CLT(rgamma, n=1, shape=2)
		# compare with:
			CLT(rexp, n=2)
			
		# Simulate a bunch of Bernoulli's
			CLT(rbinom, n=30, size=1, p=0.2)
		# Compare that with a single binomial
			CLT(rbinom, n=1, size=30, p=0.2)

	########################################################################################################
	# MORE ADVANCED:  Say you want to pass a separate list of arguments  to the "hist" (or other) functions
	# the "..." falls apart.  
	# For a discussion of this problem go to: http://stackoverflow.com/questions/5080972/using-multiple-ellipses-arguments-in-r
	# But here's some code that works.
	########################################################################################################

		
		CLT <- function(FUN, n, k=1000, ..., hist.args = NULL)
		{
			Y <- rep(0, k)
			for(i in 1:n)
					Y <- Y + FUN(k, ...)
			par(mfrow=c(1,2))
			do.call(hist, c(list(x=quote(Y)), hist.args))
			qqnorm(Y); qqline(Y, col=2)
		}
		CLT(runif, n=2, hist.args=list(breaks=30, col="grey", bor="darkblue", freq=FALSE))
		

		
##########################################
#  SAMPLING DISTRIBUTIONS
#########################################

	# Lets take the new earthquake data and extract the difference in minutes
	
		eq <- read.csv("http://neic.usgs.gov/neis/gis/qed.asc")
		DateTime <- strptime(paste(eq$Date, eq$Time), format="%Y/%m/%d %H:%M:%S")
		dT.mins <- -as.numeric(difftime(DateTime[-1], DateTime[-length(DateTime)], units="mins")	)
		hist(dT.mins, breaks=100)
		
	# This is a large "population" of earthquakes, with a clearly non-normal distribution, 
	# but it has a mean and a variance
		mean(dT.mins)   # about 28.5
		var(dT.mins)		 # about 1516

	# lets take the mean of a small random sample (n=5), many many times:
	
		X.bar5 <- c()
		for(i in 1:10000)
			X.bar5 <- c(X.bar5, mean(sample(dT.mins, 5)))
	
	# This is clearly also a random variable with a mean that is very close to the true mean
		mean(X.bar5) 
	# And a variance that is quite a bit smaller
		var(X.bar5)    # about 300
	# And a distribution, that is unimodal, but not quite normal
		hist(X.bar5, col="grey")

#########################################################################################################
# EXERCISE 4: Write a function that simulates the sampling distribution of the mean with sample size "n".
#########################################################################################################

	SampleMean <- function(X, n=30, k=10000, ...)
	{
		X.bar <- c()
		for(i in 1:k)
			X.bar <- c(X.bar, mean(sample(X, n)))
		hist(X.bar, ...)
		X.bar
	}

	X.bar1 <- SampleMean(dT.mins, n=1, k=10000, col=rgb(0,0,0,.2), bor=rgb(0,0,0,.2), freq=FALSE, xlim=c(0,100), breaks=seq(0,600,2), ylim=c(0,.1))	
	X.bar5   <- SampleMean(dT.mins, n=5, k=1000,  col=rgb(1,0,0,.2), bor=rgb(1,0,0,.2), freq=FALSE, breaks=seq(0,600,2), add=TRUE)
	X.bar30  <- SampleMean(dT.mins, n=30, k=1000, col=rgb(0,1,0,.2), bor=rgb(0,1,0,.2), freq=FALSE, breaks=seq(0,600,2), add=TRUE)
	X.bar100 <- SampleMean(dT.mins, n=100, k=1000, col=rgb(0,0,1,.2), bor=rgb(0,0,1,.2), freq=FALSE, breaks=seq(0,600,2), add=TRUE)
  X.bar1000 <- SampleMean(dT.mins, n=1000, k=1000, col=rgb(0,0,1,.2), bor=rgb(0,1,1,.2), freq=FALSE, breaks=seq(0,600,2), add=TRUE)

	# Increasingly higher samples drive the distribution to an estimate that is increasingly narrow, and always unbiased.
		
		mean(X.bar1); sd(X.bar1); sqrt(var(dT.mins)/1)
		mean(X.bar5); sd(X.bar5); sqrt(var(dT.mins)/5)
		mean(X.bar30); sd(X.bar30); sqrt(var(dT.mins)/30)
		mean(X.bar100); sd(X.bar100); sqrt(var(dT.mins)/100)

	# Note how the variance of the sampling distribution does, in fact, agree with the CLT
	
	
###############################################
#  Inference
###############################################

	# Let's say you think that doomsday is coming on Dec 21, 2012 (as per the Maya calendar)
	# and start counting earthquakes.  

  # You count 10 earthquakes and see that their average interval is 15 minutes.  
  # Do you go out into the street yelling "The World Is Ending! The World Is Ending!"?

  # What is the probability of a frequency this high or higher given that the mean interval is
  #  28.6  with a standard deviation 38.94?

  # According to the THEORETICAL sampling distribution:
  # dT.bar.10 <- Normal(28.5, sd = 38.94/sqrt(10)):
    curve(dnorm(x, mean = 28.5, sd = 38.94/sqrt(10)), xlim=c(0,100))

  # Our observation:
    abline(v=15, lwd=2)
  
  # Probability of the high-frequency event:
    pnorm(15, 28.5, 38.94/sqrt(10))

  # 13% ... not THAT unlikely!   
  # This number is the "P-value", or the probability that you would observe a value this 
  # extreme or more extreme under the null hypothesis that the world is NOT ending. 
  

############################################################################
# EXERCISE: Ok, 10 earthquakes in a row was not enough.  
# What if, fanatically, I kept downloading the data and saw that after 30 
# new earthquakes, the average waiting time was still 15 minutes?
# And then, 100 earthquakes.  Should you start panicking?
#############################################################################


  # Note, you could have gotten the p-value from the resampling distribution directly.

  dTbar.10sim <- SampleMean(dT.mins, n=10, k=10000)
  sum(dTbar.10sim < 15)/10000

  # This is a more "exact" p-value, but requires much more computation.  
  # It is quite different because the CLT hasn't totally exerted its power yet. 


############################################################################
# EXERCISE: Do the same thing for 30 and 100 earthquakes.
############################################################################
