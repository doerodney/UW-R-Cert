# StatR 101
# Eli Gurarie
# Lab 7

############################
# Pramble on Animals
############################

	# Code with respect to my comment on scaling laws and animal size
	# The "Animals" data set is preleaded in R, but you may need to load the MASS package:
	require(MASS)
	
	# the data are a data frame called Animals, with columns for body and brain size
	body <- Animals$body
	brain <- Animals$brain

	# If you plot brain size against body size directly, and superimpose the regression,
	# it is near zero
	plot(body, brain)
	abline(lm(brain~body))
	text(40000,4000,
			 paste("beta1 =", round(lm(brain~body)$coef[2], 4)))
	
	# but if you plot this on a log-log scale, there is a very clear relationship
		plot(body, brain, log="xy")
		mylm <- lm(log(brain)~log(body))
	
	# Note that this model says:
	#  log(Y) = a + b log(X)
	# Y = exp(a + b log(X))
	# Y = K X^b  (where K = exp(a))

	# Use this relationship to to add the regression line
		curve(exp(mylm$coef[1]) * x^mylm$coef[2], col=2, lwd=2, add=TRUE)
	
	# It seems this curve is very highly influenced by the large-bodied, small-brained outliers
	# You can identify them by ordering the Animal data set and labeling the three highest points
		
		Animals2 <- Animals[order(body, decreasing = TRUE),]
		text(Animals2$body[1:3], Animals2$brain[1:3], labels = row.names(Animals2)[1:3],
				xpd=TRUE)  # xpd lets the words reach out side of the plotting box
	
	# You can see that that the outliers are dinosaurs- no real surprise there
	# Let's	modify the regression by eliminating those three
		mylm <- lm(log(brain)~log(body), data=Animals2[-(1:3),] )
	# Note that we can pass the dataframe directly into the "lm" command, and eliminate the rows 
	# with "-(1:3)" directly. 
		
	# The "-1" means only estimate a slope (the intercept is fixed at "0")
	# The new regression line now is just:
		curve(exp(mylm$coef[1]) * x^mylm$coef[2], add=TRUE, col=3, lwd=2)
	# Note that the scaling relationship is: 0.75
		text(0.1,500,paste("b =",round(mylm$coef[2],2)), cex=2)
	# This scaling coefficient is about 3/4, which suggests that for every 2x increase in body mass
	# is associated with 1.68 fold increase in brain mass, suggesting there is increasing cost to 
	# maintaining larger brains. 
		
	# That last regression sems nice.  We can use the residuals to identify the animals 
	# in this truncated data set that have the highest and lowest brain to body ratio given the 
	# regression model:

		Animals3 <- Animals2[-(1:3),]
		Res.order <- order(mylm$residual)
		Animals3 <- Animals3[Res.order,]

		text(Animals3[1:3,], row.names(Animals3)[1:3], col=4)
		text(Animals3[23:25,], row.names(Animals3)[23:25], col=6)

	# The three highest brain/body ratios are: Humans, Chimpanzees and Rhesus Monkeys
	# The three lowest  are: Kangaroo, Pig and Cow.



###########################################################################
# Part 1: Discrete distributions, their expectation and variance
##########################################################################

# distribution function

# Binomial distribution
	n <- 10
	p <- 0.2
	x <- 0:n
	f <- dbinom(x, p=p, size = n)

# mean and variance
	plot(x,f, type="h"); points(x,f, pch=19)
	
	mean.x <- sum(x*f)
	var.x <- sum( (x - mean.x)^2 * f)
	
	# or:
	var.x <- sum(x^2 * f) - mean.x^2
	
# Note, to show output surround the command with "()":
	(mean.x <- sum(x*f))
	(var.x <- sum( (x - mean.x)^2 * f))

# compare with theory
	n * p
	n * p * (1-p)
	
# compare with simulations.  
# Here 
	mean(rbinom(10000,n,p))
	var(rbinom(10000,n,p))
	
# Show sums of Bernoulli

	n <- 10
	p <- .2
	
	X <- c()
	
	for(i in 1:1000)
		X <- c(X,sum(rbinom(n, 1, p)))
		
	hist(X, freq=FALSE, col="grey", breaks= (-.5):8.5)
	points(x,f, col=2, pch=19, cex=2)

	
#############################################################################################
# Exercise 1: Show the mean and variance of Geometric ("geom") are consistent with theory
#############################################################################################
	
	# Solution

	# Binomial distribution
		n <- 2000
		p <- 0.05
		x <- 0:n
		f <- dgeom(x, p)
		plot(x,f, type="h")

	# Compute the mean and variance	
		(X.mean <- sum(x * f))
		(X.var <- sum( (x - X.mean)^2 * f))
		
	# Compare with Geometric theory

		(1-p)/p == X.mean
		(1-p)/p^2 == X.var

	# Compare with randomization
		
		mean(rgeom(10000,p))
		var(rgeom(10000,p))
		
	# and plot

		plot(x,f, type="h")
		abline(v = X.mean, col=2, lwd=2)
		abline(v = X.mean + c(-1,1)*(sqrt(X.var)), col=3, lwd=2, lty=2)

	# You can run essentially this code with any other discrete random distribution, such as 
	# Poisson (dpois, ppois, rpois, etc.)
	 

#################################################################################
# Illustrating the relationships between Uniform and Exponential distributions
#################################################################################

# Consider the Avacha model, where volcanoes are uniformly distributed [RANDOM uniform!] 
# for the past, say, 4000 years with mean 50 year interval

	Tmax <- 4000
	Rate <- 1/50
	N <- Tmax*Rate

	Avacha <- sort(runif(N.earthquakes, 0, Tmax))
	# Note the sort is important to keep the eruptions chrnological

	# Let's plot the explosion times
		plot(Avacha, rep(0, N), pch=19, col=rgb(0,0,0,.2))
	# a histogram of the explosion times
		hist(Avacha, col="grey", xlab="Eruption Times")
	# Create a vector of waiting times 
		W <- diff(Avacha)
	# Draw a histogram of the waiting times 
		hist(W, col="grey", breaks=10)
	# It looks sort of exponential.  Let's redraw it is a density histogram
		hist(W, col="grey", breaks=10, freq=FALSE)
	# And superimpose the exponential distribution on the waiting times:
		curve(Rate * exp(-x * Rate), add=TRUE, col=2, lwd=2)
	# You can also do this with the "dexp" function
		curve(dexp(x, Rate), add=TRUE, col=3, lwd=2)
	# According to the exponential function, the mean and variance are (1/Rate) and (1/Rate)^2 respectively
	
	# Let's see if that's true for W:
		mean(W)
		sd(W)
	# the numbers should be close to 50
	
	# Note that you can get means and expectations of continuous variables by integrating in R:

		# test to see if it is a valid distribution
			integrate(function(x) Rate * exp(-Rate * x), 0, Inf)
		# obtain the mean
			integrate(function(x) x * Rate * exp(-Rate * x), 0, Inf) 
		# obtain the variance
			integrate(function(x) (x - 1/Rate)^2 * Rate * exp(-Rate * x), 0, Inf)
				
	# Incidentally, the following code allows you to make three windows in one plot:
		layout(rbind(c(1,1),c(2,3)))
	# You give layout a matrix that enumerates which plot goes in which window.
	# The layouts can be arbitratily complex.
	
	# So, illustrating all the relationships now goes like this: 			
		plot(Avacha, y=rep(0,N), pch=19, col=rgb(0,0,.4,.3), xlim=c(0,Tmax),
			ylab="", yaxt="n", xlab="Year", cex=2, bty="n", main="Simulated Avacha eruptions")	
		hist(Avacha, breaks=10, freq=FALSE, bor="darkgrey", col="grey")
		hist(diff(Avacha), col="grey", freq=FALSE, breaks=12, bor="darkgrey")
		curve(dexp(x,rate=Rate), add=TRUE, lwd=2)


	#########################################################################
	#  Exercise 2: download the Vesuvius data and perform this analysis
		

#################################################################################
# Illustrating the relationships between Uniform, Exponential and Poisson distributions
#################################################################################

	# Using our Avacha simulated data ... 
	# The "cut" function breaks down the data into defined sections, in this case centuries
		Avacha <- runif(N, 0, Tmax)
		Avacha.100 <- cut(Avacha, seq(0,Tmax,100))
	
	# We would like to count how many eruptions there were per centure, so we tabulate:
		tabulate(Avacha.100)
	# Note that "tabulate" is similar to table, but simply returns a vector (which for our purposes is very convenient). 
	
	# A historgram of the table shows the distribution of the number of eruptions / 100 years:
		hist(tabulate(Avacha.100))
	
	# As is typical for the "hist" function applied to discrete data, the breaks are awkward around zero 

	# An alternative is to tabulate the tabulation!
		table(tabulate(Avacha.100))
	# And plot it:
		plot(table(tabulate(Avacha.100)))
	# You may or may not get something that looks like the Poisson distribution of numbers, i.e.
	# discrete values (that include 0) and tabulate the number of eruptions per 100 year block 

	# Let's get a vector of proportions:
		P.Avacha.100 <- table(tabulate(Avacha.100))/sum(table(tabulate(Avacha.100)))
		plot(P.Avacha.100)
	
	# And draw the Poisson distribution over it.  Recall that the lambda parameter in a Poisson distribution is the expected count in a block.  In this case, the block is 100 years x rate of 1/50 = 2.
		plot(P.Avacha.100)
		lines(0:8, dpois(0:8, 2), type="h", col=rgb(1,0,0,.2), lwd=10)

	# So it looks like the Poisson approximation is quite close. 
	
	# Let's do this (compactly) for any break:
	
		Interval <- 25
		lambda <- Interval * Rate
		Avacha.cut<- cut(Avacha, seq(0,Tmax,Interval))
		P.Avacha.cut <- table(tabulate(Avacha.cut))/sum(table(tabulate(Avacha.cut)))
		plot(P.Avacha.cut)
		lines(0:8, dpois(0:8, lambda), type="h", col=rgb(1,0,0,.2), lwd=10)
		
	# Experiment with different break-ups of the Avacha data, and see if the Poisson relationship holds for the Vesuvius data
		
	
	