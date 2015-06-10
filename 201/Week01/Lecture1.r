
## @knitr ,results='asis',echo=FALSE,include=FALSE
require(knitr)
opts_chunk$set(cache=TRUE)
#suppressPackageStartupMessages(library(googleVis))
#print(gvisTable(cars, options=list('height'=200)), 'chart')


## @knitr attenu
dim(attenu)
head(attenu) # For help, let's do ?attenu


## @knitr f0, fig.width=8, fig.height=8,out.width='500px', out.height='500px',dpi=300
table(is.na(attenu))
# Apparently there's missing data.... but where?
apply(attenu,2,function(x) table(is.na(x)))
### Ok... only station ID is missing for some data; but we ignore that anyway. 


## @knitr f00, fig.width=8, fig.height=8,out.width='500px', out.height='500px',dpi=500

pairs(attenu[c(2,4,5)],pch=19,col=4)


## @knitr f01,  fig.width=8, fig.height=8,out.width='500px', out.height='500px',dpi=500

source('../Code/enhancedGraphics.r')
pairsPlus(attenu[c(2,4,5)],pch=19,col=4)


## @knitr f1, fig.width=8, fig.height=8,out.width='500px', out.height='500px',dpi=300
pairsPlus(cbind(attenu$mag,log10(attenu[c(4,5)])),pch=19,col=4)


## @knitr q
# Do you know what this does?

# x[x$somevar==someval,]

# x[-c(3,5),c("var1","var2")]

# The difference between these two?

#x[1:3,1:3] vs. x[cbind(1:3,1:3)]

# Which of the *apply commands have you used?

# Plots: do you know/remember how to

# - add a legend? add an arbitrary text? +special symbols?

# - modify plot margins and other attributes?

# use mfrow() vs. layout() ?

# Have you ever used lattice?


## @knitr reg1

summary(lm(log10(accel)~log10(dist),data=attenu))


## @knitr reg2

summary(lm(log10(accel)~mag,data=attenu))$coef


## @knitr reg3
mod2=lm(log10(accel)~log10(dist)+mag,data=attenu)
summary(mod2)


## @knitr diagn,  echo=FALSE,fig.width=8, fig.height=8,out.width='600px', out.height='600px',dpi=500
source('../Code/enhancedGraphics.r')
pairsPlus(cbind(attenu$mag,log10(attenu$dist),mod2$fitted,mod2$resid),
                pch=19,col=4,labels=c('Magnitude','Log Distance',
                            "Fitted Values",'Residuals'))


## @knitr surface,fig.width=8, fig.height=8,out.width='600px', out.height='600px',dpi=400
library(scatterplot3d)
zz<-scatterplot3d(log10(attenu$dist),attenu$mag,log10(attenu$accel),type='p',cex.sym=1.5,pch=20,highlight.3d=TRUE,angle=30,scale.y=.5)
zz$plane3d(mod2$coef,lty='solid',col=4)


## @knitr annoy
attenu[attenu$station==1008,]  
### WTH ?!?!?!



## @knitr workaround1
attenu[attenu$station==1008 & !is.na(attenu$station),]


## @knitr workaround2
attenu[attenu$station %in% 1008 ,]


## @knitr lattice1,  fig.width=9, fig.height=4,out.width='900px', out.height='400px',dpi=500
library(lattice)
xyplot(log10(accel)~mag | cut(dist,c(0,10^(1:3))),data=attenu,layout=c(3,1),pch=19,col=4)
# Note the use of 'cut' to cut up a continuous variable into a factor. 

#And of course, the use of '|' as the convention for conditioning. Some modeling functions use it similarly, but it doesn't work for that in 'lm'.


## @knitr lattice2,  fig.width=9, fig.height=4,out.width='900px', out.height='400px',dpi=500
library(lattice)
xyplot(log10(accel)~mag | cut(dist,c(0,10^(1:3))),data=attenu,
       main="Felt Acceleration vs. Magnitude, Broken Down by Distance Ranges",layout=c(3,1),pch=19,col=4,xlab="Magnitude (Richter scale)",ylab="Log Acceleration",
panel=function(x,y,...) {panel.xyplot(x,y,...); panel.abline(lm(y~x),col=2)})
# 'panel' is the function at the heart of lattice; it controls what's seen in the - well, panels. If you want the "usual" stuff to still appear, you must include a call to the default function (in this case: panel.xyplot) inside your re-definition of 'panel'. Then you can add whatever you want. 

