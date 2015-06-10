
head(ChickWeight)
  # weight Time Chick Diet
# 1     42    0     1    1
# 2     51    2     1    1
# 3     59    4     1    1
# 4     64    6     1    1
# 5     76    8     1    1
# 6     93   10     1    1

# Assaf's example spaghetti plot.
library(lattice)
xyplot(weight~Time | Diet,data=ChickWeight,group=Chick,type='l',
       scales=list(alternating=3),main="Chick Growth by Diet Type",xlab="Age (Days)") 

# Try to do the same thing with ggplot2.
library(ggplot2)
qplot(x=Time, y=weight, data=ChickWeight, group=Chick, color=Diet, geom="line")

# Mixed effect model for ChickWeight
library(nlme)
library(lattice)

results <- groupedData(weight ~ Time |Chick, outer =  ~ Diet, data=ChickWeight)

results <- groupedData(weight ~ Time |Chick, outer= ~ Diet, order.groups=TRUE, data=ChickWeight)
plot(results)
plot(results, outer=TRUE)

# Mixed effect model for ChickWeight
library(nlme)
library(lattice)

results <- groupedData(weight ~ Time |Chick, outer= ~ Diet, order.groups=TRUE, data=ChickWeight)
plot(results, outer=TRUE)  # Useful and interesting.  Shows that 3 has the most effect.

plot(results)  # Not that useful

suppressWarnings(	results <- groupedData(weight ~ Time | Diet, outer= ~ Chick, order.groups=TRUE, data=ChickWeight)  )
suppressWarnings( plot(results) )  # Useful and interesting, shows that 3 has the most effect (steepest slope for group).  

plot(results, outer=TRUE)  # Not that useful

model <- lme(weight~Diet, random= ~Time|Chick, data=ChickWeight)

summary(model)
hist(model$residuals)

# Back to mpg dataset.
setwd("C:/Users/Rod/SkyDrive/R/301/Week05")
autos = read.csv("autoMPGtest.csv")

setwd("C:/Users/Rod/SkyDrive/R/301/Week05")
autos = read.csv("autoMPGtest.csv")
str(autos)
which(autos$mpg > 46)

> autos[which(autos$mpg > 46),]
        name cyl volume hp weight accel year continent  mpg
86 mazda glc   4     86 65   2110  17.9   80         3 46.6

# Assaf's lecture code (adapted)
library(mgcv)
setwd("C:/Users/Rod/SkyDrive/R/301/Week05")
autos = read.csv("autoMPGtrain.csv", as.is = TRUE)
autos$continent = factor(autos$continent)
autos$name = tolower(autos$name)
autos$diesel = grepl("diesel", autos$name)
autos$diesel[autos$name == "mercedes-benz 240d"] = TRUE
autos$cylgroup = cut(autos$cyl, c(2, 5.5, 6.5, 9))
gam4=gam(mpg~continent+diesel+cylgroup+s(weight,by=cylgroup)+s(year,k=13)+s(accel)+s(hp),data=autos,select=TRUE)
plot(gam4,pages=1)

# Assaf used an rmse function.  Implement it.
rmse <- function(predicted, observed) { err <- sqrt(mean((predicted - observed)^2)); err }

autest = read.csv("autoMPGtest.csv", as.is = TRUE)
autest$continent = factor(autest$continent)
autest$name = tolower(autest$name)
autest$diesel = grepl("diesel", autest$name)
autest$diesel[autest$name == "mercedes benz 300d"] = TRUE
autest$cylgroup = cut(autest$cyl, c(2, 5.5, 6.5, 9))
gampreds = predict(gam4, newdata = autest)
rmse(gampreds, autest$mpg)

# Exclude outlier
idx = which(autest$mpg < 46)
gampreds2 = predict(gam4, newdata = autest[idx,])
rmse(gampreds2, autest$mpg[idx])

# Need a function to calculate absolute error, where 
# absolute error = absolute value of difference.
abse <- function(predicted, observed) { err <- abs(predicted - observed); sum(err) }

# Get vectors of absolute errors and do a summary to compare 75% percentile (3rd quartile).
abserrs = abs(gampreds - autest$mpg)
abserrs2 = abs(gampreds2 - autest$mpg[idx])
summary(abserrs)
summary(abserrs2)

( abse(gampreds,autest$mpg) )
( abse(gampreds2, autest$mpg[idx])  )



# The Assaf Number
Assafian <- function(predicted, observed) {
# Get the difference in 3rd quartiles.
summaryPredicted = summary(predicted)
summaryObserved = summary(observed)
label = '3rd Qu.'
percentileDiff = abs(summaryPredicted[label] - summaryObserved[label])

# Get the absolute difference between predicted and observed.
absdiff <- sum(abs(predicted - observed)); 

# Take the mean of the two results.
assafian = mean(c(absdiff, percentileDiff))
 
assafian
}

# From last quarter, my best performing parsimonious model:
# gp100m ~ weight + year + continent + diesel
# Try this:
gam5 = gam(mpg ~ weight + year + continent + diesel, data=autos, select=TRUE)
gampreds5 = predict(gam5, newdata = autest)
(Assafian(gampreds5, autest$mpg))


gampreds6 = predict(gam6, newdata=autest)
(Assafian(gampreds6, autest$mpg))
> gampreds6 = predict(gam6, newdata=autest)
> (Assafian(gampreds6, autest$mpg))
[1] 121.3225

library(ggplot2)
qplot(Time, weight, data=ChickWeight, col=Chick, facets=Diet) + geom_line() + guides(col = guide_legend(ncol = 4))


