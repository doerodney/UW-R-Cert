##load data
data(mesa.model)
##and results of estimation
data(est.mesa.model)

##strating point
x <- coef(est.mesa.model)
##Hessian, for use as proposal matrix
H <- est.mesa.model$res.best$hessian.all
\dontrun{
  ##run MCMC
  MCMC.mesa.model <- MCMC(mesa.model, x$par, N = 5000, Hessian.prop = H)
}
##lets load precomputed results instead
data(MCMC.mesa.model)

####TODO: NEEDS S3-update
##Examine the results
print(MCMC.mesa.model)

##and contens of result vector
names(MCMC.mesa.model)
 
##Summary
summary(MCMC.mesa.model)

##MCMC tracks for four of the parameters
par(mfrow=c(5,1),mar=c(2,2,2.5,.5))
plot(MCMC.mesa.model$l, ylab="", xlab="", type="l",
     main="log-likelihood")
for(i in c(4,9,13,15)){
  plot(MCMC.mesa.model$par[,i], ylab="", xlab="", type="l",
       main=colnames(MCMC.mesa.model$par)[i])
}

##And estimated densities for the log-covariance parameters.
##The red line is the approximate normal distribution given by
##the maximum-likelihood estimates, e.g. ML-estimate and standard 
##deviation from the observed information matrix.
par(mfrow=c(3,3),mar=c(4,4,2.5,.5))
for(i in 9:17){
  xd <- sort(unique(MCMC.mesa.model$par[,i]))
  yd <- dnorm(xd, mean=x$par[i],sd=x$sd[i])
  dens <- density(MCMC.mesa.model$par[,i])
  plot(dens, ylim=c(0,max(c(dens$y,yd))), main =
       colnames(MCMC.mesa.model$par)[i])
  lines(xd,yd,col=2)
}
