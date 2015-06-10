# Get all Fibonacci numbers less than 300
Fib1 <- 1
Fib2 <- 1
Fibonacci <- c(Fib1, Fib2)
while (Fib2 < 300) {
	Fibonacci <- c(Fibonacci, Fib2)
	oldFib2 <- Fib2
	Fib2 <- Fib1 + Fib2
	Fib1 <- oldFib2
}	

# Get all Fibonacci numbers less than 300
Fib1 <- 1
Fib2 <- 1
Fibonacci <- c(Fib1, Fib2)
while (Fib2 < 300) {
	Fibonacci <- c(Fibonacci, Fib2)
	Fib2 <- Fib1 + Fib2
	Fib1 <- Fibonacci[length(Fibonacci)]
}

# Get all Fibonacci numbers less than 300
Fibonacci <- c(1,1)
while ((Fibonacci[length(Fibonacci) - 1] + Fibonacci[length(Fibonacci)]) < 300) {
	Fibonacci <- c(Fibonacci, Fibonacci[length(Fibonacci) - 1] + Fibonacci[length(Fibonacci)])
}


TaylorSine <- function(x, k) {
	ik = as.integer(k)
	for (i in 1:ik) {
		
	}
	nFunc = k %/% 4
	
}

	

# Return all prime numbers up to n
GetPrimes <- function(n) {
	if (n >= 2) {
		sieve <- seq(2, n)
		primes <- c()
		for (i in seq(2, n)) {
			if (any(sieve == i)) {
				primes <- c(primes, i)
				sieve <- c(sieve[(sieve %% i) != 0], i)
			}
		}
		return(primes)
	}
else {
		stop("Input value should be at least 2.")
	}
}
 
GetTimeAsSeconds <- function() {
	x <-as.POSIXlt(Sys.time())
	daySec <- (as.integer(x$hour) * 3600) + (as.integer(x$min) * 60) + as.integer(x$sec)
	return(daySec)
}
 
GetRandomNumberM <- function {
	decentSize <- 20000  # Increase this for slower performance and more randomness.
						 # Decrease this for faster performance and less randomness.
	# Use the time in seconds into the day to get a large integer.
	bigInt <- GetTimeAsSeconds()
   
	# Get the modulus up to a decent size.
	while (bigInt < decentSize) {
					bigInt <- bigInt * bigInt
	}

	# Now the number might be huge.  Make it smaller.
	bigInt <- bigInt %/% decentSize
   
	# Now get a prime number near bigInt.
	p <- GetPrimes(bigInt)
   
	mPrime <- p[length(p)]
   
	return(mPrime)               
}
 
# Return a random number b (numerator) value given a random number m (denominator) value
GetRandomNumberB <- function(M)     {
	b <- as.integer(sqrt(M))
   
	p <- GetPrimes(b)
   
	bPrime <- p[length(p)]
   
	return(bPrime)
}
 
 sdUniformDistSample <- function(n, b) {
	result = NA
	
	if (n > 0 && b > 0) {
		result = sd(runif(n, 0, b))
	}
	return(result)
}	
	
 
TaylorSine <- function(x, kTerms) {
	result = 0
	for (i in 0:as.integer(kTerms)) {
		result += TaylorSineTerm(x, i)
	}
	return(result)
}

TaylorSineTerm <- function(x, kthTerm) {
   # Sine function is infinitely differentiable, but repeats itself after 4 orders.
   # f(x) = sin(x)
   # f'(x) = cos(x)
   # f'2(x) = -sin(x)
   # f'3(x) = -cos(x)
   # f'4(x) = sin(x)
   # Therefore f'n(x) = f'(n %% 4)(x)
   # We are evaluating at x= 0, so exploit that to simplify.
   # sin(0) = 0, cos(0) = 1
   # Any term with sine evaluates to 0 since sin(0) = 0, so 0, 2, 4 .. are all zero.
   # Any term with cosine evaluates to 1 since cos(0) = 1.  Sign matters...
   # All we care about are the modulo 1st and 3rd terms.
   termResult = 0
   modTerm <- kthTerm %/% 4
   
   if (1 == modTerm) {
		termResult = x^kthTerm / factorial(kthTerm) 
   }
   else if (3 == nTerm) {
		termResult = x^kthTerm / factorial(kthTerm) * -1
   }
   return(termResult)
}

factorial<-function(x) {
	result = NA
	ix = as.integer(x)
	if (ix == 0) {
	   result = 1
	} 
	else if (ix > 0) {
	    result = prod(seq(1, as.integer(x), 1))
    }	
	return(result)
}



> # Take TaylorSine for a test drive.
> x <- seq(-2*pi, 2*pi, 0.01)
> y <- numeric(length(x))
> plot(x, y, xlim=c(-2*pi, 2*pi), ylim=c(-2,2), type="l", col=1)
> for (i in 1:length(x)) {y[i] = TaylorSine(x[i], 3)} 
> plot(x, y, xlim=c(-2*pi, 2*pi), ylim=c(-2,2), type="l", col=rgb(0,0,1), main="3rd Order Approximation")
> lines(x,sin(x), col=rgb(1,0,0))
> lines(x,x, col=rgb(0,1,0))
> legend("topright", legend=c("TaylorSine(x)", "sin(x)", "y=x"), text.col=c(rgb(0,0,1), rgb(1,0,0), rgb(0,1,0)))
> 

> # Take TaylorSine for a test drive.
x <- seq(-2*pi, 2*pi, 0.01)
y <- numeric(length(x))
plot(x, y, xlim=c(-2*pi, 2*pi), ylim=c(-2,2), type="l", col=1)
for (i in 1:length(x)) {y[i] = TaylorSine(x[i], 5)} 
plot(x, y, xlim=c(-2*pi, 2*pi), ylim=c(-2,2), type="l", col=rgb(0,0,1), main="5th Order Approximation")
lines(x,sin(x), col=rgb(1,0,0))
lines(x,x, col=rgb(0,1,0))
legend("topright", legend=c("TaylorSine(x)", "sin(x)", "y=x"), text.col=c(rgb(0,0,1), rgb(1,0,0), rgb(0,1,0)))

x <- seq(-2*pi, 2*pi, 0.01)
y <- numeric(length(x))
plot(x, y, xlim=c(-2*pi, 2*pi), ylim=c(-2,2), type="l", col=1)
for (i in 1:length(x)) {y[i] = TaylorSine(x[i], 20)} 
plot(x, y, xlim=c(-2*pi, 2*pi), ylim=c(-2,2), type="l", col=rgb(0,0,1), main="20th Order Approximation")
#lines(x,sin(x), col=rgb(1,0,0))
lines(x,x, col=rgb(0,1,0))
legend("topright", legend=c("TaylorSine(x)", "sin(x)", "y=x"), text.col=c(rgb(0,0,1), rgb(1,0,0), rgb(0,1,0)))

x <- seq(-2*pi, 2*pi, 0.01)
y <- numeric(length(x))
orders <- seq(2, 20, 2)
plot(x, sin(x), xlim=c(-2*pi, 2*pi), ylim=c(-2,2), type="l", col=1, main="sin(x) and Approximations")
for (n in orders) {
	for (i in 1:length(x)) {y[i] = TaylorSine(x[i], n)} 
	lines(x, y)
}	

x <- seq(-2*pi, 2*pi, 0.05)
y <- numeric(length(x))
orders <- seq(2, 20, 2)
plot(x, sin(x), xlim=c(-2*pi, 2*pi), ylim=c(-2,2), type="l", col=1, main="sin(x) and approximations")
for (n in orders) {
	for (i in 1:length(x)) {y[i] = TaylorSine(x[i], n)} 
	lines(x, y, col=n)
}	


legend("topright", legend=c("TaylorSine(x)", "sin(x)", "y=x"), text.col=c(rgb(0,0,1), rgb(1,0,0), rgb(0,1,0)))

sds <- numeric(10)
for (i in 1:10) {
	sds[i] <- sdUniformDistSample(1000, i)
}
sds

X1 <- runif(1000, 0, 1)
X2 <- runif(1000, 0, 1)

X1 <- runif(1000, 0, 1)
X2 <- runif(1000, 0, 1)
Y2 = X1 + X2
X3 <- runif(1000, 0, 1)
X4 <- runif(1000, 0, 1)
X5 <- runif(1000, 0, 1)
Y5 = X1 + X2 + X3 + X4 + X5
qqnorm(Y5)
X6 <- runif(1000, 0, 1)
X7 <- runif(1000, 0, 1)
X8 <- runif(1000, 0, 1)
X9 <- runif(1000, 0, 1)
X10 <- runif(1000, 0, 1)
Y10 = X1 + X2 + X3 + X4 + X5 + X6 + X7 + X8 + X9 + X10
qqnorm(Y10)

par(mfcol=c(4,2))
hist(X1, prob=T)
qqnorm(X1)
hist(Y2, prob=T)
qqnorm(Y2)
hist(Y5, prob=T)
qqnorm(Y5)
hist(Y10, prob=T)
qqnorm(Y10)