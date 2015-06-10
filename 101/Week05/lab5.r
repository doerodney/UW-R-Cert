# StatR 101
# Eli Gurarie
# Lab 5

##########################################
#
#  Part 1: Correlation and Regression
#
##########################################

# There are native ways to save and access datasets within "R".
# A list of "preloaded" data sets is shown with:
  data()

# load the iris data set
  data(iris)
# read about it
  ?iris
  head(iris)
# see what happens when you "plot" a data frame.
  plot(iris)
  plot(iris, col=iris$Species)
  plot(iris[,1:4], col=iris$Species)
  plot(iris[1:4],main="Iris Data", 
      pch=21, bg=c("red","green3","blue")[iris$Species])

# See image here: http://en.wikipedia.org/wiki/Iris_flower_data_set

# We'd like to look at Galton's original data.  They happen to be stored in a package providing 
# data sources for a book called "UsingR". We'll use this opportunity to install and load 
# a package.
# Note: A "package" is a library of functions and datasets that we download / install / and use
# all within R. Their main repository is the CRAN website, which is mirrored around the world.

#  Installing a package

  install.packages("UsingR")

# Loading a package
  library(UsingR)
  require(UsingR)
  
  data(galton)
  galton
  
  plot(galton$child, galton$parent)
  plot(jitter(galton$parent), jitter(galton$child))

# compute the correlation by hand
  x <- galton$parent
  y <- galton$child
  
  r <- sum((x-mean(x))*(y-mean(y))/(sd(x) * sd(y)))/(length(x)-1)
  cor(x,y)
  cor(y,x)

# compare with passing a matrix (or data frame) to "cor" 
  cor(galton)


# Exercise 2.1: go back to the Iris data and find the correlation coefficient for all four variables.  
# Do this for the pooled data, and then by species.  Are the results consistent between species? 
# Are there any interesting patterns between the overall correlation and the by-species correlation?



##########################################
#
#  Part 2b: Regression coefficients
#
##########################################


# Back to the dalton father-son relationships
  require(UsingR)
  x <- galton$parent
  y <- galton$child

# Computing the regression coefficients
  beta.hat <- sum((y-mean(y)) * (x-mean(x))) / sum((x-mean(x))^2)
  alpha.hat <- mean(y) - beta.hat * mean(x)

# show the relationship between "r", "beta" "sx", "sy"
  beta.hat * (sd(x)/sd(y))

# Computing the ancillary statistics:
  y.predicted <- alpha.hat + beta.hat*x
  residuals <- (y - y.predicted)
  plot(residuals)
  qqnorm(residuals)

  SS.residual <- sum((y - y.predicted)^2)
  SS.model <- sum( (y.predicted - mean(y))^2)
  SS.total <- sum((y - mean(y))^2) # or sd(y)*(n-1)

#Do they add up?
  SS.residual + SS.model
  SS.total 

# Proportion of variation "explained" by model
  SS.model/SS.total
# square root of this number:
  sqrt(SS.model/SS.total)
# compare with 
  r

# The very important one line code for obtaining regressions: "lm()" - *L*inear *M*odel fitting.
  lm(galton$child ~ galton$parent)
  mylm <- lm(galton$child ~ galton$parent)

# the "lm" object is complex!
  str(mylm)
  names(mylm)

# for now, we are mostly interested in the coefficients
  mylm$coefficients
# note that you can access names objects withe minimum unambigious initial string of letters
  mylm$coeff
  mylm$co
  # but not:
  mylm$c

# The "abline()" function is useful for plotting regression lines.
  
  plot(x,y)
  plot(jitter(x),jitter(y))
  plot(jitter(x),jitter(y), col="grey")

  abline(alpha.hat, beta.hat, lwd=2, col=2)
  abline(mylm$coef[1], mylm$coef[2], lwd=2, col=3)
  # or, most compactly, 
  abline(mylm, lwd=2, col=4)

  #compare that to the 0,1 line
  abline(0, 1, lwd=4, lty=3)

#########################################################################
# Exercise 2: Perform the regression of children against parents. 
#########################################################################


# A comment on fitting higher order polynomials

y <- iris$Petal.Length
x <- iris$Petal.Width

plot(x,y)

x2 <- x^2

mylm <- lm(y~x+x2)
curve(mylm$coef[1] + mylm$coef[2]*x + mylm$coef[3]*x^2, add=TRUE)
plot(x,mylm$residuals)


