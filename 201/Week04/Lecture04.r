
## @knitr ,results='asis',echo=FALSE,include=FALSE
require(knitr)
#opts_chunk$set(cache=TRUE)
#suppressPackageStartupMessages(library(googleVis))
#print(gvisTable(cars, options=list('height'=200)), 'chart')
boston=read.csv('../Datasets/boston.csv',as.is=T)
library(lattice)
par(mar=c(4,4,1,1))


## @knitr c4lat1,fig.width=7, fig.height=5,out.width='700px', out.height='500px',dpi=500
qqmath(~homeval | cut(lowSES,quantile(lowSES))+cut(rooms,c(3,6,7,9)),data=boston,group=river,pch=19,scales=list(alternating=3))


## @knitr c4lat2,fig.width=7, fig.height=5,out.width='700px', out.height='500px',dpi=500
xyplot(tax~teachratio | cut(rooms,quantile(rooms)),data=boston,group=river,pch=19,scales=list(alternating=3))


## @knitr c4lat3,fig.width=7, fig.height=5,out.width='700px', out.height='500px',dpi=500
xyplot(tax~teachratio | cut(rooms,quantile(rooms)),data=boston,group=river,pch=19,scales=list(alternating=3),jitter.x=T,jitter.y=T,amount=0)


## @knitr c4interp1
summary(lm(Petal.Length~Species,data=iris))$coef


## @knitr c4interp2
summary(lm(Petal.Length~Species+Sepal.Length,data=iris))$coef


## @knitr c4interp3
summary(lm(Petal.Length~Species*Sepal.Length,data=iris))$coef


## @knitr c4lrtest1,message=FALSE
library(lmtest)
mod1=lm(log10(accel)~log10(dist),data=attenu)
lrtest(mod1) # vs. the Null of no regression


## @knitr c4lrtest2,message=FALSE
mod2=lm(log10(accel)~log10(dist)+mag,data=attenu)
lrtest(mod1,mod2) # vs. each other


## @knitr c4lat4
mylat=xyplot(homeval~rooms | factor(river),pch=19,data=boston,scales=list(alternating=3))
dimnames(mylat)


## @knitr c4lat5,fig.width=7, fig.height=4,out.width='700px', out.height='400px',dpi=500
dimnames(mylat)[[1]]=c("Not by River","By Charles River")
print(mylat)


