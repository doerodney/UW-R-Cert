
## @knitr ,results='asis',echo=FALSE,include=FALSE
require(knitr)
opts_chunk$set(cache=TRUE)
#suppressPackageStartupMessages(library(googleVis))
#print(gvisTable(cars, options=list('height'=200)), 'chart')
par(mar=c(4,4,1,1))


## @knitr c3sim0,fig.width=7, fig.height=4,out.width='700px', out.height='380px',dpi=500
x=matrix(rnorm(100000),nrow=10) # x, y independent of each other
y=matrix(rnorm(100000),nrow=10) # Now, a first example using 'mapply'; can be done with loop too
mypees=mapply(function(z,w) summary(lm(w~z))$coef[2,4],
              split(x,col(x)),split(y,col(y)))
plot(-log10(mypees),pch=19,cex=.3,main="Manhattan: Null Normal Case",xlab="Test Number:")
abline(h=c(-log10(0.05),3),col=2)


## @knitr c3unif, fig.width=7, fig.height=4,out.width='700px', out.height='400px',dpi=500
beta=5
y=runif(8,0,beta)

x=(0:1000)/100
plot(x,ifelse(x<max(y),0,x^(-10)),pch=19,col=2,cex=0.5,xlab='Beta',ylab='Likelihood')
abline(v=max(y),lwd=2)


## @knitr logismle
# logistic (-log(likelihood)) function with a covariate vector 'cv'
logislike=function(bet,dat,cv) {
  length(dat)*log(bet[3])  +2*sum(log(cosh((dat-bet[1]-bet[2]*cv) / (2*bet[3]))))}
z=2*rnorm(20) 
y=z+rlogis(20)
summary(lm(y~z))$coef
mle=optim(c(0,0,1),fn=logislike,dat=y,cv=z)
mle$par # Intercept, beta, and scale ('sd') parameters


## @knitr c3double, fig.width=8, fig.height=3,out.width='800px', out.height='300px',dpi=500,message=FALSE
library(VGAM)
par(mar=c(3,3,1,1))
curve(dlaplace,-5,5,col=2,lwd=2)


## @knitr quant0,message=FALSE,fig.width=4, fig.height=4,out.width='400px', out.height='400px',dpi=500
# The Anscombe example w/the outlier
summary(lm(y3~x3,data=anscombe))$coef 
plot(y3~x3,data=anscombe)
abline(lm(y3~x3,data=anscombe),col=2)


## @knitr quant1,message=FALSE,fig.width=4, fig.height=4,out.width='400px', out.height='400px',dpi=500
library(quantreg)
summary(rq(y3~x3,data=anscombe))$coef
plot(y3~x3,data=anscombe)
abline(rq(y3~x3,data=anscombe),col=2)


## @knitr robust,message=FALSE,fig.width=4, fig.height=4,out.width='400px', out.height='400px',dpi=500
library(MASS)
summary(rlm(y3~x3,data=anscombe))$coef
plot(y3~x3,data=anscombe)
abline(rlm(y3~x3,data=anscombe),col=2)


## @knitr c3load0,message=FALSE,echo=FALSE
detach(package:car)
detach(package:HH)


## @knitr c3load1,message=FALSE,cache=FALSE
library(car)
library(HH)
vif


## @knitr c3load2
search()


## @knitr c3load3,message=FALSE,cache=FALSE
detach(2)
vif


## @knitr c3load4,message=FALSE,cache=FALSE
library(HH,pos=20)
vif


## @knitr c3mathtitle1,message=FALSE,fig.width=7, fig.height=4,out.width='700px', out.height='400px',dpi=500
x=matrix(rexp(2000),nrow=20)
y=matrix(x+rexp(2000),nrow=20)
z=mapply(function(a,b) lm(b~a)$coef[2],split(x,col(x)),split(y,col(y)))
mymain=bquote(paste("Distribution of ",hat(beta)," with Exponential Noise (",.(dim(x)[2])," runs of n=",.(dim(x)[1])," each)",sep=""))
plot(density(z),main=mymain,xlab="Least-Squared Estimate")
abline(v=1,col=2)


