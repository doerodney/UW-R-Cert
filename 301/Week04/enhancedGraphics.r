	
panel.hist <- function(x,right=FALSE,diagCol=5,linefun=mean, ...)
{
    usr <- par("usr"); on.exit(par(usr))
    par(usr = c(usr[1:2], 0, 1.2) )
    h <- hist(x,plot = FALSE)
    breaks <- h$breaks; nB <- length(breaks)
    y <- h$counts; y <- y/max(y)
    rect(breaks[-nB], 0, breaks[-1], y,col=diagCol,   ...)
    abline(v=linefun(x),col=2)
}

panel.dens <- function(x,diagCol=4,linefun=mean,blockCol=0, ...)
{
    usr <- par("usr"); on.exit(par(usr))
    par(usr = c(usr[1:2], 0, 1.2) )
    h <- hist(x,plot = FALSE)
    breaks <- h$breaks; nB <- length(breaks)
    y <- h$counts; y <- 0.9*y/max(y)
    rect(breaks[-nB], 0, breaks[-1], y)

    d <- density(x,na.rm=TRUE)
    lines(d$x,d$y/max(d$y),lwd=2,col=diagCol)
	
    abline(v=linefun(x),col=2)
}

panel.qq <- function(x,right=FALSE,diagCol=4,linefun=mean,...)
{
	usr <- par("usr"); on.exit(par(usr))
	
	qq.value <- qqnorm(x[!is.na(x)], plot=FALSE)
	par(usr = c(min(qq.value$x), max(qq.value$x), min(qq.value$y), max(qq.value$y)) )

	points(qq.value$x, qq.value$y, col=diagCol,cex=0.7,pch=19)
}

panel.cor <- function(x, y, digits=2, prefix="", corcex=0.5,method="pearson", ...)
{
    usr <- par("usr"); on.exit(par(usr))
    par(usr = c(0, 1, 0, 1))
    r <- (cor(x, y,method=method,use="pairwise.complete.obs"))
    txt <- format(c(r, 0.123456789), digits=digits)[1]
    txt <- paste(prefix, txt, sep="")
    if(missing(corcex)) corcex <- 0.8/strwidth(txt)
    text(0.5, 0.5, txt, cex = corcex * sqrt(abs(r))+0.5)
}


panel.scatter <- function(x,y,fitcurve='linear',fitcol=2,crossx=0,crossy=0,...) {

points(x,y,...)

if(fitcurve=='linear')
{
	abline(lm(y~x),col=fitcol)
	
} else if(fitcurve=='crosshairs') {

	abline(h=crossy,col=fitcol)
	abline(v=crossx,col=fitcol)

} else if(fitcurve=='spline') {
	abline(x,smooth.spline(x,y)$y,col=fitcol)
}
}

pairsPlus<-function(x,diag.panel=panel.dens,diagCol=4,pagesize=dim(x)[2]-1,scramble=FALSE,yind=NA,pch=19,cex=0.6,...) 
{
par(ask=FALSE)
nvars=dim(x)[2]
if(is.na(yind)) yind=nvars

### The number of pages; note the '%/%' operator for integer division
npages=1 + (nvars-2) %/% (pagesize)

varind=c((1:nvars)[-yind],yind)
if (scramble) varind=c(sample((1:nvars)[-yind]),yind)  ### To show variables in scrambled order
for (a in 1:npages)
{
	currind=varind[c(((a-1)*pagesize+1):min(a*pagesize,nvars-1),nvars)]
	pairs(x[,currind],diag.panel=diag.panel,upper.panel=panel.cor,lower.panel=panel.scatter,pch=pch,cex=cex,...)
	if (a<npages) par(ask=TRUE)
}
par(ask=FALSE)
}

	