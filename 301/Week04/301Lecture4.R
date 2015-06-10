
## @knitr c4load,results='asis',cache=FALSE,echo=FALSE,include=FALSE
require(knitr)
require(lattice)
require(data.table)
layout(1)
opts_chunk$set(cache=FALSE,message=FALSE)
#suppressPackageStartupMessages(library(googleVis))
source('../Code/enhancedGraphics.r')
expit<-function(x) exp(x)/(1+exp(x))
logit<-function(x) log(x/(1-x))


## @knitr c4chick0,tidy=FALSE
chick=ChickWeight; dim(chick) 
table(chick$Time,chick$Diet) 



## @knitr c4chick02,fig.width=6, fig.height=6,out.width='600px',out.height='600px',dpi=300,tidy=FALSE
xyplot(weight~Time | Diet,data=chick,group=Chick,type='l',
       scales=list(alternating=3),main="Chick Growth by Diet Type",xlab="Age (Days)")


## @knitr c4chickmod0
chickmod0=lm(weight~Time*Diet,data=chick)
summary(chickmod0)


## @knitr c4chickmod1,fig.width=3, fig.height=3,out.width='300px', out.height='300px',dpi=300,tidy=FALSE,cache=FALSE
plot(chickmod0,pch=19,cex=.5)


## @knitr c4chickmod2,fig.width=10, fig.height=6,out.width='1000px', out.height='600px',dpi=300,tidy=FALSE
options(width=132); layout(1); chick$resid=chickmod0$resid
boxplot(resid~Chick, data=chick,xaxt='n',ylab="Naive Model Residual",col=5);abline(h=0)


## @knitr c4chickmod3,fig.width=10, fig.height=6,out.width='1000px', out.height='600px',dpi=300,tidy=FALSE
options(width=132) 
xyplot(resid~Time | Diet, data=chick,xaxt='n',ylab="Naive Model Residual",group=Chick,pch=19,scales=list(alternating=3))


## @knitr c4chickmod4
summary(lm(weight~Diet*Time+factor(Chick),data=chick))


## @knitr c4cor0,echo=FALSE
source('../Code/safeXtab.r')
source('../Code/enhancedGraphics.r')
chickwide1=safeXtab(resid~Chick+Time,data=chick)


## @knitr c4chickcor1,fig.width=9, fig.height=8,out.width='900px', out.height='800px',dpi=300,tidy=FALSE,echo=FALSE,message=FALSE
pairsPlus(chickwide1)


## @knitr c4gee1
library(gee)
chickgee0=gee(weight~Diet*Time,id=Chick,data=chick,corstr="independence")
chickgee1=gee(weight~Diet*Time,id=Chick,data=chick,corstr='AR-M')


## @knitr c4gee2
round(summary(chickgee0)$coef,2)
round(summary(chickgee1)$coef,2)


## @knitr c4gee3,fig.width=10, fig.height=6,out.width='1000px', out.height='600px',dpi=300,tidy=FALSE
options(width=132) ;  chick$resid2=chickgee1$resid; 
xyplot(resid2~resid | Diet, data=chick,xaxt='n',ylab="GEE vs. Naive Residuals",group=Chick,pch=19,scales=list(alternating=3))


## @knitr c4mixed1
library(lme4)
chickmix0=lmer(weight~Diet*Time+(1|Chick),data=chick)
summary(chickmix0)


## @knitr c4mixed2,fig.width=6, fig.height=6,out.width='600px', out.height='600px',dpi=300,tidy=FALSE
plot(chick$Time,residuals(chickmix0))


## @knitr c4mixed3
chickmix1=lmer(weight~Diet*Time+(Time|Chick),data=chick)
summary(chickmix1)


## @knitr c4mixed4,fig.width=6, fig.height=6,out.width='600px', out.height='600px',dpi=300,tidy=FALSE,cache=FALSE
plot(chick$Time,residuals(chickmix1))


## @knitr c4mixed5
chickmix0L=lmer(weight~Diet+Time+(1|Chick),data=chick,REML=FALSE)
chickmix1L=lmer(weight~Diet*Time+(Time|Chick),data=chick,REML=FALSE)
anova(chickmix0L,chickmix1L)


