panel.hist <- function(x,right=FALSE,diagCol=5,linefun=mean, ...)
{
    usr <- par("usr"); on.exit(par(usr))
    par(usr = c(usr[1:2], 0, 1.5) )
    h <- hist(x,plot = FALSE)
    breaks <- h$breaks; nB <- length(breaks)
    y <- h$counts; y <- y/max(y)
    rect(breaks[-nB], 0, breaks[-1], y,col=diagCol,   ...)
    abline(v=linefun(x),col=2)
}

panel.density <- function(x,right=FALSE,diagCol=5,linefun=mean, ...)
{
    # Get the current value of the par(usr) configuration.
	# This is a vector of the form c(x1, x2, y1, y2) giving the extremes of 
	# the user coordinates of the plotting region. 
	# Upon function exit, restore the value of par to the initial value.
    usr <- par("usr"); on.exit(par(usr))
	
	# Set the value of the usr vector.  
    par(usr = c(usr[1:2], 0, 1.5) )  # I have no idea what the coordinates are.
    
	# Get the density return value.  
	d = density(x)
	y = d$y / max(d$y)
	# Plot the density function x versus y values.
	lines(d$x, y)
	
	# Draw a vertical line at the mean(x).
    abline(v=linefun(x),col=2)
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
	abline(lsfit(x,y),col=fitcol)
	
} else if(fitcurve=='crosshairs') {

	abline(h=crossy,col=fitcol)
	abline(v=crossx,col=fitcol)

} else if(fitcurve=='spline') {
	abline(smooth.spline(x,y),col=fitcol,...)
}
}

pairsPlus<-function(x, diag.panel=panel.hist, diagCol=4, fitcurve='linear',...) 
{
	pairs(x, diag.panel=diag.panel, upper.panel=panel.cor, lower.panel=panel.scatter,...)
}

pairsPlusPlus<-function(x, diag.panel=panel.density, diagCol=4, fitcurve='linear',...) 
{
	pairs(x, diag.panel=diag.panel, upper.panel=panel.cor, lower.panel=panel.scatter,...)
}	

setwd("C:/Users/Rod/SkyDrive/R/Crawley/data")
ozone.pollution = read.table("ozone.data.txt", header=T)
str(ozone.pollution)
pairsPlusPlus(ozone.pollution, panel=panel.smooth)

#--------------------------------------------------------------------
setwd("C:/Users/Rod/SkyDrive/R/Crawley/data")
ozone.pollution = read.table("ozone.data.txt", header=T)
library(lattice)
xyplot(ozone.pollution$ozone ~ ozone.pollution$wind | cut(ozone.pollution$temp, 6),
	panel = function(x, y) 
	{
		panel.grid(h=-1, v=2)
		panel.xyplot(x, y, pch=16)
		panel.loess(x, y, span=1 ) 
	}
  )	

  
  setwd("C:/Users/Rod/SkyDrive/R/201/Week02")
  cig = read.table("Amstat_cigarettes.csv", header=T, as.is=T, row.names=1)
  pairs(cig)
  pairsPlusPlus(cig)

setwd("C:/Users/Rod/SkyDrive/R/201/Week02")  
boston = read.csv("Boston.csv")

cig = read.csv("Amstat_cigarettes.csv")
cig
pairs(cig)
boston = read.csv("Boston.csv")
str(boston)
cor(boston)
cor(boston)
boston
names(boston)
pairs(boston)
attach(boston)
cor(boston)
pairsPlus(boston)
model = lm(homeval ~ crime + biglots + indust + nox + rooms + oldhomes + jobdist + tax + lowSES)
model
#--------------------------
setwd("C:/Users/Rod/SkyDrive/R/Crawley/data")
ozone.pollution = read.table("ozone.data.txt", header=T)

fvif <- function(rsq) {
	result = 1 / (1 - r*r)
	result
}	

vif <- function(dataset) {
	# cor() returns a matrix of r values
	m = cor(dataset)
	
	nRows = length(m[,1])  # length of first column
	nCols = length(m[1,])  # length of first row
	
	# Iterate over the matrix and transform each location.
	# Don't use mapply because of special handling on diagonal values. 
	for (nRow in 1:nRows) {
		for (nCol in 1:nCols) {
			if (nRow == nCol) { m[nRow,nCol] = NA }
			else { m[nRow,nCol] = fvif(m[nRow,nCol]) }
		}	
	}		
	
	# And return it.
	m
}

# Returns the Variance Inflation Factor for each covariate 
# in a linear regression model.
# Values over 5 merit concern.
vif <- function(df) { # df is of type data.frame.
	# Get the count of columns in the data frame.
	covariate = names(df)
	nCols = length(covariate)
	colIndices = 1:nCols
	
	# Results go here.
	vif = numeric(nCols)
	
	for (i in 1:nCols) {
		# The i'th column in the data frame is the outcome.
		outcomeName = covariate[i]
		
		# All other columns are covariates.
		covariateNames = covariate[which(colIndices != i)]
		
		# Construct a string that will be the lm formula.
		formulaText = paste(outcomeName,  " ~ ", paste(covariateNames, collapse="+"))
		
		# Generate the linear model with the formula string.
		# Capture the result.
		smry = summary( lm(as.formula(formulaText), data=df) )
		
		# Capture r-squared from from the model.
		rsq = smry$r.squared
		
		# Calculate and store the variance inflation factor for this outcome.
		vif[i] =  1 / (1 - rsq)
	}	
		
	result = cbind(covariate, vif)	
	
	result	
}	


#------------------------------------------------------------------------------
# Boston steps
vif(boston)
boxplot(boston)
full.model = lm(homeval ~ crime + biglots + indust + river + nox + rooms + old + jobdist + tax + teachratio + lowSES, data=boston)
summary(full.model)
reduced.model = step(full.model, direction="backward")
summary(reduced.model)
hist(boston$tax)
hist(boston)
par(mfcol=c(3,2))
str(boston)
hist(boston$crime))
hist(boston$crime)
hist(boston$biglots)
hist(boston$indust)
hist(boston$river)
hist(boston$nox)
hist(boston$rooms)
par(mfcol=c(3,2))
hist(boston$old)
hist(boston$jobdist)
hist(boston$tax)
hist(boston$teachratio)
hist(boston$lowSES)
hist(boston$homeval)
par(mfcol=c(1,2))
hist(boston$indust)
hist(boston$tax)
summary(full.model)
ls()
summary(reduced.model)

minimize <- function(f, a, b, tol = 0.001)
{
	ratio <- 2 / (sqrt(5) + 1)
	x1 <- b - ratio * (b - a)
	x2 <- b + ratio * (b - a)
	
	f1 <- f(x1)
	f2 <- f(x2)
	
	while( abs(b - a) > tol) {
		if (f2 > f1) { 
			b <- x2
			x2 <- x1
			f2 <- f1
			x1 <- b - ratio * (b - a)
			f1 <- f(x1)
		} 
		else {
			a <- x1
			x1 <- x2
			f1 <- f2
			x2 <- a + ratio * (b - a)
			f2 <- f(x2)
		}
	}
	return( (a + b) / 2)
}	