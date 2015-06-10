
## @knitr ,results='asis',echo=FALSE,include=FALSE
require(knitr)
require(lattice)
#opts_chunk$set(cache=TRUE)
#suppressPackageStartupMessages(library(googleVis))
#print(gvisTable(cars, options=list('height'=200)), 'chart')
par(mar=c(4,4,1,1))
boston=read.csv('../Datasets/boston.csv',as.is=T)


## @knitr c5glm1,message=FALSE
library(lmtest)
glmod2=glm(log10(accel)~log10(dist)+mag,data=attenu,family=gaussian)
summary(glmod2) 


## @knitr c5logit,message=FALSE,fig.width=4, fig.height=5,out.width='400px', out.height='450px',dpi=500
curve(log((x)/(1-x)),col=2,lwd=2,main="The Logit Function",n=1000,xlab='p',ylab='logit(p)')


## @knitr c5challenger0
challenger=read.csv('../Datasets/challenger.csv',as.is=TRUE)
dim(challenger) # Data from Challenger launches and experiments before the tragic 1986 launch
table(challenger$atrisk) # Each of the 23 entries had 6 o-rings
table(challenger$Eroded) # This variable counts how many were eroded
table(challenger$tempF) # This is the critical variable. The temperature on the morning of the fatal launch was 31F.


## @knitr c5challenger1
challenger$tempcut=cut(challenger$tempF,c(50,60,69.5,75.5))
tapply(challenger$Eroded,challenger$tempcut,sum)/tapply(challenger$atrisk,challenger$tempcut,sum)
tapply(challenger$Eroded,challenger$Pressure,sum)/tapply(challenger$atrisk,challenger$Pressure,sum)


## @knitr c5challenger2
summary(glm(cbind(Eroded,Intact)~I(tempF-70)+Pressure,data=challenger,family=binomial))$coef


## @knitr c5challenger3
summary(glm(cbind(Eroded,Intact)~I(tempF-70),data=challenger,family=binomial))$coef
expit=function(x) exp(x)/(1+exp(x))
expit(-3.7475)


## @knitr c5quasi1,fig.width=5, fig.height=5,out.width='500px', out.height='500px',dpi=500
x=rnorm(100)  # log-normal
y=rpois(100,lambda=exp(x+rnorm(100))) # 2nd layer of randomization
summary(glm(y~x,family=poisson))$coef
plot(y~x,pch=19)


## @knitr c5quasi2
summary(glm(y~x,family=quasipoisson)) # only SE changes here...


## @knitr c5smspl,fig.width=8, fig.height=5,out.width='800px', out.height='500px',dpi=500
plot(discoveries,main='Annual Counts of Major Inventions and Disocoveries (World Almanac)',xlab="Year")
sline=smooth.spline(discoveries~time(discoveries))
lines(sline$x,sline$y,col=2,lwd=2)


## @knitr c5bspl,fig.width=8, fig.height=4,out.width='800px', out.height='400px',dpi=500
library(splines)
x=seq(0,10,.1)
mybase=bs(x,knots=c(2.5,5,7.5))
plot(c(0,10),c(0,1),type='n',main='Cubic B-Spline Basis, 3 Knots',ylab='Amplitude',xlab='x',sub='Knots marked in vertical lines')
for (a in 1:6) lines (x,mybase[,a],col=a+1,lwd=2)
abline(v=c(2.5,5,7.5),lty=2,lwd=2)


## @knitr c5nspl,fig.width=8, fig.height=5,out.width='800px', out.height='500px',dpi=500
mybase=ns(x,knots=c(2.5,5,7.5))
plot(c(0,10),c(0,1),type='n',main='Natural B-Spline Basis, 3 Knots',ylab='Amplitude',xlab='x',sub='Knots marked in vertical lines',ylim=c(-.7,.7))
for (a in 1:4) lines (x,mybase[,a],col=a+1,lwd=2)
abline(v=c(2.5,5,7.5),lty=2,lwd=2)


## @knitr c5bost1,fig.width=8, fig.height=5,out.width='800px', out.height='500px',dpi=500,message=FALSE
library(lmtest)
mod1=lm(homeval~lowSES+rooms,data=boston)
jobperm=order(boston$jobdist) ### This will be useful soon...
plot(log2(boston$jobdist),mod1$resid,pch=19,main="Distance from Job Centers vs. 'Basic' Model Residuals")
abline(h=0,col=2)


## @knitr c5bost2,message=FALSE
mod2=lm(homeval~lowSES+rooms+ns(log2(jobdist),df=2),data=boston)
mod3=lm(homeval~lowSES+rooms+ns(log2(jobdist),df=3),data=boston)
mod4=lm(homeval~lowSES+rooms+ns(log2(jobdist),df=4),data=boston)
mod5=lm(homeval~lowSES+rooms+ns(log2(jobdist),df=5),data=boston)
mod6=lm(homeval~lowSES+rooms+ns(log2(jobdist),df=6),data=boston)
mod7=lm(homeval~lowSES+rooms+ns(log2(jobdist),df=7),data=boston)
mod8=lm(homeval~lowSES+rooms+ns(log2(jobdist),df=8),data=boston)
mod9=lm(homeval~lowSES+rooms+ns(log2(jobdist),df=9),data=boston)
lrtest(mod1,mod2,mod3,mod4,mod5,mod6,mod7,mod8,mod9)


## @knitr c5bost3,fig.width=8, fig.height=5,out.width='800px', out.height='500px',dpi=500,message=FALSE
plot(log2(boston$jobdist),mod1$resid,pch=19,main="Now enter the Splines...")
lines(log2(boston$jobdist[jobperm]),mod2$fitted[jobperm]-mod1$fitted[jobperm],col=2,lwd=2)
lines(log2(boston$jobdist[jobperm]),mod3$fitted[jobperm]-mod1$fitted[jobperm],col=3,lwd=2)
lines(log2(boston$jobdist[jobperm]),mod4$fitted[jobperm]-mod1$fitted[jobperm],col=4,lwd=2)
lines(log2(boston$jobdist[jobperm]),mod5$fitted[jobperm]-mod1$fitted[jobperm],col=5,lwd=2)
lines(log2(boston$jobdist[jobperm]),mod8$fitted[jobperm]-mod1$fitted[jobperm],col=6,lwd=2)
legend('topright',legend=paste(c(2:5,8),'df'),lty=1,col=2:6)


## @knitr c5bost4,message=FALSE
mod44=lm(homeval~lowSES+rooms+ns(log2(jobdist),knots=quantile(log2(jobdist),c(1/6,1/3,2/3))),data=boston)
mod55=lm(homeval~lowSES+rooms+ns(log2(jobdist),knots=quantile(log2(jobdist),c(1/12,1/6,1/3,2/3))),data=boston)
mod66=lm(homeval~lowSES+rooms+ns(log2(jobdist),knots=quantile(log2(jobdist),c(1/24,1/12,1/6,1/3,2/3))),data=boston)
mod77=lm(homeval~lowSES+rooms+ns(log2(jobdist),knots=quantile(log2(jobdist),c(1/48,1/24,1/12,1/6,1/3,2/3))),data=boston)
mod88=lm(homeval~lowSES+rooms+ns(log2(jobdist),knots=quantile(log2(jobdist),c(1/96,1/48,1/24,1/12,1/6,1/3,2/3))),data=boston)
lrtest(mod3,mod44,mod55,mod66,mod77,mod88)


## @knitr c5bost5,fig.width=8, fig.height=5,out.width='800px', out.height='500px',dpi=500,message=FALSE
plot(log2(boston$jobdist),mod1$resid,pch=19,main="Trying again...")
lines(log2(boston$jobdist[jobperm]),mod3$fitted[jobperm]-mod1$fitted[jobperm],col=3,lwd=2)
lines(log2(boston$jobdist[jobperm]),mod44$fitted[jobperm]-mod1$fitted[jobperm],col=4,lwd=2)
lines(log2(boston$jobdist[jobperm]),mod55$fitted[jobperm]-mod1$fitted[jobperm],col=5,lwd=2)
lines(log2(boston$jobdist[jobperm]),mod66$fitted[jobperm]-mod1$fitted[jobperm],col=6,lwd=2)
lines(log2(boston$jobdist[jobperm]),mod77$fitted[jobperm]-mod1$fitted[jobperm],col=2,lwd=2)
legend('topright',legend=paste(3:7,'df'),lty=1,col=c(3:6,2))


## @knitr c5bwplot0,fig.width=15, fig.height=5,out.width='1500px', out.height='500px',dpi=500,cache=TRUE
wine=read.csv('../Datasets/winequality-white.csv',as.is=T)
bwplot(alcohol~quality | cut(volatile.acidity,quantile(volatile.acidity)),data=wine,col=2,pch=19,cex=2,horiz=F)


## @knitr c5bwplot1,fig.width=15, fig.height=5,out.width='1500px', out.height='500px',dpi=500

bwplot(alcohol~quality | cut(volatile.acidity,quantile(volatile.acidity)),data=wine,pch='|',varwidth=T,par.settings = list(box.umbrella=list(col= 1,lty=1,coef=3.5),box.rectangle = list(col=1,fill=c(1,3:8)),plot.symbol=list(pch=19,col=2)),horiz=F,notch=T)


## @knitr c5bwplot2,fig.width=15, fig.height=5,out.width='1500px', out.height='500px',dpi=500

bwplot(alcohol~quality | cut(volatile.acidity,quantile(volatile.acidity)),data=wine,panel=panel.violin,horiz=F)


## @knitr c5alan,fig.width=12, fig.height=5,out.width='1200px', out.height='500px',dpi=500
xyplot(homeval~rooms | factor(river,labels=c("Not by River","By Charles River")),pch=19,data=boston,scales=list(alternating=3))


