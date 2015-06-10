
## @knitr c2attenu1
summary(lm(log10(accel)~log10(dist)+mag,data=attenu))$coef
summary(lm(log10(accel)~log10(dist)*mag,data=attenu))$coef


## @knitr c2attenu2
summary(attenu$mag)  
# Let's mean-center the magnitude first...


## @knitr c2attenu3
summary(lm(log10(accel)~log10(dist)*I(mag-6),data=attenu))$coef


## @knitr preamble, results='asis',echo=FALSE,include=FALSE
require(knitr)
opts_chunk$set(cache=TRUE)
source('../Code/enhancedGraphics.r')


## @knitr cig0, fig.width=7, fig.height=7,out.width='700px', out.height='700px',dpi=500
cig=read.table('../Datasets/Amstat_cigarettes.csv',header=T, as.is=T, row.names=1)
pairsPlus(cig)


## @knitr cig1
summary(lm(CO~tar,data=cig))$coef
summary(lm(CO~nicotine,data=cig))$coef
summary(lm(CO~weight,data=cig))$coef


## @knitr cig2
summary(lm(CO ~ tar + nicotine + weight, data = cig))$coef


## @knitr cig3
cig$nicwt=cig$tar+10*cig$weight
summary(lm(CO ~ tar + nicotine + weight + nicwt, data = cig))


## @knitr cig4
cig$nicwt=cig$tar+10*cig$weight+rnorm(25)
round(cor(cig),2)
summary(lm(CO ~ tar + nicotine + weight + nicwt, data = cig))$coef


## @knitr quake1,echo=FALSE,fig.width=12, fig.height=4,out.width='1500px', out.height='500px',dpi=500
quakemod = lm(log10(accel) ~ log10(dist) + mag, data = attenu)
layout(t(1:4))
plot(quakemod$resid~attenu$mag,pch=19,ylab='Residuals',xlab='Quake Magnitude',col=4,cex.lab=1.3)
plot(quakemod$resid~log10(attenu$dist),ylab='Residuals',xlab='Log Distance',pch=19,col=4,cex.lab=1.3)
plot(quakemod$resid~quakemod$fitted,ylab='Residuals',xlab='Fitted Values',pch=19,col=4,cex.lab=1.3)
qqnorm(quakemod$resid,pch=19,col=4,cex.lab=1.3,main="Quantile Plot of Residuals")


## @knitr quake11,echo=FALSE,fig.width=15, fig.height=4,out.width='1500px', out.height='400px',dpi=500
layout(t(1:4))
plot(quakemod$resid~attenu$mag,pch=19,ylab='Residuals',xlab='Quake Magnitude',col=4,cex.lab=1.3)
plot(quakemod$resid~log10(attenu$dist),ylab='Residuals',xlab='Log Distance',pch=19,col=4,cex.lab=1.3)
plot(quakemod$resid~quakemod$fitted,ylab='Residuals',xlab='Fitted Values',pch=19,col=4,cex.lab=1.3)
qqnorm(quakemod$resid,pch=19,col=4,cex.lab=1.3,main="Quantile Plot of Residuals")


## @knitr outlier1,echo=FALSE,fig.width=9, fig.height=5,out.width='1100px', out.height='600px',dpi=500
badnox=read.csv('../Datasets/badnox.csv',as.is=T)
badnox$date=as.Date(badnox$date)
plot(log10(nox)~date,data=badnox,pch=19,col=4,cex=.7,main='NOx Time Series at a Bakersfield Monitor',xlab='Year')


## @knitr stackloss0,echo=FALSE,fig.width=6, fig.height=6,out.width='700px', out.height='700px',dpi=500
source('../Code/enhancedGraphics.r')
pairsPlus(stackloss)


## @knitr stackloss1
stackmod0=lm(I(stack.loss/10)~Air.Flow+Water.Temp,data=stackloss) # Acid conc. not significant
summary(stackmod0)  # Take a load of this fabulous R^2 !


## @knitr stackloss2,fig.width=6, fig.height=6,out.width='500px', out.height='500px',dpi=500
qqnorm(stackmod0$resid,pch=19,col=4)


## @knitr stackloss3,fig.width=6, fig.height=6,out.width='500px', out.height='500px',dpi=500
tees=rstudent(stackmod0) # Told u it's simple...
qqnorm(tees,pch=19,col=4)
c(min(tees),2*pt(min(tees),df=length(tees)-4))


## @knitr anscombe0,echo=FALSE,fig.width=5, fig.height=5,out.width='800px', out.height='800px',dpi=500
layout(matrix(1:4,nrow=2))
par(mar=c(4,3,1,1))
plot(y1~x1,data=anscombe,pch=19,col=4,ylim=c(3,12.5))
abline(lm(y1~x1,data=anscombe),col=2)
plot(y2~x2,data=anscombe,pch=19,col=4,ylim=c(3,12.5))
abline(lm(y2~x2,data=anscombe),col=2)
plot(y3~x3,data=anscombe,pch=19,col=4,ylim=c(3,12.5))
abline(lm(y3~x3,data=anscombe),col=2)
plot(y4~x4,data=anscombe,pch=19,col=4,ylim=c(3,12.5))
abline(lm(y4~x4,data=anscombe),col=2)

