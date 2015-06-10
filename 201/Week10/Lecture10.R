
## @knitr c10load,results='asis',echo=FALSE,include=FALSE
require(knitr)
require(lattice)
layout(1)
opts_chunk$set(cache=TRUE,message=FALSE)
options(width=80)
#suppressPackageStartupMessages(library(googleVis))
par(mar=c(4,4,1,1))
source('../Code/enhancedGraphics.r')
wine=read.csv("../Datasets/wineTrain.csv",as.is=T)
source("../Code/rpartCV.r")
wineStrata=cut(wine$quality,c(2,4:7,9)+0.5)
wineid=rep(NA,length(wineStrata))
for (a in levels(wineStrata)) {
  aid=which(wineStrata==a)
  wineid[aid]=sample(rep(1:5,ceiling(length(aid)/5)),size=length(aid))}
wineloss=matrix(0,nrow=7,ncol=7)
wineloss=(row(wineloss)-col(wineloss))^2


## @knitr c10hinge,fig.height=5,fig.width=7,out.height='500px',out.width='700px',echo=FALSE,dpi=500
par(mar=c(2,2,4,1))
plot(c(-2:2),c(3,2,1,0,0),xlim=c(-1.4,1.9),yaxt='n',xaxt='n',type='l',col=2,lwd=2,main="Hinge Loss Function",xlab="Distance into Correct Class (arbitrary scale)",ylab="Loss")
abline(v=0,lty=3)
axis(1,at=-1:1)


## @knitr c10svm1,fig.height=5,fig.width=6,out.height='500px',out.width='600px',dpi=500
library(e1071); par(mar=c(2,2,2,1))
plot(svm(Species~., data = iris),iris,Petal.Width~Sepal.Length,slice = list(Sepal.Width=3, Petal.Length=4))


## @knitr c10svm2,fig.height=5,fig.width=6,out.height='500px',out.width='600px',dpi=500
par(mar=c(2,2,2,1))
plot(svm(Species~., data = iris,kernel='polynomial'), iris, Petal.Width ~ Sepal.Length,slice = list(Sepal.Width = 3, Petal.Length = 4))


## @knitr c10svm3,fig.height=5,fig.width=6,out.height='500px',out.width='600px',dpi=500
par(mar=c(2,2,2,1))
plot(svm(Species~., data = iris,kernel='sigmoid'), iris, Petal.Width ~ Sepal.Length,
slice = list(Sepal.Width = 3, Petal.Length = 4))


## @knitr c10svm4,fig.height=5,fig.width=6,out.height='500px',out.width='600px',dpi=500
par(mar=c(2,2,2,1))
plot(svm(Species~., data = iris,kernel='sigmoid',cost=0.1), iris, Petal.Width ~ Sepal.Length,
slice = list(Sepal.Width = 3, Petal.Length = 4))


## @knitr c10tune1,fig.height=6,fig.width=7,out.height='500px',out.width='600px',dpi=500
options(width=70)
tuney=tune(svm,factor(quality)~.,data=wine, ranges = list(gamma = 0.1*2^(-1:2), cost = 2^((-1):1)), tunecontrol = tune.control(sampling ='cross'))
library(latticeExtra)
levelplot(error~log2(gamma)+log2(cost), data=tuney$performance, panel=panel.levelplot.points,cex=8,pch=22, col.regions=rainbow(31,start=2/3), main="Wine CV: SVM Prediction Error Matrix")


## @knitr c10tune2,fig.height=6,fig.width=8,out.height='600px',out.width='800px',dpi=500,cache=TRUE
library(randomForest)
tuney2=tune(randomForest,factor(quality)~.,data=wine,ranges = list(mtry=1:8,nodesize=1:6),ntree=200,tunecontrol = tune.control(sampling ='cross',cross=5))
levelplot(error~mtry+nodesize,data=tuney2$performance,panel=panel.levelplot.points,cex=3,pch=22,col.regions=rainbow(31,start=2/3),main="Wine CV: Random-Forest Prediction Error Matrix")+layer_(panel.2dsmoother(...,col.regions=rainbow(31,start=2/3,alpha=0.7)))


## @knitr c10phone1
options(width=130)
smartrain=read.csv('../Datasets/smarTrain.csv',as.is=TRUE)
dim(smartrain)
table(is.na(smartrain))
names(smartrain)[1:6]
names(smartrain)[558:563]
table(smartrain$Class,smartrain$Subject)


## @knitr c10heat1,fig.height=7,fig.width=6,out.height='700px',out.width='600px',dpi=500
library(RColorBrewer); par(mar=c(2,2,2,0))
heatmap(as.matrix(smartrain[sample(1:7352,size=800),sample(2:562,size=200)]),col=brewer.pal(11,'RdYlGn'),breaks=c(-20,(-4.5:4.5)/4,20),labRow=NA,labCol=NA)


## @knitr c10group,fig.height=5,fig.width=12,out.height='500px',out.width='1200px',dpi=500
boxplot(rowMeans(smartrain[smartrain$Class<4,2:562])~smartrain$Subject[smartrain$Class<4],range=1,col=5,main="All-Variable Averages by Subject (walking classes only)",xlab="Subject ID",ylab="Average Normalized Reading")


## @knitr c10ddply
library(plyr)
smartscale=ddply(smartrain,"Subject",function(x) data.frame(cbind(scale(x[,2:562]),class=x$Class)))


## @knitr c10filter1
source('../Code/filtering.r')
filt0=apply(smartscale[,2:562],2,betwith0,y=smartscale$class)
table(cut(filt0,c(0:4,max(filt0))))


## @knitr c10filter2
options(width=140); source('../Code/filtering.r')
filt11=apply(smartscale[smartscale$class<4,2:562],2,betwith0,y=smartscale$class[smartscale$class<4])
filt12=apply(smartscale[smartscale$class>3,2:562],2,betwith0,y=smartscale$class[smartscale$class>3])
table(cut(filt11,c(0:2,max(filt11))),cut(filt12,c(0:2,max(filt12))))


## @knitr c10heat3,fig.height=7,fig.width=7,out.height='700px',out.width='700px',dpi=500
par(mar=c(2,2,2,0))
heatmap(as.matrix(smartscale[,-1][sample(1:7352,size=1000),filt11>1 | filt12>1]),col=brewer.pal(11,'RdYlGn'),breaks=c(-20,(-4.5:4.5)/4,20),labRow=NA,labCol=NA)


## @knitr c10knnaive
library(class)
testid=sample(1:7352,size=990)
naive=knn(smartscale[-testid,2:562],smartscale[testid,2:562],cl=smartscale$class[-testid])
table(smartscale$class[testid]==naive)


## @knitr c10knngrouped
testid=which(smartscale$Subject<6)
nonaive=knn(smartscale[-testid,2:562],smartscale[testid,2:562],cl=smartscale$class[-testid])
table(smartscale$class[testid]==nonaive)


## @knitr c10knnfilt
filtid=which(filt11>1 | filt12>1)+1
kfilt=knn(smartscale[-testid,filtid],smartscale[testid,filtid],cl=smartscale$class[-testid])
table(smartscale$class[testid]==kfilt)
table(smartscale$class[testid],kfilt)


## @knitr c10nnet1,message=FALSE
library(nnet); winetest=sample(1:2961,size=1000)
net1=nnet(factor(quality)~.,data=wine[-winetest,],decay=0.01,size=20)
pret1=predict(net1,newdata=wine[winetest,],type='class')
table(wine$quality[winetest]==pret1)
table(wine$quality[winetest],pret1)


## @knitr c10nnet2,message=FALSE
scwine=data.frame(cbind(scale(wine[,-12]),quality=wine$quality))
net2=nnet(factor(quality)~.,data=scwine[-winetest,],decay=0.01,size=20)
pret2=predict(net2,newdata=scwine[winetest,],type='class')
table(wine$quality[winetest]==pret2)
table(pret2==pret1)


## @knitr c10tune3,fig.height=5,fig.width=6,out.height='500px',out.width='600px',dpi=500
library(caret)
tuney3=train(factor(quality)~.,data=scwine,method = "nnet",maxNWts=2000,tuneGrid=expand.grid(.size=2^(2:5),.decay=0.1^c(0.5,1:4)),trControl=trainControl(method='cv',number=5))
levelplot((1-Accuracy)~log2(size)+log10(decay),data=tuney3$results,panel=panel.levelplot.points,cex=3,pch=22,col.regions=rainbow(31,start=2/3),main="Wine CV: 1-Layer Neural Net Prediction Error Matrix")+layer_(panel.2dsmoother(...,col.regions=rainbow(31,start=2/3,alpha=0.7)))


## @knitr c10snns1
library(RSNNS); options(width=130)
wine=rbind(wine[-winetest,],wine[winetest,])
winequal=decodeClassLabels(factor(wine$quality))
head(winequal,2)
winetr=normTrainingAndTestSet(splitForTrainingAndTest(wine[,-12],winequal,ratio=1000/2961))
str(winetr)


## @knitr c10snns2
my1st2layer=mlp(winetr$inputsTrain,winetr$targetsTrain,size=c(6,3),learnFuncParams=c(.2,.1))
twolayerpred=predict(my1st2layer,winetr$inputsTest)
table(wine$quality[1962:2961]==2+apply(twolayerpred,1,which.max))
table(wine$quality[1962:2961],2+apply(twolayerpred,1,which.max))


## @knitr c10snns3
smartclass=decodeClassLabels(factor(smartscale$class))
cat(date(),' \n')
my1st3layer=mlp(smartscale[-testid,filtid],smartclass[-testid,],size=c(40,15,6),learnFuncParams=c(.2,.1))
cat(date(),'\n') 
threelayerpred=predict(my1st3layer,smartscale[testid,filtid])
table(smartscale$class[testid]==apply(threelayerpred,1,which.max))
table(smartscale$class[testid],apply(threelayerpred,1,which.max))


## @knitr c8stack5
source('../Code/safeXtab.r')
library(reshape2)
mywide=safeXtab(weight~Time+Chick,data=ChickWeight)
restacked=melt(mywide)
dim(restacked)
head(restacked)
restacked=restacked[!is.na(restacked$value),]
dim(restacked)


