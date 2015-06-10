setwd("C:/Users/Rod/SkyDrive/R/201/Week06")  
mpg = read.csv("autoMPGtrain.csv")

library("knitr")
summary(cards)
summary(cars)
str(cars)
Header 1
setwd("C:/Users/Rod/SkyDrive/R/201/Week06")  
mpg = read.csv("autoMPGtrain.csv")
str(mpg)
cor(mpg)
pairs(mpg)
fit = lm(mpg ~ cyl + volume + hp + weight + accel + year)
fit = lm(mpg ~ cyl + volume + hp + weight + accel + year, data=mpg)
summary(fit)
fit.reduced = step(fit)
summary(fit.reduced)
str(mpg)

autos = read.csv("autoMPGtrain.csv")
autos$gp100m=100/autos$mpg
autos$continent=factor(autos$continent)
autos$diesel=grepl('diesel',autos$name)
# reference 'full models'
fullmod=lm(gp100m~.,data=autos[,-c(1,9)])
fullWinteract=lm(gp100m~.^2,data=autos[,-c(1,9)])
emptymod=lm(gp100m~1,data=autos[,-c(1,9)])

source('cvEngine.r')
source('.cvConstrainedSubsets.r')
cvid=sample(1:5,size=298,replace=TRUE) ## K=5 CV groups