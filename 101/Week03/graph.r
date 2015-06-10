plot(Literacy, GDP, log="y", 
     cex=sqrt(Population/max(Population, na.rm=TRUE))*10, 
     pch=19, col=rgb(0,0,0,.2))

plot(GDP, LifeExpectancy, log="x", 
     cex=sqrt(Population/max(Population, na.rm=TRUE))*10, 
     pch=19, col=rgb(0,0,0,.2))	 
	 
cols <- rainbow(6, alpha=.7)

plot(C$Literacy, C$GDP, log="y", 
     cex=sqrt(C$Population/max(C$Population, na.rm=TRUE))*20, 
     pch=19, col=cols[match(C$Continent, levels(C$Continent))])
legend("topleft", legend=levels(C$Continent), col=cols, pch=19, pt.cex=2)
text(C$Literacy[C$Population > 1000],
     C$Girth[C$Population > 1000],
      C$County[C$Population > 1000])


1 Americas = Yellow (yellow)
2 East Asia and Oceania = coral
3 Europe = Peach  (wheat)
4 North Africa and Southwest Asia = Medium Blue  (dodgerblue)
5 South Asia = Light Blue  (cyan)
6 Sub-Saharan Africa = Blue  (blue)

cols = c("yellow", "coral", "wheat", "dodgerblue", "cyan", "blue")


setwd("C:/R/101/week03")
LE = read.csv("LifeExpect.csv")
attach(LE)

# Simple start 
cols = c("yellow", "coral", "wheat", "dodgerblue", "cyan", "blue")
plot(GDP, LifeExpectancy, log="x", cex=sqrt(Population/max(Population, na.rm=TRUE))*20, pch=19, col=cols[match(Region2, levels(Region2))])
legend("bottomright", legend=levels(Region2), col=cols, pch=19, pt.cex=2)
text(labels = Country[Population > 10^8], x = GDP[Population > 10^8], y = LifeExpectancy[Population > 10^8], font=2)
# Adds labels	  
cols = c("yellow", "coral", "wheat", "dodgerblue", "cyan", "blue")
plot(GDP, LifeExpectancy, log="x", main="Not quite Gapminder World Map 2010",  xlab="MONEY: GDP per person in US dollars (purchasing power adjusted) (log scale)", ylab="HEALTH:  Life expectancy at birth (years)",cex=sqrt(Population/max(Population, na.rm=TRUE))*20, pch=19, col=cols[match(Region2, levels(Region2))])
legend("bottomright", legend=levels(Region2), col=cols, pch=19, pt.cex=2)
text(labels = Country[Population > 10^8], x = GDP[Population > 10^8], y = LifeExpectancy[Population > 10^8], font=2)

# Lost country labels
# Subtracts main label	  
cols = c("yellow", "coral", "wheat", "dodgerblue", "cyan", "blue")
plot(GDP, LifeExpectancy, log="x", xlab="MONEY: GDP per person in US dollars (purchasing power adjusted) (log scale)", ylab="HEALTH:  Life expectancy at birth (years)",cex=sqrt(Population/max(Population, na.rm=TRUE))*20, pch=19, col=cols[match(Region2, levels(Region2))])
legend("bottomright", legend=levels(Region2), col=cols, pch=19, pt.cex=2)
text(labels = Country[Population > 10^8], x = GDP[Population > 10^8], y = LifeExpectancy[Population > 10^8], font=2)

# Lost country labels
# Subtracts main and xlab	  
cols = c("yellow", "coral", "wheat", "dodgerblue", "cyan", "blue")
plot(GDP, LifeExpectancy, log="x", ylab="HEALTH:  Life expectancy at birth (years)",cex=sqrt(Population/max(Population, na.rm=TRUE))*20, pch=19, col=cols[match(Region2, levels(Region2))])
legend("bottomright", legend=levels(Region2), col=cols, pch=19, pt.cex=2)
text(labels = Country[Population > 10^8], x = GDP[Population > 10^8], y = LifeExpectancy[Population > 10^8], font=2)

# Lost country labels
# Subtracts main, xlab, ylab	  
cols = c("yellow", "coral", "wheat", "dodgerblue", "cyan", "blue")
plot(GDP, LifeExpectancy, log="x", ylab="HEALTH:  Life expectancy at birth (years)",cex=sqrt(Population/max(Population, na.rm=TRUE))*20, pch=19, col=cols[match(Region2, levels(Region2))])
legend("bottomright", legend=levels(Region2), col=cols, pch=19, pt.cex=2)
text(labels = Country[Population > 10^8], x = GDP[Population > 10^8], y = LifeExpectancy[Population > 10^8], font=2)

# Try to label all countries
cols = c("yellow", "coral", "wheat", "dodgerblue", "cyan", "blue")
plot(GDP, LifeExpectancy, log="x", ylab="HEALTH:  Life expectancy at birth (years)",cex=sqrt(Population/max(Population, na.rm=TRUE))*20, pch=19, col=cols[match(Region2, levels(Region2))])
legend("bottomright", legend=levels(Region2), col=cols, pch=19, pt.cex=2)
text(labels = Country, x = GDP, y = LifeExpectancy, font=2)
	  
cols = c("yellow", "coral", "wheat", "dodgerblue", "cyan", "blue")
plot(GDP, LifeExpectancy, log="x", main="Not quite Gapminder World Map 2010",  xlab="MONEY: GDP per person in US dollars (purchasing power adjusted) (log scale)", ylab="HEALTH:  Life expectancy at birth (years)", cex=sqrt(Population/max(Population, na.rm=TRUE))*20, pch=19, col=cols[match(Region2, levels(Region2))])
legend("bottomright", legend=levels(Region2), col=cols, pch=19, pt.cex=2)
text(labels = Country[Population > 10^8], x = GDP[Population > 10^8], y = LifeExpectancy[Population > 10^8], font=2)
 
	  

# reorder the data by decreasing population size
C <- C[order(C$Population, decreasing=TRUE),]
plot(C$Literacy, C$GDP, log="y", 
     cex=sqrt(C$Population/max(C$Population, na.rm=TRUE))*20, 
     pch=21,
     col = "grey",
     bg=cols[match(C$Continent, levels(C$Continent))])

legend("topleft", legend=levels(C$Continent), col=cols, pch=19, pt.cex=2)
# add the names of countries that have populations > 100 million
text(labels = C$Country[C$Population > 10^8],
      x = C$Literacy[C$Population > 10^8],
      y = C$GDP[C$Population > 10^8], font=2)

