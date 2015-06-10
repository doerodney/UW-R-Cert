
## @knitr c3load,results='asis',cache=FALSE,echo=FALSE,include=FALSE
require(knitr)
require(lattice)
layout(1)
opts_chunk$set(cache=FALSE,message=FALSE)
#suppressPackageStartupMessages(library(googleVis))
source('../Code/enhancedGraphics.r')
expit<-function(x) exp(x)/(1+exp(x))
logit<-function(x) log(1/(1-x))


## @knitr c3propofol0,fig.width=6, fig.height=6,out.width='600px', out.height='600px',dpi=300,tidy=FALSE
propmix=read.csv('../Datasets/Propofol40.csv',as.is=TRUE)

plot(1:40,propmix$Propofol,pch=ifelse(propmix$Pain==1,19,1),cex=1.5,
     type='b', main="Propofol:Thiopental Study (First 40 Patients)",
     xlab="Patient",ylab="Percent Propofol")
legend('topleft',legend=c("Pain","No Pain"),pch=c(19,1),cex=1.5)


## @knitr c3propofol1
table(propmix$Propofol,propmix$Pain)


## @knitr c3propofol2
1-pgeom(3,0.7)
1-pgeom(3,0.6)


## @knitr c3propofol3
propmodel=glm(Pain~I(Propofol-100),data=propmix,family=binomial)
summary(propmodel)


## @knitr c3pack0
library(MCMCpack)
?MCMClogit


## @knitr c3pack1
flatmodel<-MCMClogit(Pain~I(Propofol-100),data=propmix,burnin=1)
summary(flatmodel)


## @knitr c3pack2,fig.width=10, fig.height=5,out.width='1000px', out.height='500px',dpi=200,tidy=FALSE
rejectionRate(flatmodel)
traceplot(flatmodel)


## @knitr c3pack3,fig.width=6, fig.height=5,out.width='600px', out.height='500px',dpi=200,tidy=FALSE
effectiveSize(flatmodel)
acfplot(flatmodel,ylim=c(0,1),layout=c(1,2))


## @knitr c3pack4,fig.width=6, fig.height=5,out.width='600px', out.height='500px',dpi=200,tidy=FALSE,message=FALSE
acfplot(flatmodel,thin=10,main="Thinned by 10x",ylim=c(0,1),layout=c(1,2))


## @knitr c3pack5
flatmodel2<-MCMClogit(Pain~I(Propofol-100),data=propmix,burnin=1000,thin=20,mcmc=1000*20)
rejectionRate(flatmodel2)


## @knitr c3pack6
flatmodel3<-MCMClogit(Pain~I(Propofol-100),data=propmix,burnin=1000,thin=20,mcmc=1000*20,tune=5)
rejectionRate(flatmodel3)


## @knitr c3pack7
summary(flatmodel3)
table(expit(flatmodel3[,1])>0.7)
table(expit(flatmodel3[,1])>0.6)


## @knitr c3pack8
priormodel1<-MCMClogit(Pain~I(Propofol-100),data=propmix,burnin=1000,thin=20,mcmc=1000*20,tune=5,b0=c(logit(0.7),0.02),B0=0.01)
summary(priormodel1)
table(expit(priormodel1[,1])>0.7)
table(expit(priormodel1[,1])>0.6)


## @knitr c3bma0,cache=FALSE
library(BMA)
autos=read.csv('../Datasets/autoMPGtrain.csv',as.is=TRUE)
autos$gp100m=100/autos$mpg
autos$continent=factor(autos$continent)
autos$name=tolower(autos$name)
autos$diesel=grepl('diesel',autos$name)
autos$diesel[autos$name=="mercedes-benz 240d"]=TRUE
autos$wagon=grepl('[(]sw[)]',autos$name)
autos$cylgroup=cut(autos$cyl,c(2,5.5,6.5,9))


## @knitr c3bma2,cache=FALSE
options(width=132)
bma1=bicreg(autos[,c(3:8,11:13)],autos$gp100m)
round(bma1$postprob,2)
bma1$which


## @knitr c3bma3,cache=FALSE
options(width=132)
bma1$postmean
round(bma1$probne0,3)


## @knitr c3bmatest0,cache=FALSE
options(width=132)
autest=read.csv("../Datasets/autoMPGtest.csv",as.is=TRUE)
autest$gp100m=100/autest$mpg
autest$continent=factor(autest$continent)
autest$name=tolower(autest$name)
autest$diesel=grepl('diesel',autest$name)
autest$diesel[autest$name=="mercedes benz 300d"]=TRUE
autest$wagon=grepl('[(]sw[)]',autest$name)
autest$cylgroup=cut(autest$cyl,c(2,5.5,6.5,9))
testmod=model.matrix(lm(gp100m~.,data=autest[,c(3:8,10:13)]))
names(bma1$postmean)  ### A sanity check to see that the columns match
colnames(testmod)  ### They do, although the names are slightly different


## @knitr c3bmatest2,fig.width=6, fig.height=6,out.width='600px', out.height='600px',dpi=200,tidy=FALSE,cache=FALSE
options(width=132)
autpred=testmod %*% bma1$postmean
sqrt(mean((autpred-autest$gp100m)^2))
cor(autpred,autest$gp100m)[1,1]^2
plot(autest$gp100m,autpred,xlab="Gallons per 100 Miles",
     ylab="BMA Predictions",pch=19,col=autest$cylgroup); abline(0,1,col=4)


