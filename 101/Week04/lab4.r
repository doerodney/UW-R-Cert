# StatR 101
# Eli Gurarie
# Lab 4a


###########################################
#
#  Part I: THE NORMAL DISTRIBUTION
#
###########################################


# Here is a "homemede" function that uses the functional form of the Gaussian
# to return the density function

  NormalPDF <- function(x, mu=0, sigma=1)
    (1/(sqrt(2*pi)*sigma) * exp(-(x-mu)^2/(2*sigma^2)))
  
# draw it:
    plot(-5:5, NormalPDF(-5:5))  # not such a good picture
    plot(seq(-3,3,.1), NormalPDF(seq(-3,3,.1)))
  # you can assign a variably within a function call
    plot(x <- seq(-3,3,.1), NormalPDF(x))
  # you can add points via "points()"
    points(x, NormalPDF(x, mu=1, sigma=2), col=3)
  # or draw lines
    plot(x <- seq(-5,5,.1), NormalPDF(x), type="l")
    lines(x, NormalPDF(x, mu=1, sigma=2), col=3)

# using "curve"
  curve(NormalPDF)
  curve(NormalPDF(x), xlim=c(-3,3))

# draw some shifted ones:
  
  curve(NormalPDF(x, mu=1), xlim=c(-3,3), add=T, col=2)
  curve(NormalPDF(x, mu=-2), xlim=c(-3,3), add=T, col=3)

# draw some narrower and fatter ones:
  
  curve(NormalPDF(x, sigma=1), xlim=c(-4,4), ylim=c(0,0.85))
  curve(NormalPDF(x, sigma=0.5), add=T, col=2)
  curve(NormalPDF(x, sigma=2), add=T, col=3)

# Note that it integrates to 1, regardless of the mean or variance
  integrate(NormalPDF, lower=-Inf, upper=Inf)
  integrate(NormalPDF, mu=2, lower=-Inf, upper=Inf)
  integrate(NormalPDF, mu=2, sigma = 4, lower=-Inf, upper=Inf)
# Note also that adding arguments to "integrate" works differently 
# than in "curve())"

# Integrate up to "mu"
  integrate(NormalPDF, lower=-Inf, upper=0)
  integrate(NormalPDF, mu = 5, lower=-Inf, upper = 5)
# ... is 1/2 regardless of sigma
  integrate(NormalPDF, mu = 5, sigma = 0.001, lower = -Inf, upper = 5)

# Integrate the area within 1 and 2 sigmas
  integrate(NormalPDF, lower = -1, upper = 1)
  integrate(NormalPDF, lower = -2, upper = 2)

  mu <- 5; sigma <- .1
  integrate(NormalPDF, mu = mu, sigma = sigma, 
            lower = mu - 2*sigma, upper = mu + 2*sigma)

# Note that "integrate" contains more than just the integral
  str(integrate(NormalPDF, -Inf, Inf))

# To extract just the integral, we need to call out the "value" element
  integrate(NormalPDF, -Inf, Inf)$value

# We can use this to create the cumulative distribution function
  NormalCDF <- function(x, mu=0, sigma=1)
    integrate(NormalPDF, mu=mu, sigma=sigma, -Inf, x)$value

# This works for a single value
  NormalCDF(-2)
  NormalCDF(-1)
  1 - NormalCDF(-2)*2

# But not for a vector of values!
  NormalCDF(-2:2)

# How to "vectorize" this function?
  NormalCDF2 <- function(x, mu=0, sigma=1)
    apply(t(x), 2, NormalCDF, mu=mu, sigma=sigma)

  curve(NormalCDF2(x), xlim=c(-3,3))
  curve(NormalCDF2(x, mu=1), add=TRUE, col=2)
  curve(NormalCDF2(x, mu=1, sigma=0.1), add=TRUE, col=3)

# Note, you can break this:
  curve(NormalCDF2(x, mu=1, sigma=0.01), add=TRUE, col=3)
# What's going on here?  I'm not sure.  
# There's some mysterious numerical breakdowns,
  curve(pnorm(x, mean=1, sd=0.01), add=TRUE, col=4)


# In any case, the default R functions are:
# "dnorm" for the *D*ensity function and "pnorm" for the cumulative *P*robability function.

  curve(dnorm(x, mean=1, sd=1), xlim=c(-2,4), ylim=c(0,1))
  curve(pnorm(x, mean=1, sd=1), add=TRUE, col=4)
  

# Exercise 1: Use the "dnorm" and "pnorm" function to illustrate the
# normal distribution for the following combinations of mean and variance:
#  means = c(0,1,2,3), 
#  sd = c(0.25, .5, 1, 2)



#############################
# 1.2 RANDOM NUMBER GENERATION

# An extremely important aspect of statistical programming
# is the ability to generate random numbers. 

  # the following code will create "determnistic" but "pseudo-random" numbers
  # (see Braun Murdoch Chapter 5 for details)
  # It is based on taking remainders 

  random.seed <- 27218
  b <- 171
  m <- 30269  # this is a cycle length ... 
  n <- 100
  
  random.number <- numeric(n)
  for(j in 1:n)
  {
    random.seed <- (b*random.seed) %% m
    random.number[j] <- random.seed / m
  }
  plot(random.number)
  hist(random.number, breaks=seq(0,1,.1))

# Exercise 2: try running this code with 
#  m=29, m=31, m = 29241,
#  Note the cycle lengths

# If you have a vector of random uniform variables, 
  x <- random.number
  hist(x)
# You can easily convert that to 100 numbers between 0 and 100
  y1 <- x*100
  range(y1)
# Or  between -2 and 2
  y2 <- x*4-2
  range(y2)

# Exercise 3: Write a function called "RUniform()" that generates "n" uniform random numbers 
# between "a" and "b".


# In R ... random uniform numbers are generated with the "runif()" function.
# Which uses a different formula for generating random numbers 
  runif(100)
  runif(100, 0, 100)
  runif(100, -2, 2)

# You can make the numbers "pseudorandom" by setting a seed
  set.seed(32789)
  runif(5)
# but you need to reset it every time.
  runif(5)


################################################################################
# There are several tricks to generating (pseudo)-random samples from an 
# arbitrary distribution. 

# The most straightforward is the "Method of Rejection"

  ymax <- NormalPDF(0)
  y <- runif(10000,0,ymax)
  x <- runif(10000,-10,10)

# plot all the x and y points
  plot(x,y, col="grey")

# draw the normal distribution on top of this
  curve(NormalPDF(x), col=2, lwd=2, add=TRUE)

# keep only those points that are below the curve
  keep <- y < NormalPDF(x)
  points(x[keep], y[keep])

# looks normal!
  hist(x[keep])

# but what is the length of "x"?
  length(x[keep])

# If we want to "control" the length of "x", we can simulate the random numbers incrementally.
# In this algorithm, we try a random uniform value, and keep it with probability proportional 
# to the height of the distribution at "x".
  
# make an empty vector
  x <- c()
  N <- 100
  while(length(x) < N)
  {
    x.candidate <- runif(1,-10,10)
    if(runif(1,0,NormalPDF(0)) < NormalPDF(x.candidate))
      x <- c(x, x.candidate)
  }
  hist(x)
  mean(x)
  sd(x)

# note that this code uses two key pieces of any programming:
# - the "while" loop, which repeats until the condition in while() returns a FALSE
# - the "if" statement, which only performs a task if the condition is TRUE

######################################################################################
# Exercise 4: Generalize the code above to create random normal variables with mean "mu"
# and variance "sigma", and wrap it into a function called "RNormal(n, mu, sigma)"

RNormal <- function(n, mu=0, sigma=1)
{
  # fill in these blanks
}


# Compare this code:

# A useful way to assess how efficient code is, is to time it doing a long operation.
# To get the system time:
  Sys.time()
# To time how long code might take, do this
  starttime <- Sys.time()
  RNormal(10000)
  Sys.time() - starttime
# Note that that took several seconds!  Can we improve this code?



# Yes!
# The reason it takes so long is that we are constantly re-creating the vector. 
# It is more efficient to pre-create it and fill it.
  
  N <- 10000
  x <- rep(NA,N)
# or: numeric(N) fills a vector with 0's
  mu <- 0
  sigma <- 1
  
  starttime <- Sys.time()
  i <- 1
  while(i <= N)
  {
    x.tryme <- runif(1,-10,10)
    if(runif(1,0,NormalPDF(mu, mu, sigma)) < NormalPDF(x.tryme, mu, sigma))
      x[i] <- x.tryme
    i <- i+1
  }
  Sys.time() - starttime

  # 10 times faster!
  
  # The native method for doing this is the function "rnorm()"
  x <- rnorm(10000)

# Quick Exercise 5: Time R's rnorm function.
#  There's no comparison!  We'll stick to R's functions in the future. 


# note that the "qnorm" function is the inverse function of "pnorm"
  par(mfrow=c(1,2))
  curve(pnorm, xlim=c(-3,3), main="Cumulative distribution function")
  curve(qnorm, xlim=c(0,1), ylim=c(-3,3))

# It tells you what VALUE corresponds to what which cumulative PERCENTILE

# so: the probability that a normal random variable (r.v.) < 0 = 1/2
  pnorm(0)
# the value at which the probability is 1/2 is:
  qnorm(0.5)

################################################################################
# Exercise 6: We know that about 95% of the mass of a normal distribution 
# is between -2 and 2, but in fact it is closer to: 95.45%.  See:
  1-pnorm(-2)*2
# What is the EXACT value of X which covers 95% of the mass of the distribution?
# Technically: find "Z" where Pr(|X| < Z) = 0.95
################################################################################

###############
# QQ-plots


#  qq-normal plot.  
  x <- rnorm(100)
  qqnorm(x)
  qqline(x, col=2)

# Computing the actual order statistic that is used for the x-axis is complicated,
# but this is a very close approximation.
  q.theory <- qnorm(seq(0, 1,length=length(x)))
  points(q.theory, sort(x), col=3)

######################################################################################
# Exercise 7: Load the country data (its online now)
  C <- read.csv("http://faculty.washington.edu/eliezg/data/CountryData.csv")
# and draw qq-norm plots (and qq-lines) of Literacy, GDP, Population, and Area
# For Population, Area and GDP, draw the same for log-transforms of the data
######################################################################################
