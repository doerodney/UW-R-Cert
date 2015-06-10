setwd("D:/R/101/Week03")
xe = c(NA,10,NA,20,NA,30,NA,40)

Median <- function(x)
{
   result = NA
   # Clean the source vector of NA values.
   xc <- sort(x[which(!is.na(x))])
   # If any clean data remain, continue to analyze.
   if (length(xc) > 0)
   {
		# Need this point in either even or odd data count.
		# This selects 3 in either (1,2,3,4,5) or (1,2,3,4).
		# In (1,2,3,4), this select
		m1 = xc[(length(xc) %/% 2) + 1]
		result = m1 # Assume length is odd.
		# Is length even?
		if ((length(xc) %% 2) == 0)
		{
		# This selects 2 in (1,2,3,4)
		m2 = xc[(length(xc) %/% 2)]
		result = mean(c(m1, m2))
		}
	}
	return(result)
}
xed = c(NA, 10, NA, 20, NA, 30, NA, 40)
Median(xed)
xod = c(xed, 50)
Median(xod)
xna = c(NA,NA,NA,NA)
Median(xna)
dfCountry = read.csv("Country.csv")
str(dfCountry)
names(dfCountry)
Median(dfCountry$Birthrate)
median(dfCountry$Birthrate)
Median(dfCountry$Birthrate[dfCountry$Birthrate[!is.na(dfCountry$Birthrate)]]
)
median(dfCountry$Birthrate[dfCountry$Birthrate[!is.na(dfCountry$Birthrate)]]
)
xd = dfCountry$Birthrate
xd
Median(xd)
median(xd)
median(xd[which(!is.na(xd))])
dfCountry = read.csv("Country.csv")
names(dfCountry)
xd = dfCountry$Birthrate
median(xd)
median(xd[which(!is.na(xd))])
Median(xd[which(!is.na(xd))])
Median(xd)
xd
ls()
xec
sum(xec)
xod
xoc
xoc = xod[which(!is.na(xod))]
xoc
sum(xoc)
xecc = xec ^ 3
xecc
Skew <- function(x)
{
   result = NA
   
   # Clean the source vector of NA values.
   xc <- x[which(!is.na(x))]
   
   # If any clean data remain, continue to analyze.
   if (length(xc) > 0)
   {
		xbar = mean(xc)
		numerator = (sum((xc - xbar)^3)) / length(xc)
		denominator = sqrt(var(xc))^3
		
		result = numerator / denominator
   }
   return(result)
}

xd
Skew(xd)
skew(xd)
Skew(dfCountry$GDP)
Skew(dfCountry$GDP)
Skew(dfCountry$Water)
return(result)
load(psych)
xna
Skew(xna)
Skew(dfCountry$GDP)
Skew(dfCountry$Birthrate)
Skew(dfCountry$Water)
Skew(dfCountry$Birthrate)
Skew(dfCountry$Literacy)
br = dfCountry$Birthrate
br
brc = be[which(!is.na(br))]
brc = br[which(!is.na(br))]
hist(brc)
lines(density(brc), col="darkred", lwd=2)
dev.off()
hist(brc)
 par(mfrow=c(1,3))
hist(dfCountry$GDP, na.rm=TRUE, xlab="GDP")
 par(mfrow=c(1,3))
hist(dfCountry$GDP, xlab="GDP")
 par(mfrow=c(1,3))
hist(dfCountry$GDP, main="", xlab="GDP")
hist(dfCountry$Literacy, main="", xlab="GDP")
hist(dfCountry$Birthrate, main="", xlab="GDP")
 par(mfrow=c(1,3))
hist(dfCountry$GDP, main="", xlab="GDP")
hist(dfCountry$Literacy, main="", xlab="Literacy")
hist(dfCountry$Birthrate, main="", xlab="Birthrate")
boxplot(dfCountry$Literacy, main="", xlab="GDP")
boxplot(dfCountry$Literacy, main="", xlab="Literacy")
par(mfrow=c(1,3))
boxplot(dfCountry$GDP, main="", xlab="GDP")
boxplot(dfCountry$Literacy, main="", xlab="Literacy")
boxplot(dfCountry$Birthrate, main="", xlab="Birthrate")
skew
skew <- function(x)
{
m3 <- sum((x-mean(x)))^3
m3 <- sqrt(var(x))^3
skew <- function(x) {
xc = xd[which(!is.na(x))]
skew <- function(x) {
xc = x[which(!is.na(x))]
m3 <- sum((x-mean(x))^3)/length(x)
s3 <- sqrt(var(x))^3
m3/s3
}
skew <- function(x) {
xc = x[which(!is.na(x))]
m3 <- sum((xc-mean(xc))^3)/length(xc)
s3 <- sqrt(var(xc))^3
m3/s3
}
Skew(dfCountry$GDP)
skew(dfCountry$GDP)
Skew(dfCountry$Literacy)
skew(dfCountry$Literacy)
skew(dfCountry$Birthrate)
Skew(dfCountry$Birthrate)
history(200)

"Africa"        "Asia"          "Europe"        "North America"
[5] "South America"       "South America"
Africa = c(Skew(dfCountry$GDP[dfCountry$Continent == 'Africa']), Skew(dfCountry$Literacy[dfCountry$Continent == 'Africa']), Skew(dfCountry$Birthrate[dfCountry$Continent == 'Africa']) )

Asia = c(Skew(dfCountry$GDP[dfCountry$Continent == 'Asia']), Skew(dfCountry$Literacy[dfCountry$Continent == 'Asia']), Skew(dfCountry$Birthrate[dfCountry$Continent == 'Asia']) )

Europe = c(Skew(dfCountry$GDP[dfCountry$Continent == 'Europe']), Skew(dfCountry$Literacy[dfCountry$Continent == 'Europe']), Skew(dfCountry$Birthrate[dfCountry$Continent == 'Europe']) )

NorthAmerica = c(Skew(dfCountry$GDP[dfCountry$Continent == 'North America']), Skew(dfCountry$Literacy[dfCountry$Continent == 'North America']), Skew(dfCountry$Birthrate[dfCountry$Continent == 'North America']) )

South America = c(Skew(dfCountry$GDP[dfCountry$Continent == 'South America']), Skew(dfCountry$Literacy[dfCountry$Continent == 'South America']), Skew(dfCountry$Birthrate[dfCountry$Continent == 'South America']) )

SouthAmerica = c(Skew(dfCountry$GDP[dfCountry$Continent == 'South America']), Skew(dfCountry$Literacy[dfCountry$Continent == 'South America']), Skew(dfCountry$Birthrate[dfCountry$Continent == 'South America']) )


setwd("D:/R/101/Week03")
dfCountry = read.csv("Country.csv")
names(dfCountry)
Skew(dfCountry$GDP)
Skew <- function(x)
{
   result = NA
   # Clean the source vector of NA values.
   xc <- x[which(!is.na(x))]
   # If any clean data remain, continue to analyze.
   if (length(xc) > 0)
   {
xbar = mean(xc)
numerator = (sum((xc - xbar)^3)) / length(xc)
denominator = sqrt(var(xc))^3
result = numerator / denominator
   }
   return(result)
}
Skew(dfCountry$GDP)
table(dfCountry)
ls()
names(dfCountry)
str(dfCountry)
levels(dfCountry$Continent)
help(tapply)
Skew(dfCountry$GDP[dfCountry$Continent == 'Africa')
Skew(dfCountry$GDP[dfCountry$Continent == 'Africa']
)
Skew(dfCountry$GDP[dfCountry$Continent == 'Africa'])
Africa = c(Skew(dfCountry$GDP[dfCountry$Continent == 'Africa']), Skew(dfCountry$Literacy[dfCountry$Continent == 'Africa']), Skew(dfCountry$Birthrate[dfCountry$Continent == 'Africa']) )
Africa
names(Africa) = c('GDP', 'Literacy', 'Birthrate')
Africa
Asia = c(Skew(dfCountry$GDP[dfCountry$Continent == 'Asia']), Skew(dfCountry$Literacy[dfCountry$Continent == 'Asia']), Skew(dfCountry$Birthrate[dfCountry$Continent == 'Asia']) )
Asia
Asia = c(Skew(dfCountry$GDP[dfCountry$Continent == 'Asia']), Skew(dfCountry$Literacy[dfCountry$Continent == 'Asia']), Skew(dfCountry$Birthrate[dfCountry$Continent == 'Asia']) )
Europe = c(Skew(dfCountry$GDP[dfCountry$Continent == 'Europe']), Skew(dfCountry$Literacy[dfCountry$Continent == 'Europe']), Skew(dfCountry$Birthrate[dfCountry$Continent == 'Europe']) )
Europe
NorthAmerica = c(Skew(dfCountry$GDP[dfCountry$Continent == 'North America']), Skew(dfCountry$Literacy[dfCountry$Continent == 'North America']), Skew(dfCountry$Birthrate[dfCountry$Continent == 'North America']) )
Oceania = c(Skew(dfCountry$GDP[dfCountry$Continent == 'Oceania']), Skew(dfCountry$Literacy[dfCountry$Continent == 'Oceania']), Skew(dfCountry$Birthrate[dfCountry$Continent == 'Oceania']) )
Oceania
SouthAmerica = c(Skew(dfCountry$GDP[dfCountry$Continent == 'South America']), Skew(dfCountry$Literacy[dfCountry$Continent == 'South America']), Skew(dfCountry$Birthrate[dfCountry$Continent == 'South America']) )
SouthAmerica
dfByContinent = rbind(Africa, Asia, Europe, NorthAmerica, Oceania, SouthAmerica)
dfByContinent
dfByContinent = rbind(Africa, Asia, Europe, NorthAmerica, Oceania, SouthAmerica)
World = c(Skew(dfCountry$GDP), Skew(dfCountry$Literacy), Skew(dfCountry$Birthrate) )
World
dfByContinent = rbind(Africa, Asia, Europe, NorthAmerica, Oceania, SouthAmerica, World)
dfByContinent
World = c(Skew(dfCountry$GDP), Skew(dfCountry$Literacy), Skew(dfCountry$Birthrate) )
boxplot(dfCountry$GDP[dfCountry$Continent == 'Africa')
boxplot(dfCountry$GDP[dfCountry$Continent == 'Africa'])
par(mfrow = c(3,1)
)
boxplot($dfCountry$GDP[dfCountry$Continent == 'Africa], main="Africa", xlab="GDP")
boxplot(dfCountry$GDP[dfCountry$Continent == 'Africa], main="Africa", xlab="GDP")
boxplot(dfCountry$GDP[dfCountry$Continent == "Africa"], main="Africa", xlab="GDP")
par(mfrow = c(1,3))
boxplot(dfCountry$GDP[dfCountry$Continent == "Africa"], main="Africa", xlab="GDP")
boxplot(dfCountry$Literacy[dfCountry$Continent == "Africa"], main="Africa", xlab="Literacy")
boxplot(dfCountry$Birthrate[dfCountry$Continent == "Africa"], main="Africa", xlab="Birth Rate")
par(mfrow = c(2,3))
boxplot(dfCountry$GDP[dfCountry$Continent == "Africa"], main="Africa", xlab="GDP")
boxplot(dfCountry$Literacy[dfCountry$Continent == "Africa"], main="Africa", xlab="Literacy")
boxplot(dfCountry$Birthrate[dfCountry$Continent == "Africa"], main="Africa", xlab="Birth Rate")
boxplot(dfCountry$GDP[dfCountry$Continent == "Asia"], main="Asia", xlab="GDP")
boxplot(dfCountry$Literacy[dfCountry$Continent == "Asia"], main="Asia", xlab="Literacy")
boxplot(dfCountry$Birthrate[dfCountry$Continent == "Asia"], main="Asia", xlab="Birth Rate")
par(mfrow = c(7,3))
boxplot(dfCountry$GDP[dfCountry$Continent == "Africa"], main="Africa", xlab="GDP")
par(mfrow = c(7,3))
aggregate(dfCountry$GDP, list(dfCountry$Continent), Skew)
par(mfrow = c(6,3))
boxplot(dfCountry$GDP[dfCountry$Continent == "Africa"], main="Africa", xlab="GDP")
par(mfrow = c(1,6))
boxplot(dfCountry$GDP[dfCountry$Continent == "Africa"], main="Africa", xlab="GDP")
boxplot(dfCountry$GDP[dfCountry$Continent == "Asia"], main="Asia", xlab="GDP")
boxplot(dfCountry$GDP[dfCountry$Continent == "Europe"], main="Europe", xlab="GDP")
boxplot(dfCountry$GDP[dfCountry$Continent == "North America"], main="N America", xlab="GDP")
boxplot(dfCountry$GDP[dfCountry$Continent == "Oceania"], main="Oceania", xlab="GDP")
boxplot(dfCountry$GDP[dfCountry$Continent == "South America"], main="S America", xlab="GDP")
help(boxplot)
par(mfrow = c(1,6))
boxplot(dfCountry$GDP[dfCountry$Continent == "Africa"], main="GDP", xlab="GDP")
par(mfrow = c(1,6))
boxplot(dfCountry$GDP[dfCountry$Continent == "Africa"], main="GDP", xlab="Africa")
boxplot(dfCountry$GDP[dfCountry$Continent == "Asia"], xlab="Asia", add=TRUE)
C <- read.csv("CountryData.csv")
aggregate(C$GDP, list(C$Continent), Skew)
boxplot(GDP~Continent, data=C)
boxplot(GDP~Continent, data=C, varwidth=TRUE, col="grey")
text(1:6, 80000, paste("n =", tapply(C$GDP, C$Continent, length)), cex=1.5)
shell("dir")
C <- read.csv("Country.csv")
aggregate(C$GDP, list(C$Continent), Skew)
boxplot(GDP~Continent, data=C)
boxplot(GDP~Continent, data=C, varwidth=TRUE, col="grey")
text(1:6, 80000, paste("n =", tapply(C$GDP, C$Continent, length)), cex=1.5)
C <- read.csv("CountryData.csv")
aggregate(C$GDP, list(C$Continent), Skew)
boxplot(GDP~Continent, data=C)
boxplot(GDP~Continent, data=C, varwidth=TRUE, col="grey")
C <- read.csv("CountryData.csv")
aggregate(C$GDP, list(C$Continent), Skew)
boxplot(GDP~Continent, data=C)
boxplot(GDP~Continent, data=C, varwidth=TRUE, col="grey")
C <- read.csv("Country.csv")
aggregate(C$GDP, list(C$Continent), Skew)
boxplot(GDP~Continent, data=C)
boxplot(GDP~Continent, data=C, varwidth=TRUE, col="grey")
C <- read.csv("Country.csv")
aggregate(C$GDP, list(C$Continent), Skew)
boxplot(GDP~Continent, data=C)
boxplot(GDP~Continent, data=C, varwidth=TRUE, col="grey")
C <- read.csv("Country.csv")
aggregate(C$GDP, list(C$Continent), Skew)
boxplot(GDP~Continent, data=C, main="GDP")
boxplot(GDP~Continent, data=C, varwidth=TRUE, main="GDP", col="grey")
C <- read.csv("Country.csv")
aggregate(C$Literacy, list(C$Continent), Skew)
boxplot(Literacy~Continent, data=C, main="Literacy")
boxplot(Literacy~Continent, data=C, varwidth=TRUE, col="grey")
C <- read.csv("Country.csv")
aggregate(C$Birthrate, list(C$Continent), Skew)
boxplot(Birthrate~Continent, data=C, main="Birthrate")
boxplot(Birthrate~Continent, data=C, varwidth=TRUE, col="grey")
text(1:6, 80000, paste("n =", tapply(C$Birthrate, C$Continent, length)), cex=1.5)
history(200)


cols <- rainbow(6, alpha=.7)
plot(GDP, LifeExpectancy, log="x", cex=sqrt(Population/max(Population, na.rm=TRUE))*20, pch=19, col=cols[match(Region2, levels(Region2))])
legend("bottomright", legend=levels(Region2), col=cols, pch=19, pt.cex=2)
text(labels = Country[Population > 10^8], x = GDP[Population > 10^8], y = LifeExpectancy[Population > 10^8], font=2)


