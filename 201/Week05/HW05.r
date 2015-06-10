setwd("C:/Users/Rod/SkyDrive/R/201/Week05")  
challenger = read.csv("challenger.csv")
heart = read.csv("HosmerLemeshowHeart.csv")

str(heart)
table(heart$Age)
heart$AgeBin = cut(heart$Age, breaks = quantile(heart$Age, names = FALSE))
table(heart$AgeBin)
table(heart$Disease)

fit = glm(Disease ~ AgeBin, data = heart, family = binomial)
summary.glm(fit)

fit = glm(Disease ~ Age, data = heart, family = binomial)
summary.glm(fit)

age = c(20, 30, 40, 50, 60, 70)
response=predict(fit, list(Age=age), type="response")
plot(age, response, main="Odds of heart disease p/(1-p) increase with age")

	


#==============================================================================
setwd("C:/Users/Rod/SkyDrive/R/201/Week02")  
boston = read.csv("Boston.csv")

library(splines)
x=seq(0,10,.1)
mybase=bs(x,knots=c(2.5,5,7.5))
plot(c(0,10), c(0,1), type='n', main='Cubic B-Spline Basis, 3 Knots',
  ylab='Amplitude',
  xlab='x',
  sub='Knots marked in vertical lines')

for (a in 1:6) lines (x,mybase[,a],col=a+1,lwd=2)
abline(v=c(2.5,5,7.5),lty=2,lwd=2)

library(lmtest)
mod1=lm(homeval~lowSES+rooms,data=boston)
jobperm=order(boston$jobdist) ### This will be useful soon...
plot(log2(boston$jobdist),mod1$resid,pch=19,main="Distance from Job Centers vs. 'Basic' Model Residuals")
abline(h=0,col=2)

fit = lm(homeval ~ lowSES + rooms, data=boston)
summary.lm(fit)

#==============================================================================
setwd("C:/Users/Rod/SkyDrive/R/201/Week02")  
boston = read.csv("Boston.csv")
str(boston)
m0 = lm(homeval ~ lowSES + rooms, data=boston)
plot(boston$homeval, boston$crime)
plot(boston$homeval, boston$biglots)
plot(boston$homeval, boston$river)
plot(boston$homeval, boston$nox) # interesting
plot(boston$homeval, boston$old)  
plot(boston$homeval, boston$jobdist) # interesting, but done in class
plot(boston$homeval, boston$tax)
plot(boston$homeval, boston$teachratio)
plot(boston$homeval, boston$crime) #interesting
summary.lm(m0)

m1 = lm(homeval ~ lowSES + rooms + crime, data=boston)
summary.lm(m1) #p-value crime = 0.001
str(m1)
confint(m1)
fitted(m1)
residuals(m1)
plot(residuals(m1))
plot(boston$homeval, fitted(m1))
plot(boston$homeval, fitted(m0))
library(splines)
m2 = lm(homeval ~ lowSES + rooms + ns(crime, df=2), data=boston)
m3 = lm(homeval ~ lowSES + rooms + ns(crime, df=3), data=boston)
m4 = lm(homeval ~ lowSES + rooms + ns(crime, df=4), data=boston)
m4 = lm(homeval ~ lowSES + rooms + ns(crime, df=4), data=boston)

library(lmtest)

lrtest(m0, m1, m2, m3, m4, m5, m6, m7)

plot(boston$crime, residuals(m1), pch=19, main="Spline result comparison")
lines(boston$crime, fitted(m2) - fitted(m1), col=2, lwd=2)
lines(boston$crime, fitted(m3) - fitted(m1), col=3, lwd=2)
lines(boston$crime, fitted(m4) - fitted(m1), col=4, lwd=2)
lines(boston$crime, fitted(m5) - fitted(m1), col=5, lwd=2)
lines(boston$crime, fitted(m6) - fitted(m1), col=6, lwd=2)
lines(boston$crime, fitted(m7) - fitted(m1), col=7, lwd=2)
legend("topright", legend=paste(c(2:7), "df"), lty=1, col=2:7)


