
## @knitr ,results='asis',echo=FALSE,include=FALSE
require(knitr)
require(lattice)
layout(1)
opts_chunk$set(cache=TRUE,message=FALSE)
#suppressPackageStartupMessages(library(googleVis))
par(mar=c(4,4,1,1))
source('../Code/enhancedGraphics.r')


## @knitr c8iris1,fig.width=6,cache=FALSE, fig.height=6,out.width='600px', out.height='600px',dpi=500
library(class)
pairsPlus(iris,col=iris$Species)    


## @knitr c8iris2,fig.width=5,cache=FALSE, fig.height=5.5,out.width='500px', out.height='550px',dpi=500
cloud(Petal.Width~Sepal.Length*Sepal.Width,data=iris,pch=19,group=iris$Species,aspect=c(1,1.5),screen=list(x=-80,z=10,y=30),auto.key=T)    


## @knitr c8knn1
testid=c(sample(1:50,size=15),sample(51:100,size=15),sample(101:150,size=15))
iristrain=iris[-testid,]
table(iristrain$Species)
trainclass=matrix(NA,nrow=105,ncol=8)
for (a in seq(1:8)) trainclass[,a]=knn.cv(iristrain[,1:4],iristrain$Species,k=2*a-1)
rbind(seq(1,15,2),apply(trainclass,2,function(x,ref) length(x[x!=ref]),ref=as.numeric(iristrain$Species)))


## @knitr c8knn2
trainclass2=matrix(NA,nrow=105,ncol=8)
for (a in seq(1:8)) trainclass2[,a]=knn.cv(scale(iristrain[,c(1:2,4)]),iristrain$Species,k=2*a-1)
rbind(seq(1,15,2),apply(trainclass2,2,function(x,ref) length(x[x!=ref]),ref=as.numeric(iristrain$Species)))
x

## @knitr c8tree1,fig.width=5,cache=FALSE, fig.height=6,out.width='500px', out.height='600px',dpi=500
library(rpart)
iclass1=rpart(Species~.,data=iristrain)
plot(iclass1,margin=0.25)
text(iclass1,cex=1.5)


## @knitr c8tree2,fig.width=5,cache=FALSE, fig.height=6,out.width='500px', out.height='600px',dpi=500
options(width=60)
iclass2=rpart(Species~.,data=iristrain,control = rpart.control(cp = 0.45))
plot(iclass2,margin=0.25)
text(iclass2,cex=1.5)


## @knitr c8wine1,fig.width=6,cache=TRUE, fig.height=5,out.width='600px', out.height='500px',dpi=500
#wine=read.csv("../Datasets/wineTrain.csv",as.is=T)
setwd("C:/Users/Rod/SkyDrive/R/201/Week08")
wine=read.csv("wineTrain.csv",as.is=T)
dim(wine)
table(wine$quality)
library(rpart)
vinetree1=rpart(quality~.,data=wine,method='class')
plot(vinetree1,margin=.2)
text(vinetree1,cex=1.2)


## @knitr c8wine2,fig.width=11,cache=TRUE, fig.height=6.5,out.width='1100px', out.height='650px',dpi=500
vinetree2=rpart(quality~.,data=wine,method='class',control=list(cp=1e-3))
plot(vinetree2,margin=.05)
text(vinetree2,cex=0.8)


## @knitr c8wine3
table(wine$quality,predict(vinetree1,type='class'))
table(wine$quality,predict(vinetree2,type='class'))


## @knitr c8wine4
wineloss=matrix(0,nrow=7,ncol=7)
wineloss=(row(wineloss)-col(wineloss))^2
wineloss


## @knitr c8wine5
wineStrata=cut(wine$quality,c(2,4:7,9)+0.5)
wineid=rep(NA,length(wineStrata))
for (a in levels(wineStrata)) {
  aid=which(wineStrata==a)
  wineid[aid]=sample(rep(1:5,ceiling(length(aid)/5)),size=length(aid))
}
table(wineid,wine$quality)


## @knitr c8wine6,cache=TRUE
options(width=130)
source("../Code/rpartCV.r")
rpartCV
vinecv1=rpartCV(quality~.,data=wine,cvid=wineid,method='class',cpvec=0.1^seq(1,5,0.5))
vinecv2=rpartCV(quality~.,data=wine,cvid=wineid,method='class',cpvec=0.1^seq(1,5,0.5),parms=list(split='information',loss=wineloss))


## @knitr c8match1
x=1:8
y=sample(1:20,size=8)
y
rbind(x,match(x,y))


## @knitr c8match1.2
x=rep(1,3)
y=c(y,1)
match(x,y)
x=1:8
y=rep(1,3)
match(x,y) 


## @knitr c8match2
options(width=130)
wsy=read.csv('../Datasets/WSnoxScores.csv',as.is=T,row.names=1)
wsx=read.csv('../Datasets/WinSalemGIScovariates.csv',as.is=T)
head(wsy,3)
dim(wsx)
head(wsx[,1:10],3)


## @knitr c8match3
wsxy=cbind(wsx,wsy[match(wsx$native.id,wsy$site),-1])
dim(wsxy)
summary(wsxy$LogAvgNox)


## @knitr c8match4
wsy=wsy[wsy$n>1,]
wsxy=cbind(wsx,wsy[match(wsx$native.id,wsy$site),-1])
summary(wsxy$LogAvgNox)


## @knitr c8merge1
wsy=read.csv('../Datasets/WSnoxScores.csv',as.is=T,row.names=1)
wsxy=merge(wsx,wsy[wsy$n>1,],by.x='native.id',by.y='site')
dim(wsxy)
summary(wsxy$LogAvgNox)


## @knitr c8merge2
wsxy=merge(wsx,wsy[wsy$n>1,],by.x='native.id',by.y='site',all.x=TRUE)
dim(wsxy)
summary(wsxy$LogAvgNox)


## @knitr c8autos,echo=FALSE
autos=read.csv('../Datasets/autoMPGtrain.csv',as.is=T)
autos$gp100m=100/autos$mpg
autos$continent=factor(autos$continent)
autos$diesel=grepl('diesel',autos$name)


## @knitr c8merge3
automatch=merge(autos[autos$cyl==4,-c(9,11)],autos[autos$cyl==6,-c(9,11)],by=c('name','year'))
dim(automatch)


## @knitr c8merge4
options(width=130)
automatch=merge(autos[autos$cyl==4,-c(8,10,11)],autos[autos$cyl==6,-c(8,10,11)],by='name')
automatch


## @knitr c8trick1
grep('mazda',autos$name)
autos$name=gsub('maxda','mazda',autos$name)
grep('mazda',autos$name)


## @knitr c8trick2
autos=read.csv('../Datasets/autoMPGtrain.csv')  # note: no 'as.is=T'
autos$name[grep('maxda',autos$name)]
autos$name[autos$name=='maxda rx3']='mazda rx3'


## @knitr c8stack1
head(PlantGrowth,2)   
table(PlantGrowth$group)
head(unstack(PlantGrowth))


## @knitr c8stack2
dim(ChickWeight)
head(ChickWeight,2)     
head(unstack(ChickWeight,weight~Chick),2)


## @knitr c8stack3
mywide=xtabs(weight~Time+Chick,data=ChickWeight)
dim(mywide)
head(mywide[,1:10])


## @knitr c8stack4
options(width=130)
safeXtab=function(formula,data,type="sum")
{
# We first count how many obs. in each output array cell
# We get this behavior by running the same formula with no y variable!
xvars=all.vars(formula)[-1]  
countform=paste('~',xvars[1])
for (a in 2:length(xvars)) countform=paste(countform,'+',xvars[a])
countarr=xtabs(as.formula(countform),data=data)
mainarr=xtabs(formula,data=data)
mainarr[countarr==0]=NA

if (type=="mean") { mainarr=mainarr/countarr
} else if (max(countarr)>1) cat("Warning! Some values are sums of multiple instances.\n")
return(mainarr)
}  # end function

### ....Now let's do it!!!
mywide=safeXtab(weight~Time+Chick,data=ChickWeight)
head(mywide[,1:10])


## @knitr c8stack5
restacked=as.data.frame.table(mywide,responseName="weight")
dim(restacked)
head(restacked)
restacked=restacked[!is.na(restacked$weight),]
dim(restacked)


