
## @knitr ,results='asis',echo=FALSE,include=FALSE
require(knitr)
require(lattice)
layout(1)
opts_chunk$set(cache=TRUE,message=FALSE)
suppressPackageStartupMessages(library(googleVis))
par(mar=c(4,4,1,1))
setwd("C:/Users/Rod/SkyDrive/R/201/Week07")
autos=read.csv('autoMPGtrain.csv',as.is=T,header=T)
source('cvEngine.r')
source('cvConstrainedSubsets.r')
autos$gp100m=100/autos$mpg
autos$continent=factor(autos$continent)
autos$fuel = factor(autos$fuel)
autos$engineType = factor(autos$engineType)
#autos$diesel=grepl('diesel',autos$name)


## @knitr c7diag1,message=FALSE
step(lm(gp100m~.^2,data=autos[,-c(1,8,9)]),trace=FALSE,k=log(298))


## @knitr c7diag2,message=FALSE
step(lm(gp100m~.^2,data=
  data.frame(cbind(autos$continent,scale(autos[,-c(1,8,9)])))),trace=FALSE,k=log(298))


## @knitr c7diag3,message=FALSE
cvid=sample(rep(1:5,60),size=298) ## K=5 CV groups
table(cvid)


## @knitr c7diag3.5,message=FALSE
mynames=c(names(autos)[c(2:8,11)],"weight:year")
firstCV=cvConSubsets(autos,"gp100m",cov.list=mynames,cv.group=cvid,forced=c(4,6))


## @knitr c7diag4,fig.width=6, fig.height=6,out.width='600px', out.height='600px',dpi=500
theTerms=attr(terms(as.formula(firstCV$model[1])),'term.labels')
theFit=cvEngine(autos,theTerms,outcome="gp100m",
                cv.group=cvid,rawpreds=TRUE)
plot(theFit~autos$gp100m,pch=19,col=autos$cyl)
abline(-1,1,col=2); abline(1,1,col=2)


## @knitr c7allmods
options(width=120)
head(firstCV[,-(2:3)],10)


## @knitr c7CVSE1
cvse=rep(NA,5)
for (a in unique(cvid)) cvse[a]=rmse(theFit[cvid==a],autos$gp100m[cvid==a])
cvse
predSE=sd(cvse)/5
predSE


## @knitr c7CVSE2
table(firstCV$nVars[firstCV$CV.RMSE<min(firstCV$CV.RMSE)+predSE])
parsi=min(firstCV$nVars[firstCV$CV.RMSE<min(firstCV$CV.RMSE)+predSE])
head(firstCV[firstCV$nVars==parsi,],2)


## @knitr c7glmnet1
library(glmnet)
automat=model.matrix(lm(gp100m~.,data=autos[,-c(1,9)]))[,-1]
lass1=glmnet(x=automat,y=autos$gp100m)
names(lass1)
dim(lass1$beta)


## @knitr c7glmnet1.5
lassVars=function(lassout,tune,minabs=0) lassout$beta[abs(lassout$beta[,tune])>minabs,tune]
lassVars(lass1,5) # 5th-largest lambda penalty (out of 80)
lassVars(lass1,25) # 25th largest


## @knitr c7glmnet2,fig.width=12, fig.height=7,out.width='1200px', out.height='700px',dpi=500

lass1=glmnet(x=scale(automat),y=scale(autos$gp100m))
plot(lass1,label=TRUE,xvar='lambda',lwd=2)


## @knitr c7glmnet3,fig.width=12, fig.height=7,out.width='1200px', out.height='700px',dpi=500
lass1cv=cv.glmnet(x=scale(automat),y=scale(autos$gp100m),foldid=cvid)
plot(lass1cv)


## @knitr c7glmnet4
options(width=120)
table(lass1$lambda==lass1cv$lambda)
bestid=which.min(lass1cv$lambda)
asgoodid=which(lass1cv$lambda==lass1cv$lambda.1se)
c(asgoodid,bestid)
round(lassVars(lass1,asgoodid),3)
round(lassVars(lass1,bestid),3)


## @knitr c7glmnet5,fig.width=7, fig.height=5,out.width='700px', out.height='500px',dpi=500
plot(glmnet(alpha=0,x=scale(automat),y=scale(autos$gp100m)),label=TRUE,xvar='lambda',lwd=2)


## @knitr c7glmnet6,fig.width=7, fig.height=5,out.width='700px', out.height='500px',dpi=500
plot(glmnet(alpha=0.5,x=scale(automat),y=scale(autos$gp100m)),label=TRUE,xvar='lambda',lwd=2)


## @knitr c7grpreg1,message=FALSE
library(splines)
options(width=130)
mod1=lm(gp100m~weight+ns(year,knots=c(73,77,80))+continent+hp+volume+cyl+accel+diesel,data=autos)
automat2=model.matrix(mod1)[,-1]
dim(automat2)
library(grpreg)
lass2=grpreg(X=scale(automat2),y=scale(autos$gp100m),penalty='grLasso',group=c(1,rep(2,4),3,3:8))
names(lass2)


## @knitr c7grpreg2,fig.width=10, fig.height=6,out.width='1000px', out.height='600px',dpi=500
lass2cv=cv.grpreg(X=scale(automat2),y=scale(autos$gp100m),penalty='grLasso',group=c(1,rep(2,4),3,3:8),nfolds=5)
plot(lass2cv)  ### where's the 1-SE line when you need it?...
min(which(lass2cv$cve<lass2cv$cve[lass2cv$min]+lass2cv$cvse[lass2cv$min]))


## @knitr c7grpreg3
names(lass2cv) 
asgood=min(which(lass2cv$cve<lass2cv$cve[lass2cv$min]+lass2cv$cvse[lass2cv$min]))
lassVars(lass2,asgood,minabs=1E-4)


## @knitr c7svd1,fig.width=12, fig.height=5,out.width='1200px', out.height='500px',dpi=500
source('../Code/svdMissing.r')
lanox=read.csv("../Datasets/la11mat33.csv",as.is=T,row.names=1)
ladates=as.Date(rownames(lanox))
plot(range(ladates),c(0.5,2.5),type='n',xlab="Year",ylab="Nox (log10ppb)",main="Nox Trends: 33 Stations in Greater Los Angeles Region")
for (a in 1:33) lines(log10(lanox[,a])~ladates,col=colors()[a])


## @knitr c7svd2,fig.width=12,cache=FALSE, fig.height=6,out.width='1200px', out.height='600px',dpi=500,message=FALSE
source("../Code/svdMissing.r")
lasvd=svdWmissing(log10(lanox))
plot(-lasvd$svd$u[,1]~ladates,pch=19,xlab="Year",ylab="Amplitude",main="LA NOx SVD: First 3 Components")
points(lasvd$svd$u[,2]~ladates,col=2,pch='+'); lines(lasvd$svd$u[,3]~ladates,col=3)


## @knitr c7pca1
library(pls)
autopca=matrix(NA,nrow=298,ncol=9)
for (a in 1:5)  ## looping over CV groups
{
  ### Note the need for a new data frame, and the syntax
  centers=colMeans(automat[cvid!=a,])
  scales=apply(automat[cvid!=a,],2,sd)
  autoin=data.frame(gp100m=autos$gp100m[cvid!=a],X=I(scale(automat[cvid!=a,])))
 
  tmpreg=pcr(gp100m~X,data=autoin,ncomp=9) ## the y part doesn't matter here
  autout=data.frame(X=I(scale(automat[cvid==a,],center=centers,scale=scales)))
  autopca[cvid==a,]=predict(tmpreg,newdata=autout,type='scores')
}    


