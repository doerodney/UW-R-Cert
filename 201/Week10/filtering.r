betwith0=function(x,y) {
means=tapply(x,y,mean)
between=var(means)
within=sum(tapply(x,y,var)*tapply(x,y,length))/length(x)
between/within 
}