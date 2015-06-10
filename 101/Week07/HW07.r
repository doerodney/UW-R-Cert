par(mfrow=c(1,3))
x.a = 1:6
f.a = dunif(x.a, 0, 6)
e.a = x.a * f.a
(sum(e.a))
plot(x.a, f.a, xlab="Abel", ylab="pmf", pch=19)
lines(x.a, f.a)

x.b = 0:6
f.b = dbinom(x.b, 6, 0.5)
e.b = x.b * f.b
(sum(e.b))
plot(x.b, f.b, main="Candy Distribution", xlab="Bernoulli", ylab="pmf", type="h")
points(x.b, f.b, pch=19)

x.c <- 0:4
f.c <- dbinom(x.c, 4, 0.75)
e.c = x.c * f.c
(sum(e.c))
plot(x.c, f.c, xlab="Cauchy",  ylab="pmf",type="h")
points(x.c, f.c, pch=19)

x.a = 1:6
f.a = dunif(x.a, 0, 6)
(var.a = ((6-1)^2) / 12)
e.a = x.a * f.a
(sum(e.a))

x.b = 0:6
f.b = dbinom(x.b, 6, 0.5)
(var.b=6*0.5*(1-0.5))
e.b = x.b * f.b
(sum(e.b))

x.c <- 0:4
f.c <- dbinom(x.c, 4, 0.75)
(var.c=4*0.75*(1-0.75))
e.c = x.c * f.c
(sum(e.c))

x.a = 1:6
f.a = dunif(x.a, 0, 6)
(var.a = ((6-0)^2) / 12)
[1] 3
e.a = x.a * f.a
(sum(e.a))
[1] 3.5

x.b = 0:6
f.b = dbinom(x.b, 6, 0.5)
(var.b=6*0.5*(1-0.5))
[1] 1.5
e.b = x.b * f.b
(sum(e.b))
[1] 3

x.c <- 0:4
f.c <- dbinom(x.c, 4, 0.75)
(var.c=4*0.75*(1-0.75))
[1] 0.75
e.c = x.c * f.c
(sum(e.c))
[1] 3

# Simulation of candy haul.
x.a = 1:6
x.b = 0:1
x.c = 1:52
candy.a = 0
candy.b = 0
candy.c = 0
candy = numeric(10000)
for (i in 1:length(candy)) {
	candy.a = 0
	candy.b = 0
	candy.c = 0
	# Min value can be 1 (Abel only).
	# Max value can be 6 (Abel) + 6 (Bernoulli) + 4 (Cauchy) = 16.
	
    # Abel simulation is simply to choose a random number in 1:6.
	# Failure is not possible.
	candy.a = sample(x.a, 1, replace=TRUE)
	
	# Bernoulli simulation is to choose a value between 0:1 6 times.
	# Result is count of odd numbers (heads = 1, tails = 0).
	# Successful if lands head.
	candy.b = 0
	for (b in 1:6) { candy.b = candy.b + sample(x.b, 1, replace=TRUE) }
	
	# Cauchy simulation is to sample a value in 1:52 4 times.
	# Hearts are values 1:13.
	# Successful if not a heart is drawn.
	for (c in 1:4) { candy.c = candy.c + (sample(x.c, 1, replace=TRUE) > 13) }
	
	candy[i] = candy.a + candy.b + candy.c
}

plot(candy)	


# Small simulation of candy haul.
x.a = 1:6
x.b = 0:1
x.c = 1:52
candy.a = 0
candy.b = 0
candy.c = 0
candy = numeric(100)
for (i in 1:length(candy)) {
	candy.a = 0
	candy.b = 0
	candy.c = 0
	# Min value can be 1 (Abel only).
	# Max value can be 6 (Abel) + 6 (Bernoulli) + 4 (Cauchy) = 16.
	
    # Abel simulation is simply to choose a random number in 1:6.
	# Failure is not possible.
	candy.a = sample(x.a, 1, replace=TRUE)
	
	# Bernoulli simulation is to choose a value between 0:1 6 times.
	# Result is count of odd numbers (heads = 1, tails = 0).
	# Successful if lands head.
	candy.b = 0
	for (b in 1:6) { candy.b = candy.b + sample(x.b, 1, replace=TRUE) }
	
	# Cauchy simulation is to sample a value in 1:52 4 times.
	# Hearts are values 1:13.
	# Successful if not a heart is drawn.
	for (c in 1:4) { candy.c = candy.c + (sample(x.c, 1, replace=TRUE) > 13) }
	
	candy[i] = candy.a + candy.b + candy.c
}


# Earthquake stuff-------------------------------------------------------------
setwd("C:/Users/Rod/SkyDrive/R/101/Week07")
eq = read.csv("Earthquakes.csv", header=T)
eq
str(eq)
Date <- as.POSIXlt(eq$Date)
Date
Minute <- as.numeric(Date - min(Date))/60
Minute
W = diff(Minute)
W
W = diff(Minute) * -1
W
hist(W)


# Gamma function
Gamma2PDF = function(x, lambda) {
	lambdasq = lambda * lambda
	d = numeric(length(x))
	for (i in 1:length(x)) { d[i] = (x[i]/lambdasq)*exp(-x[i]/lambda) }
	return(d) }
	
Gamma2PDF = function(x, lambda) {
lambdasq = lambda * lambda
d = numeric(length(x))
for (i in 1:length(x)) { d[i] = (x[i]/lambdasq)*exp(-x[i]/lambda) }
return(d) }
help(integrate)
(integrate(Gamma2PDF, 0, Inf))
x = 1:10
Gamma2PDF(x, 3)
(integrate(Gamma2PDF(1), 0, Inf))
(integrate(Gamma2PDF(1), 0, Inf, lambda=2))
(integrate(Gamma2PDF, lower=0, upper=Inf, lambda=2))
x = 0:100
plot(Gamma2PDF(x, 1))
plot(Gamma2PDF(x, 2))
x = 0:10
curve(Gamma2PDF(x, 1))
curve(Gamma2PDF(x, 2), add=TRUE, col=rgb(1,0,0))
plot(Gamma2PDF(x, 1))
plot(Gamma2PDF(x, 2), col="red")
plot(Gamma2PDF(x, 1), col="blue", add=TRUE)
plot(Gamma2PDF(x, 1), col="blue")
x
y1 = Gamma2PDF(x, 1)
y1
y2 = Gamma2PDF(x, 2)
plot(x, y1, col="red")
lines(x, y2, col="blue")
lines(x, y1, col="green")
v = sd(y1)
v
(sd(y2))
abline(v=sd(y1))
mean(y1)
mean(y2)
sd(y1)
sd(y2)
x=0:5
y1 = Gamma2PDF(x, 1)
y2 = Gamma2PDF(x, 2)
plot(x, y1, col="red")
lines(x, y1, col="red")
plot(x, y2, add=T, col="blue")
plot(x, y1, col="red")
lines(x, y1, col="red")
lines(x, y2, col="blue")
mean(y1)
mean(y2)
sd(y1)
mean(y)
mean(y1)
