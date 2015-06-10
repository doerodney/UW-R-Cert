## @knitr ,results='asis',echo=FALSE,include=FALSE,message=FALSE
require(knitr)
require(lattice)
opts_chunk$set(message=FALSE,cache=TRUE)
#suppressPackageStartupMessages(library(googleVis))
#print(gvisTable(cars, options=list('height'=200)), 'chart')
par(mar=c(4,4,1,1))
boston=read.csv('../Datasets/boston.csv',as.is=T)
source('../Code/enhancedGraphics.r')
source("../Code/myVIF.r")
library(HH)
library(car)


## @knitr hw1pairs1,fig.width=6, fig.height=6,out.width='600px', out.height='600px',dpi=500,message=FALSE
pairsPlus(boston)


## @knitr hw1pairs2,fig.width=5, fig.height=5,out.width='500px', out.height='500px',dpi=500,message=FALSE
pairsPlus(boston,pagesize=6,diag.panel=panel.qq,scramble=T)


## @knitr myvif,message=FALSE
myvif(boston[,-12])


## @knitr hw1bostvar1,fig.width=8, fig.height=4,out.width='800px', out.height='400px',dpi=500,message=FALSE
layout(t(1:2))
summary(boston$crime)
qqnorm(boston$crime,pch=19,main="Crime Rate")
qqnorm(log10(boston$crime),pch=19,main="log10(Crime Rate)")


## @knitr hw1bostvar2,fig.width=8, fig.height=4,out.width='800px', out.height='400px',dpi=500,message=FALSE
layout(t(1:2))
summary(boston$biglots)
table(boston$biglots==0)
sort(unique(boston$biglots))[1:3]
qqnorm(boston$biglots,pch=19,main="% Big Lots")
qqnorm(log10(boston$biglots+1),pch=19,main="log(% Big Lots+1)")


## @knitr hw1bostvar3,fig.width=8, fig.height=4,out.width='800px', out.height='400px',dpi=500,message=FALSE
layout(t(1:2))
summary(boston$jobdist)
qqnorm(boston$jobdist,pch=19,main="Distance to Jobs")
qqnorm(log10(boston$jobdist),pch=19,main="log10(Distance to Jobs)")


## @knitr hw1bostvar4,fig.width=8, fig.height=4,out.width='800px', out.height='400px',dpi=500,message=FALSE
layout(t(1:3))
table(table(boston$tax))
table(table(boston$indust))
table(table(boston$teachratio))
plot(density(boston$tax,bw=5),pch=19,main="Property Tax")
plot(density(boston$teachratio,bw=0.2),pch=19,main="Student/Teacher Ratio")
plot(density(boston$indust,bw=0.5),pch=19,main="% Industrial Land-Use")


## @knitr hw1bostvar5,fig.width=8, fig.height=4,out.width='800px', out.height='400px',dpi=500,message=FALSE
logit=function(x) log(x/(1-x))
layout(t(1:2))
qqnorm(logit(boston$lowSES/100),main="logit(LowSES)")
plot(homeval~logit(lowSES/100),data=boston,pch=19)


## @knitr hw1bosty,fig.width=8, fig.height=4,out.width='800px', out.height='400px',dpi=500,message=FALSE
layout(t(1:2))
plot(density(boston$homeval,bw=.5,cut=0),main="Home Values (note the rug!)")
rug(boston$homeval,col=4)
qqnorm(boston$homeval,pch=19,main="Home Values")


## @knitr hw1pairs3,fig.width=6, fig.height=6,out.width='600px', out.height='600px',dpi=500,message=FALSE
boston$logcrime=log10(boston$crime)
boston$logjdist=log10(boston$jobdist)
boston$taxlevel=cut(boston$tax,c(0,500,1000),labels=c("low","high"))
boston$povertyOdds=logit(boston$lowSES/100)
pairsPlus(boston[,c(13:16,12)])


## @knitr hw1lattice1,fig.width=7, fig.height=3,out.width='800px', out.height='500px',dpi=500,message=FALSE
lmpanel=function(x,y,...) {
  panel.xyplot(x,y,...)
  panel.abline(lm(y~x),col=2)
  }
xyplot(homeval~rooms | cut(povertyOdds,quantile(povertyOdds,p=0:3/3)),data=boston,pch=19,panel=lmpanel,main="Home-Size Effect by Log-Poverty-Odds",scales=list(alternating=3),cex=0.7,col=4)


## @knitr hw1lattice5,fig.width=7, fig.height=4,out.width='800px', out.height='500px',dpi=500,message=FALSE
xyplot(homeval~rooms | taxlevel,data=boston,pch=19,panel=lmpanel,main="Home-Size Effect by Tax Rate",scales=list(alternating=3),cex=0.7,col=4)


## @knitr hw1lattice2,fig.width=7, fig.height=4,out.width='800px', out.height='500px',dpi=500,message=FALSE
xyplot(homeval~nox | cut(povertyOdds,quantile(povertyOdds,p=0:3/3))+cut(rooms,c(0,6,10)),data=boston,pch=19,panel=lmpanel,main="Nox Effect by Main 2 Covariates",scales=list(alternating=3),cex=0.7,col=4)


## @knitr hw1lattice3,fig.width=7, fig.height=4,out.width='800px', out.height='500px',dpi=500,message=FALSE
xyplot(homeval~old | cut(povertyOdds,quantile(povertyOdds,p=0:3/3))+cut(rooms,c(0,6,10)),data=boston,pch=19,panel=lmpanel,main="Old-House Effect by Main 2 Covariates",scales=list(alternating=3),cex=0.7,col=4)


## @knitr hw1lattice4,fig.width=7, fig.height=4,out.width='800px', out.height='500px',dpi=500,message=FALSE
xyplot(homeval~logjdist | cut(povertyOdds,quantile(povertyOdds,p=0:3/3))+cut(rooms,c(0,6,10)),data=boston,pch=19,panel=lmpanel,main="Log-Job-Distance Effect by Main 2 Covariates",scales=list(alternating=3),cex=0.7,col=4)


