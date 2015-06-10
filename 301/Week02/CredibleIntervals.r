# Generic minimal-width interval for Beta posterior, using optim

minOptim<-optim(par=0.025,fn=function(p,a,b) qbeta(p+0.95,a,b)-qbeta(p,a,b),
	a=7,b=3,lower=0,upper=0.05,method="L-BFGS-B")

# Note that we are calculating the interval in terms of p rather than of the x value
# Also, we did *NOT* use the 'flatness' property

# Now, finding the same via 2 calls to 'uniroot', using the flatness property

# First, define a utility finding a percentile's equal-density counterpart
flatBeta=function(x,a,b) {

h=dbeta(x,a,b)
x2=uniroot(f=function(y,a,b,ref) dbeta(y,a,b)-ref,a=a,b=b,ref=h,interval=c(qbeta(0.9,7,3),1))$root
return(pbeta(x2,a,b)-pbeta(x,a,b))
}

# Now calling 'uniroot' again to find the point at which this 'flat-top' interval hits the desired
# Credibility value

minUniroot<-uniroot(f=function(x,a,b,cred=0.95) flatBeta(x,a,b)-cred,a=7,b=3,interval=c(0,qbeta(0.05,7,3)))

