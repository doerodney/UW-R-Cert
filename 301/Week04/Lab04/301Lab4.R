
## @knitr q4load,results='asis',cache=FALSE,echo=FALSE,include=FALSE
require(knitr)
opts_chunk$set(cache=FALSE,message=FALSE,tidy=FALSE,width=132)


## @knitr q4qplot0
library(ggplot2)
qplot(weight~Time,data=ChickWeight)


## @knitr q4qplot1,fig.width=9, fig.height=5,out.width='900px',out.height='500px',dpi=300,tidy=FALSE
qplot(Time,weight,data=ChickWeight)


## @knitr q4qplot2,fig.width=5, fig.height=5,out.width='500px',out.height='500px',dpi=300,tidy=FALSE
qplot(Time,weight,data=ChickWeight,color=Diet)


## @knitr q4qplot3,fig.width=5, fig.height=5,out.width='500px',out.height='500px',dpi=300,tidy=FALSE
qplot(Time,weight,data=ChickWeight,color=Diet,shape=Diet)


## @knitr q4qplot4,fig.width=5, fig.height=5,out.width='500px',out.height='500px',dpi=300,tidy=FALSE
qplot(Time,weight,data=ChickWeight,color=Diet,alpha=I(0.5),size=I(2))


## @knitr q4qplot5,fig.width=5, fig.height=5,out.width='500px',out.height='500px',dpi=300,tidy=FALSE
qplot(Time,weight,data=ChickWeight,color=Diet,alpha=I(0.2),log='y',size=I(4))


## @knitr q4qplot6,fig.width=5, fig.height=5,out.width='500px',out.height='500px',dpi=300,tidy=FALSE
z<-qplot(Time,weight,data=ChickWeight,color=Diet,size=I(4))
z+scale_color_manual(values=c("black","red","blue", "green"))


## @knitr q4qplot9,fig.width=5, fig.height=5,out.width='500px',out.height='500px',dpi=300,tidy=FALSE
qplot(Time,weight,data=ChickWeight,geom=c('point','smooth'))


## @knitr q4qplot10,fig.width=5, fig.height=5,out.width='500px',out.height='500px',dpi=300,tidy=FALSE
z<-qplot(Time,weight,data=ChickWeight,color=Diet,geom=c('point','smooth'))
z+scale_color_manual(values=c("black","red","blue", "green"))


## @knitr q4qplot11,fig.width=10, fig.height=5,out.width='1000px',out.height='500px',dpi=300,tidy=FALSE
qplot(Time,weight,data=ChickWeight,facets=.~Diet,geom=c('point','smooth'))


## @knitr q4quplot1,fig.width=5, fig.height=5,out.width='500px',out.height='500px',dpi=300,tidy=FALSE
qplot(weight,data=ChickWeight,log='x')


## @knitr q4quplot2,fig.width=5, fig.height=5,out.width='500px',out.height='500px',dpi=300,tidy=FALSE
qplot(weight,data=ChickWeight,log='x',geom='density',color=Diet)


## @knitr q4quplot3,fig.width=5, fig.height=5,out.width='500px',out.height='500px',dpi=300,tidy=FALSE
library(lattice)
densityplot(~log(weight),data=ChickWeight,group=Diet)


