# StatR 101
# Eli Gurarie
# Lab 6


######################################
# Simulating coin flipping
######################################
  
  sample(c("H","T"),1)
  sample(c("H","T"), 100, replace=TRUE)
  
  Flips <- sample(c("H","T"), 100, replace=TRUE)
  plot(cumsum(Flips == "H")/(1:length(Flips)), ylim=c(0,1))


######################################
# Simulating Dice
######################################

  Die <- 1:6
  N <- length(Die)
  
  install.packages("gmp")
  require(gmp)

  ?isprime
  
  even <- Die%%2 == 0
  P.even <- sum(even)/N
  P.odd <- sum(!even)/N    
  P.even + P.odd 
  # = 1.  P.even and P.odd are complementary
  
  P.even + P.odd

  prime <- isprime(Die) == 2
  P.prime <- sum(prime)/N

  P.even + P.prime
  # does this mean that P.even and P.prime are complementary?

# Union (OR)
  even | prime
  P.evenORprime <- sum(even | prime)/N
  P.evenORodd <- sum(even | !even)/N

# note the difference from:
  even || prime
# the second tests only returns the FIRST element.

# Intersection (AND)
  even & prime
# compare with 
  even * prime
  P.evenANDprime <- sum(even | prime)/N
  P.evenANDodd <- sum(even & !even)/N

# under independence, P(A AND B) = P(A) * P(B)
  P.evenANDprime == P.even * P.prime
  P.evenANDodd == P.even * P.odd
# Neither of these "events" (from a single ROLL) is "independent"


############################
#  COUNTING
############################ 

# Let's start with 2 dice

  Die1 <- 1:6
  Die2 <- 1:6

# make a table of every possible combination of outcomes
  S2Dice <- outer(Die1, Die2, paste)
  # also possible with a loop

# make a table of every possible sum
  Sum2Dice <- outer(Die1, Die2, "+")
# why doesn't "sum" work?  I don't know.

# tabulate
  table(Sum2Dice)

# Make a histogram of this sum
# Note that it is not THAT straightforward 

  x <- unique(as.vector(Sum2Dice))
  y <- as.vector(table(Sum2Dice))

# Note that "h" refers to histogram-like vertical bars
  plot(x, y, type="h", col="blue", lwd=2)
  points(x,y, pch=19, col="red")

# But, magically, the default behavior for R plotting a table is a line histogram!
  plot(table(Sum2Dice), col="blue")

  Dinner <- c("E","F","G")
  Drink <- c("B1","B2","B3")
  Dessert <- c("CF","TP","SP")

  DinnerCombinations <- outer(outer(Dinner, Drink, paste), Dessert, paste)
  dim(DinnerCombinations)
  length(DinnerCombinations)


# Ordering four animals 
  Animals <- LETTERS[1:4]

# There is a function in the "gregmisc" package that does combinations and permutations
  install.packages("gregmisc")
  require(gregmisc)  
# I) Permute 4 animals
    permutations(4, 4, Animals)
  # theoretical prediction:
    factorial(4)

# II) Rank (permute) 4 of 11 animals
    permutations(11,4,LETTERS[1:11])
  # theoretical prediction:
    factorial(11)/factorial(7)

# III) Choose 4 of 11 animals
    combinations(11, 4, LETTERS[1:11])
  # theoretical prediction:
    factorial(11)/ (factorial(7) * factorial(4))
  # This is such an important quantity, it has its own "base" function
    choose(11,4)


# Q1: How many unique pin-codes are possible?
# Q2: How many pin codes with no repeating numbers?




######################################
# Analysis of the birthday problem
######################################

# Using "sample" to create a class of students

  ClassSize <- 30
  getSharedBirthdays <- function(ClassSize)
  {
    Days <- 1:365
    ClassBDays <- sample(Days, ClassSize, replace=TRUE)
    UniqueBDays <- length(unique(ClassBDays))
    ClassSize > UniqueBDays
  }
  
  nreps <- 100
    
  getPSharedBirthdays <- function(ClassSize, nreps)
  {
    Results <- rep(NA, nreps)
    for(i in 1:nreps)
      Results[i] <- getSharedBirthdays(ClassSize)
    sum(Results)/nreps
  } 
    
  N <- 1:70
  P <- c()
  for(n in N)
    P <- c(P, getPSharedBirthdays(n, 100))
  plot(N,P)
  abline(h=0.5)  
  
# include Theory
  
  Theory <- function(x)
    1 - prod(365:(365-x+1))/365^x
  Theory2 <- Vectorize(Theory)
  lines(N, Theory2(N), lwd=2)
  
############################
# Binomial distribution
###########################

# distribution function

  # distribution of total number of heads after 10 coin flips

    x <- 0:10
    pmf <- dbinom(x, size=10, p=0.5)

    plot(x, pmf, type="h")
    points(x, pmf, pch=19)
  
  # sum the pmf:
    sum(pmf)
  # Probability that you get exactly 5 heads  
    pmf[x == 5]
  # test against formula:
    choose(10,5)*0.5^10

  # Probability that you'll get 6 or more heads
    sum(pmf[x >= 6])

  # Cumulative distribution
    cmf <- pbinom(x, size=10, p=0.5)
    plot(x, cmf, type="h")
    points(x, cmf, pch=19)


# Exercise: Given that Shaquillie O'Neal's free throw percentage is 27%, what 
# is the probability that he will make at least 5 of 10 critical free throws
# in the last quarter of an NBA playoff game?

  # Random generation of binomial realizations
    X <- rbinom(10000, size=10, p=0.5)
    hist(X, breaks=0:11-.5, freq=FALSE, col="grey", bor="darkgrey")  
    points(x, pmf, type="h")
    points(x, pmf, pch=19)

  # Expectation and Variance of binomial distribution

    mu.X <- sum(x*pmf)
    sigma2.X <- sum((x-mu.X)^2 * pmf)
    sum(x^2 * pmf) - mu.X^2

    
