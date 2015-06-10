
## @knitr ,results='asis',echo=FALSE,include=FALSE
require(knitr)
require(lattice)
#opts_chunk$set(cache=TRUE)
#suppressPackageStartupMessages(library(googleVis))
#print(gvisTable(cars, options=list('height'=200)), 'chart')
par(mar=c(4,4,1,1))
#boston=read.csv('../Datasets/boston.csv',as.is=T)


## @knitr c6challenger0
challenger=read.csv('../Datasets/challenger.csv',as.is=TRUE)
chalmod=glm(cbind(Eroded,Intact)~I(tempF-70),data=challenger,family=binomial)
predtemp=c(50,40,31)
predict(chalmod,newdata=data.frame(tempF=predtemp))


## @knitr c6challenger1
predict(chalmod,type='response',newdata=data.frame(tempF=predtemp))


## @knitr c6challenger2
chalpred=predict(chalmod,se.fit=TRUE,newdata=data.frame(tempF=predtemp))
expit=function(x) exp(x)/(1+exp(x))
data.frame(Temp=predtemp,Mean=expit(chalpred$fit),CI95.lower=expit(chalpred$fit-2*chalpred$se.fit),CI95.upper=expit(chalpred$fit+2*chalpred$se.fit))


## @knitr c6chi
round(qchisq(0.95,df=1:5),1)


## @knitr 
autos=read.csv("../Datasets/autoMPGtrain.csv",as.is=T)
autos$gp100m=100/autos$mpg
autos$continent=factor(autos$continent)
autos$diesel=grepl('diesel',autos$name)
# reference 'full models'
fullmod=lm(gp100m~.,data=autos[,-c(1,9)])
fullWinteract=lm(gp100m~.^2,data=autos[,-c(1,9)])
emptymod=lm(gp100m~1,data=autos[,-c(1,9)])

## I won't run this here, but note the syntax
# step(fullmod)  # backward AIC
# step(fullmod,k=log(298))  # backward BIC
# Now forward BIC, allowing interactions:
# step(emptymod,list(upper=fullWinteract),direction='forward',k=log(298)) 


## @knitr c6loadCV
source('../Code/cvEngine.r')
source('../Code/cvConstrainedSubsets.r')
cvid=sample(1:5,size=298,replace=TRUE) ## K=5 CV groups

# Not run here: 
# firstcut=cvConSubsets(autos,"gp100m",cov.list=names(autos)[c(2:8,11)],cv.group=cvid)


## @knitr c6CV2
mynames=c(names(autos)[c(2:8,11)],"weight:year")
# firstcut=cvConSubsets(autos,"gp100m",cov.list=mynames,cv.group=cvid,forced=c(4,6))


## @knitr c6CV3
spnames=c(mynames[-9],'ns(year,df=3)')
# firstcut=cvConSubsets(autos,"gp100m",cov.list=spnames,cv.group=cvid,forced=c(4,6))


## @knitr c6CV4
spnames=c(mynames[-9],'ns(year,df=3)')
# firstcut=cvConSubsets(autos,"gp100m",cov.list=spnames,cv.group=cvid,forced=c(4,6),transfun=function(x) 100/x,transform.list=list(mean=0,sd=1))


## @knitr c6grep
grep('diesel',autos$name)
table(grepl('diesel',autos$name))


## @knitr c6combn
combn(names(autos)[2:8],2)


## @knitr c6combn2
zz=combn(names(autos)[2:8],2)
zz=zz[,apply(zz,2,function(x,b) b%in%x,b='weight')]
zz=zz[,apply(zz,2,function(x,b) b%in%x,b='year')]
zz
dim(zz)


## @knitr c6rle
tosses=sample(c('Heads','Tails'),size=20,replace=TRUE)
tosses
runs=rle(tosses)
runs$values
runs$lengths


