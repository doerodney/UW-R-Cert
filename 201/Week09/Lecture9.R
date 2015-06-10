
## @knitr ,results='asis',echo=FALSE,include=FALSE
require(knitr)
require(lattice)
layout(1)
opts_chunk$set(cache=TRUE,message=FALSE)
options(width=80)
#suppressPackageStartupMessages(library(googleVis))
par(mar=c(4,4,1,1))
setwd("C:/Users/Rod/SkyDrive/R/201/Week09")
source('enhancedGraphics.r')
wine=read.csv("wineTrain.csv",as.is=T)
source("rpartCV.r")
wineStrata=cut(wine$quality,c(2,4:7,9)+0.5)
wineid=rep(NA,length(wineStrata))
for (a in levels(wineStrata)) {
  aid=which(wineStrata==a)
  wineid[aid]=sample(rep(1:5,ceiling(length(aid)/5)),size=length(aid))}
wineloss=matrix(0,nrow=7,ncol=7)
wineloss=(row(wineloss)-col(wineloss))^2


## @knitr c9volcano,fig.height=6,fig.width=8,out.height='600px',out.width='800px',echo=FALSE
image(volcano,col=terrain.colors(20),xaxt='n',yaxt='n',main='Topography of Maunga Whau, Auckland NZ')
arrows(0.7,0.85,0.95,length=0.2,lwd=2)
text(0.65,0.85,"N",srt=-90,vfont=c('script','bold'),cex=3.5)


## @knitr c9forest1,message=FALSE
options(width=130)
hitme=function(x,ref) length(x[x==ref])
library(randomForest)
winecartCV=rpartCV(quality~.,data=wine,cvid=wineid,method='class',cpvec=0.1^seq(2,5,0.5),parms=list(split='information',loss=wineloss))  ### this is the CART CV we ran last time
apply(winecartCV+2,2,hitme,ref=wine$quality) ### Number of hits, by cp parameter
wineforest=randomForest(factor(quality)~.,data=wine,ntree=200)
hitme(wineforest$predicted,wine$quality)


## @knitr c9oob1
summary(wineforest$oob.times/200)


## @knitr c9oob2
summary(apply(wineforest$votes,1,max))


## @knitr c9forest2,message=FALSE
predmat=matrix(NA,nrow=dim(wine)[1],ncol=9)
for (a in 1:9) {
  tmp=randomForest(factor(quality)~.,data=wine,ntree=200,mtry=a+1)
  predmat[,a]=tmp$predicted
}
apply(predmat+2,2,hitme,ref=wine$quality)


## @knitr c9importance,fig.height=5,fig.width=8,out.height='500px',out.width='800px'
varImpPlot(wineforest,pch=19,col=4)


## @knitr c9forest3
pwine=table(wine$quality)/length(wine$quality)
pinf=-pwine*log(pwine)
round(pinf/sum(pinf),3)


## @knitr c9boost1
library(gbm)
boost100=gbm(factor(quality)~.,data=wine,cv.folds=4,bag.fraction=1,verbose=FALSE)


## @knitr c9boost2
boost2000=gbm(factor(quality)~.,cv.folds=4,distribution="multinomial",data=wine,verbose=FALSE,n.trees=2000,bag.fraction=1)
boost8000=gbm(factor(quality)~.,cv.folds=4,distribution="multinomial",data=wine,verbose=FALSE,n.trees=8000,bag.fraction=1)


## @knitr c9boost3
hitme(apply(boost100$fit,1,which.max)+2,wine$quality)
hitme(apply(boost2000$fit,1,which.max)+2,wine$quality)
hitme(apply(boost8000$fit,1,which.max)+2,wine$quality)


## @knitr c9knn1
library(class)
kunscaled=knn.cv(wine[,-12],cl=wine$quality)
hitme(kunscaled,wine$quality)
kscaled=knn.cv(scale(wine[,-12]),cl=wine$quality)
hitme(kscaled,wine$quality)


## @knitr c9annie
options(width=130)
betwith=function(X,y) {
  p=dim(X)[2]
  annie=rep(NA,p); names(annie)=substr(names(X),1,8)
for (a in 1:p) annie[a]=anova(lm(X[,a]~factor(y)))$F[1]
return(annie) }
round(betwith(wine[,-12],wine[,12]),1)


## @knitr c9lowess,fig.height=5,fig.width=7,out.height='500px',out.width='700px'
autos=read.csv("../Datasets/autoMPGtrain.csv",as.is=TRUE)
plot(mpg~weight,data=autos,pch=19,cex=.7)
lines((15:55)*100,predict(loess(mpg~weight,data=autos,span=0.2),data.frame(weight=(15:55)*100)),col=2,lwd=2)


## @knitr c9kknn1,message=FALSE,cache=FALSE
library(kknn)
newine=wine
newine$logsugar=log10(newine$residual.sugar)
newine[,-12]=scale(newine[,-12])
newine=newine[,-4]
k1=train.kknn(factor(quality)~.,data=newine,kernel="rectangular",kmax=7) #Leave-1-out
round(t(k1$MISCLASS),2)


## @knitr c9kknn2
k2=train.kknn(factor(quality)~.,data=newine,kmax=15,kernel=c("rectangular","triangular","biweight","optimal")) 
round(t(k2$MISCLASS[seq(1,15,2),]),3)


## @knitr c9kknn4
k4=train.kknn(factor(quality)~.,data=newine,kmax=15,distance=3,kernel=c("rectangular","triangular","optimal")) 
round(t(k4$MISCLASS[seq(1,15,2),]),3)


## @knitr c9kknn5
k5=train.kknn(quality~.,data=wine,kernel=c("triangular","gaussian"),kmax=15) 
round(t(k5$MEAN.SQU[seq(1,15,2),]),3)


## @knitr c9kknn6,cache=FALSE
k6=train.kknn(factor(quality,ordered=TRUE)~.,data=newine,kmax=22,kernel=c("rectangular","triangular","optimal")) 
round(t(k6$MISCLASS[seq(1,22,3),]),3)


## @knitr c9agg
aggregate(Sepal.Length~Species,data=iris,FUN=mean)
aggregate(.~Species,data=iris,FUN=min)


## @knitr c9apply
apply(ChickWeight[,1:2],2,mean)


## @knitr c9apply2
apply(ChickWeight[,1:2],2,quantile,prob=c(.1,.9))


## @knitr c9lapply
lapply(split(iris$Petal.Length,iris$Species),max)


## @knitr c9sapply
sapply(split(iris$Petal.Length,iris$Species),max)


## @knitr c9tapply
tapply(iris$Petal.Length,iris$Species,max)


## @knitr c9mapply1,fig.width=7, fig.height=4,out.width='700px', out.height='400px',dpi=500
options(width=130)
x=matrix(rnorm(10000),nrow=10); y=matrix(rnorm(10000),nrow=10) 
mypees=mapply(function(z,w) summary(lm(w~z))$coef[2,4],
              split(x,col(x)),split(y,col(y)))
plot(-log10(mypees),pch=19,cex=.3,main="Manhattan: Null Normal Case",xlab="Test Number:")
abline(h=c(-log10(0.05),3),col=2)


