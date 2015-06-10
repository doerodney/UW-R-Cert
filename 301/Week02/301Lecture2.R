
## @knitr c2load,results='asis',cache=FALSE,echo=FALSE,include=FALSE
require(knitr)
require(lattice)
layout(1)
opts_chunk$set(cache=TRUE,message=FALSE)
#suppressPackageStartupMessages(library(googleVis))
source('../Code/enhancedGraphics.r')


## @knitr c2integrate,fig.width=5, fig.height=5,out.width='500px', out.height='500px',dpi=500,tidy=FALSE
pvec=seq(1/1001,1000/1001,1/1001) ### equally-spaced theta vector
priorvec=dbeta(pvec,3,3)  ### prior density
posteriorvec=priorvec*pvec^4  ### posterior ~ prior*likelihood
posteriorvec=1000*posteriorvec/sum(posteriorvec) # Normalizing 
plot(pvec,posteriorvec,main="4 Coin Posterior, Numerically",
     xlab='p',ylab='Posterior Density')
lines(pvec,dbeta(pvec,7,3),col=2)
weighted.mean(pvec,w=posteriorvec)  ### Posterior mean


