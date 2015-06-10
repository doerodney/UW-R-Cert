
## @knitr c4load,results='asis',cache=FALSE,echo=FALSE,include=FALSE
require(knitr)
require(lattice)
require(ggplot2)
require(data.table)
layout(1)
opts_chunk$set(cache=FALSE,message=FALSE)
#suppressPackageStartupMessages(library(googleVis))
source('../Code/enhancedGraphics.r')
rmse<-function(x,ref) sqrt(mean((x-ref)^2))


## @knitr c5savings1,fig.width=9, fig.height=5,out.width='900px',out.height='500px',dpi=300,tidy=FALSE
options(width=132);plot(psavert~date,data=economics,pch=19,cex=.7,xlab="Year",ylab="Mean US Personal Savings Rate (%)")
lines(smooth.spline(as.numeric(economics$date),economics$psavert),col=2,lwd=2)


## @knitr c5savings2,fig.width=9, fig.height=5,out.width='900px',out.height='500px',dpi=300,tidy=FALSE
plot(psavert~date,data=economics,pch=19,cex=.7,xlab="Year",
     ylab="Mean US Personal Savings Rate (%)")
lines(smooth.spline(as.numeric(economics$date),economics$psavert),col=2,lwd=2)
lines(smooth.spline(as.numeric(economics$date),economics$psavert,df=5),col=3)
lines(smooth.spline(as.numeric(economics$date),economics$psavert,df=50),col=4)


## @knitr c5auto0,cache=FALSE
library(mgcv)
autos=read.csv('../Datasets/autoMPGtrain.csv',as.is=TRUE)
autos$continent=factor(autos$continent)
autos$name=tolower(autos$name)
autos$diesel=grepl('diesel',autos$name)
autos$diesel[autos$name=="mercedes-benz 240d"]=TRUE
autos$cylgroup=cut(autos$cyl,c(2,5.5,6.5,9))


## @knitr c5auto1
gam0=gam(mpg~diesel+continent+s(weight)+s(year),data=autos)


## @knitr c5auto2
summary(gam0)


## @knitr c5autos3,fig.width=11, fig.height=6,out.width='1100px',out.height='600px',dpi=300,tidy=FALSE,message=FALSE
plot(gam0,pages=1)


## @knitr c5autos32,fig.width=11, fig.height=6,out.width='1100px',out.height='600px',dpi=300,tidy=FALSE,message=FALSE
gam.check(gam0)


## @knitr c5autos4a
gam1=gam(mpg~continent+cylgroup*s(weight)+cylgroup*s(year),data=autos)


## @knitr c5autos4b,message=FALSE
gam1=gam(mpg~continent+diesel+s(weight,by=cylgroup)+s(year,by=cylgroup,k=13),data=autos)
summary(gam1)


## @knitr c5autos5,fig.width=11, fig.height=6,out.width='1100px',out.height='600px',dpi=300,tidy=FALSE
plot(gam1,pages=1)


## @knitr c5autos6,message=FALSE
anova(gam0,gam1)


## @knitr c5autos,fig.width=11, fig.height=6,out.width='1100px',out.height='600px',dpi=300,tidy=FALSE
options(width=132); gam2=gam(mpg~continent+diesel+te(weight,year,by=cylgroup),data=autos)
par(mfrow=c(1,3)); plot(gam2)


## @knitr c5autos8,message=FALSE
anova(gam1,gam2)


## @knitr c5autos9
gam3=gam(mpg~continent+diesel+cylgroup+s(weight,by=cylgroup)+s(year,by=cylgroup,k=13)+s(accel)+s(volume)+s(hp),data=autos,select=TRUE)
summary(gam3)
anova(gam1,gam3)


## @knitr c5autos10,fig.width=11, fig.height=6,out.width='1100px',out.height='600px',dpi=300,tidy=FALSE
gam4=gam(mpg~continent+diesel+cylgroup+s(weight,by=cylgroup)+s(year,k=13)+s(accel)+s(hp),data=autos,select=TRUE)
plot(gam4,pages=1)


## @knitr c5autos11,cache=FALSE
autest=read.csv('../Datasets/autoMPGtest.csv',as.is=TRUE)
autest$continent=factor(autest$continent)
autest$name=tolower(autest$name)
autest$diesel=grepl('diesel',autest$name)
autest$diesel[autest$name=="mercedes benz 300d"]=TRUE
autest$cylgroup=cut(autest$cyl,c(2,5.5,6.5,9))
gampreds=predict(gam4,newdata=autest)
rmse(gampreds,autest$mpg)


## @knitr c5autos12,fig.width=5, fig.height=5,out.width='500px',out.height='500px',dpi=300,tidy=FALSE
plot(autest$mpg,gampreds,pch=19,col=autest$cylgroup,main="GAM Predictions")
abline(0,1,col=4)


## @knitr c5autos13
autos$gp100m=100/autos$mpg
autest$gp100m=100/autest$mpg
hw4=lm(gp100m~volume+hp+weight+accel+year+diesel+cylgroup+weight:year,data=autos)
hw4preds=predict(hw4,newdata=autest)  ## Best HW4 model...
rmse(100/hw4preds,autest$mpg)
rmse(100/gampreds,autest$gp100m)  ### Now on the GP100m scale...
rmse(hw4preds,autest$gp100m)
baseAIC = step(lm(mpg ~ .*weight, data = autos[,-c(1,2,12)]), trace = 0, direction ="backward")
aicpred=predict(baseAIC,newdata=autest)
rmse(aicpred,autest$mpg)


