
## @knitr c11load,results='asis',cache=FALSE,echo=FALSE,include=FALSE
require(knitr)
require(lattice)
layout(1)
opts_chunk$set(cache=TRUE,message=FALSE)
#suppressPackageStartupMessages(library(googleVis))
source('../Code/enhancedGraphics.r')
wine=read.csv("../Datasets/wineTrain.csv",as.is=T)


## @knitr c11trux1
trux=read.csv('../Datasets/summer_trucks.csv',as.is=TRUE)
head(trux,3)
summary(trux$date)


## @knitr c11trux2
trux$date=as.Date(trux$date)
summary(trux$date)


## @knitr c11trux3
trux=read.csv('../Datasets/summer_trucks.csv',
              colClasses=c('character','Date',rep('numeric',3)))
summary(trux$date)


## @knitr c11usdate
morenox=read.csv('../Datasets/LRnox.csv',as.is=TRUE)
head(morenox,3)
morenox$on_date=as.Date(morenox$on_date,'%m/%d/%Y')
head(morenox,3)
summary(morenox$on_date)


## @knitr c11hclust1,fig.width=12, fig.height=6,out.width='1200px', out.height='600px',dpi=500
par(mar=c(2,5,1,1))
plot(hclust(dist(scale(wine[,-12]))),cex=.7,xlab="",ylab="Dissimilarity",main="") 


## @knitr c11hclust2,fig.width=12, fig.height=6,out.width='1200px', out.height='600px',dpi=500
par(mar=c(2,5,1,1))
wine$logsugar=log10(wine$residual.sugar)
wine$logfree=log10(wine$free.sulfur.dioxide)
winedist=dist(scale(wine[,-c(4,6,12)]))
plot(hclust(winedist),cex=.7,xlab="",ylab="Dissimilarity",main="")
abline(h=11,lwd=2,col=2)


## @knitr c11hclust3,fig.width=12, fig.height=6,out.width='1200px', out.height='600px',dpi=500
par(mar=c(2,5,1,1))
wine$logsugar=log10(wine$residual.sugar)
wine$logfree=log10(wine$free.sulfur.dioxide)
plot(hclust(winedist,method='single'),cex=.7,xlab="",ylab="Dissimilarity",main="") 


## @knitr c11hclust4,fig.width=12, fig.height=6,out.width='1200px', out.height='600px',dpi=500
par(mar=c(2,5,1,1))
wine$logsugar=log10(wine$residual.sugar)
wine$logfree=log10(wine$free.sulfur.dioxide)
plot(hclust(winedist,method='average'),cex=.7,xlab="",ylab="Dissimilarity",main="") 


## @knitr c11hclust5,fig.width=12, fig.height=6,out.width='1200px', out.height='600px',dpi=500
par(mar=c(2,5,1,1))
wine$logsugar=log10(wine$residual.sugar)
wine$logfree=log10(wine$free.sulfur.dioxide)
plot(hclust(winedist,method='median'),cex=.7,xlab="",ylab="Dissimilarity",main="") 


## @knitr c11hclust6,fig.width=12, fig.height=6,out.width='1200px', out.height='600px',dpi=500
par(mar=c(2,5,1,1))
wineRdist=as.dist(1-cor(t(scale(wine[,-c(4,6,12)])))) # note the 't'
plot(hclust(wineRdist),cex=.7,xlab="",ylab="Dissimilarity",main="",sub="") 
abline(h=1,lwd=2,col=2)


## @knitr c11smart0,echo=FALSE
smartrain=read.csv('../Datasets/smarTrain.csv',as.is=TRUE)
library(plyr)
smartscale=ddply(smartrain,"Subject",function(x) data.frame(cbind(scale(x[,2:562]),class=x$Class)))
source("../Code/filtering.r")
filt11=apply(smartscale[smartscale$class<4,2:562],2,betwith0,y=smartscale$class[smartscale$class<4])
filt12=apply(smartscale[smartscale$class>3,2:562],2,betwith0,y=smartscale$class[smartscale$class>3])
smartRdist=as.dist(1-cor(smartscale[,filt11>1 | filt12>1]))
rm(smartrain)


## @knitr c11hclust7,fig.width=12, fig.height=6,out.width='1200px', out.height='600px',dpi=500
plot(hclust(smartRdist),cex=.7,xlab="",ylab="Dissimilarity",main="",sub="") 
abline(h=1,lwd=2,col=2)


## @knitr c11k1,fig.width=12, fig.height=6,out.width='1200px', out.height='600px',dpi=500
kwine=list()
for (a in 2:20) kwine[[a]]=kmeans(scale(wine[,-c(4,6,12)]),a,iter.max=100)
plot(1:20,sapply(kwine,function(x) sqrt(x$tot.withinss/(length(x$cluster)-length(x$size)))),xlab="Number of Clusters",ylab="RMS Within-Cluster Distance")


## @knitr c11mclust1
library(mclust)
mout=Mclust(scale(wine[,-c(4,6,12)]),G=2:12)
c(mout$G,mout$modelName,mout$df) # Properties of "winning" combo!


## @knitr c11mclust2,fig.width=7, fig.height=5,out.width='700px', out.height='500px',dpi=500,tidy=FALSE
plot(2:12,mout$BIC[,"EII"],ylim=range(mout$BIC),type='l',
     ylab="BIC",xlab="Number of Clusters")
lines(2:12,mout$BIC[,'VII'],col=3)
lines(2:12,mout$BIC[,'VVV'],col=5)
lines(2:12,mout$BIC[,'VEV'],col=2,lwd=2)


## @knitr c11sim0,cache=TRUE
library(foreach)
library(randomForest)
system.time(rf0 <- foreach(ntree=rep(500, 4), .combine=combine) %do% randomForest(factor(quality)~.,data=wine,ntree=ntree))


## @knitr c11sim1,cache=FALSE,tidy=FALSE
library(doSNOW); library(randomForest); options(width=80)
cl <- makeCluster(3, type = "SOCK")
registerDoSNOW(cl)
system.time(rf1 <- 
    foreach(ntree=rep(667,3), .combine=combine,.packages='randomForest') 
            %dopar% randomForest(factor(quality)~.,data=wine,ntree=ntree))
stopCluster(cl)
cl <- makeCluster(6, type = "SOCK")
registerDoSNOW(cl)
system.time(rf2 <- 
    foreach(ntree=rep(333,6), .combine=combine,.packages='randomForest') 
            %dopar% randomForest(factor(quality)~.,data=wine,ntree=ntree))
stopCluster(cl)


## @knitr c11sim2,cache=TRUE
options(width=130)
source('../Code/foreachRF.r')
serial=rfTune0(factor(quality)~.,data=wine,mvals=1:6,nodevals=1:5) # %do% with no parallel overhead
cl3=rfTune(factor(quality)~.,data=wine,mvals=1:6,nodevals=1:5,nclust=3)
cl6=rfTune(factor(quality)~.,data=wine,mvals=1:6,nodevals=1:5,nclust=6)
c(serial$times[3],cl3$times[3],cl6$times[3])


## @knitr c11expand
mvals=1:6
nodevals=1:5
tgrid=expand.grid(mtry=mvals,nodesize=nodevals)
dim(tgrid)
head(tgrid)


## @knitr c11phone1
library(data.table)
smartrain=read.csv('../Datasets/smarTrain.csv',as.is=TRUE)
smartrain=data.table(smartrain)


## @knitr c11testrun1
library(plyr)
system.time(smartscale1<-ddply(smartrain,"Subject",function(x) data.frame(cbind(scale(x[,2:562]),class=x$Class))))


## @knitr c11testrun2
smartscale2=copy(smartrain)
scalenames=names(smartscale2)[2:562]
system.time(smartscale2[,eval(scalenames):=as.data.table(scale(.SD)),.SDcols=scalenames,by=Subject])


## @knitr c11compare
table(smartscale1==data.frame(smartscale2))


## @knitr c11nalocf0
missydat=read.csv('../Datasets/naLOCF.csv',as.is=TRUE)
head(missydat,10)


## @knitr c11nalocf1
library(zoo)
missydat$id[missydat$id=='']=NA
missydat$id=na.locf(missydat$id)
head(missydat,10)


## @knitr c11bars0
options(width=130)
error.bar <- function(x, y, upper, lower=upper, length=0.1,...){
    if(length(x) != length(y) | length(y) !=length(lower) | length(lower) !=length(upper))  stop("vectors must be same length")
    arrows(x,y+upper, x, y-lower, angle=90, code=3, length=length, ...)
}


## @knitr c11bars1,fig.width=7, fig.height=5,out.width='700px', out.height='500px',dpi=500
options(width=130)
dummyd=data.frame(method=rep(1:3,3),day=rep(1:3,each=3),means=sqrt(1:3)+rnorm(9),SEs=runif(9,0,0.5))
dummyd$xshift=(dummyd$method-2)/20  # 'jigger' so that bars don't hide each other
plot(means~I(day+xshift),data=dummyd[dummyd$method==1,],type='b',main="Fun with Simple Error Bars!",xlim=c(0.8,3.2),ylim=c(min(dummyd$means-2*dummyd$SEs),max(dummyd$means+2*dummyd$SEs)),pch=19,xlab='Day',xaxt='n')
lines(means~I(day+xshift),data=dummyd[dummyd$method==2,],type='b',col=2,pch=19)
lines(means~I(day+xshift),data=dummyd[dummyd$method==3,],type='b',col=3,pch=19)
axis(1,at=1:3)
error.bar(dummyd$day+dummyd$xshift,dummyd$means,2*dummyd$SEs,col=dummyd$method,length=0.07)


