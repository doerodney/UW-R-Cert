# StatR 101
# Eli Gurarie
# Lab 3

setwd("c:/eli/teaching/StatR101/Week3")


##################################
# Summarizing  quantitative data
##################################

# Load the sealion data

Sealion <- read.csv("./data/PupTaggingData.csv")
Length <- Sealion$Length
Girth <-Sealion$Girth
Weight <-Sealion$Weight
Island <- Sealion$Island
Sex <- Sealion$Sex


# Some of the quantitative summary statistics we learned are:
mean(Length)
var(Length)
sd(Length)

# These are straightforward arithmetic statistics, that we could recreate
# ourselves if we wanted to.  Thus:

Length.mean <- sum(Length)/length(Length)
Length.var <- sum((Length-Length.mean)^2)/(length(Length) - 1)
Length.sd <- sqrt(Length.var)

# Other statistics are extracted from an ordering of the data, like
range(Length)
median(Length)
quantile(Length)

# note that:
min(Length) == sort(Length)[1]
max(Length) == sort(Length)[length(Length)]
range(Length) == quantile(Length, c(0,1))

# but lets make a specialized function that returns all of these statistics.

# Before we start, lets introduce the "list".  A "list" is a type of object
# that collects in it any number of distinct objects.  For example:
MyPet <- list(name = "Bartholemew", 
              species = factor("Guinea Pig", levels=c("Dog", "Cat", "Parakeet", "Guinea Pig")), 
              age=4, 
              whiskers = TRUE, 
              colors = c("Tan", "White", "Black"))

# we access any of these elements with the "$" operator
MyPet$whiskers

# Now, we create a function.  

# every funciton is assigned, like any other object, with a name and some optional 
# arguments
MySummary <- function(X)
{
  X.mean <- sum(X)/length(X)
  X.var <- sum((X-X.mean)^2)/(length(X) - 1)
  X.sd <- sqrt(X.var) 
  
  list(N = length(X), range = range(X), mean = X.mean, 
       median = median(X), quantile = quantile(X))
}
MySummary(Length)
MySummary(Length[Island == "Chirpoev"])




########################################################
#  Summarizing things by hand
########################################################


# Often, we want to summarize these statistics for separate subgroups.  We can do 
# that by hand, like this:

Length.Chirpoev <- mean(Length[Island == "Chirpoev"])
Length.Antsiferov <- mean(Length[Island == "Antsiferov"])
Length.Lovushki <- mean(Length[Island == "Lovushki"])

mean(Length[Island == "Chirpoev"])
mean(Length[Island == "Antsiferov"])
mean(Length[Island == "Lovushki"])
mean(Length[Island == "Lovushki" & Sex == "M"])

# etc ... but that can get quite tedious.  
# A very useful solution is to use the "tapply" function. 
# tapply(Y, X, FUN): 
#    1) Y is the thing you want to summarzie
#    2) X is the factor you want to organize by
#    3) FUN is the function you want to apply

  tapply(Length, Island, mean)
  tapply(Length, paste(Island, Sex), sd)

# Note that you can specify your own function - as long as it is a function of 
# only one variable
  sd.pop <- function(x)
    1/length(x) * sum((x-mean(x))^2)    
  tapply(Length, Island, sd.pop)

# Or define it within the function
  tapply(Length, Island, function(x)   1/length(x) * sum((x-mean(x))^2))

# Combining outputs of tapply is extremely useful for making summary tables
  SummaryTable <- data.frame(
      n = tapply(Length, Island, length),
      mean = tapply(Length, Island, mean),
      sd = tapply(Length, Island, sd))

# What if we were curious about differences between sexes as well?
# Here, we can combine the two factors (Island and Sex) using the very useful: 
# "paste()" function. 

# See:

  gift <- "Partridge in a Pear Tree"
  n <- 1
  paste(n, gift)

  gifts <- c("French Hens", "Turtle Doves", gift)
  ns <- 3:1

  paste(ns, gifts)

  Sex.Island <- factor(paste(Sex, Island))
  
  SummaryTable <- data.frame(
    n = tapply(Length, Sex.Island, length),
    mean = tapply(Length, Sex.Island, mean),
    sd = tapply(Length, Sex.Island, sd))

#########################################################################
# EXERCISE 1: 
# Note that SummaryTable does not have a column for Island and Sex.
# Create a function that obtains the first element of a vector, 
# and use "tapply" to create vector that identify the Sex and Island according 
# according to the subdivisions. 


#  Solutions:

# this doesn't work
  getFirst <- function(x) return(x[1])
  SummaryTableFinal <- data.frame(
      Island =  tapply(Island, Sex.Island, getFirst),
      Sex = tapply(Sex, Sex.Island, getFirst),
      n = tapply(Length, Sex.Island, length),
      mean = tapply(Length, Sex.Island, mean),
      sd = tapply(Length, Sex.Island, sd))

# but this does: 
  getFirst <- function(x) return(as.character(x[1]))
  
SummaryTableFinal <- data.frame(
    Island =  tapply(Island, Sex.Island, getFirst),
    Sex = tapply(Sex, Sex.Island, getFirst),
    n = tapply(Length, Sex.Island, length),
    mean = tapply(Length, Sex.Island, mean),
    sd = tapply(Length, Sex.Island, sd))

# other options, using "substr" (the character substring function)
  levels(Sex.Island)
  row.names(SummaryTable)
  substr(row.names(SummaryTable), 1, 1)
  substr(row.names(SummaryTable), 3, nchar(row.names(SummaryTable)))
# note the very similar substring
  substring(row.names(SummaryTable), 3)
  SummaryTableFinal <- data.frame(Sex = substr(row.names(SummaryTable), 1,1), 
                                  Island = substring(row.names(SummaryTable), 3), 
                                  SummaryTable)

# The "tapply" is part of a family of "apply" functions, all of which can be a bit 
# confusing, but often quite powerful. 

# We will use "tapply" and "apply" to make a summary table that combines both 

  M <- matrix(tapply(Length, Sex.Island, mean), nrow=length(levels(Island)))
  rownames(M) <- levels(Island)
  colnames(M) <- levels(Sex)

# "apply(Y, MAR, FUN)" applies function FUN to variable Y across "margin" 
# (1 = by rows, 2 = by columnd)
  MeansByIsland <- apply(M, 1, mean)
  MeansBySex <- apply(M, 2, mean)

  SummaryTable <- data.frame(M, Total = MeansByIsland)
  SummaryTable <- rbind(SummaryTable, Total = apply(SummaryTable, 2, mean))

# according to this table - the mean of the means is 109.57, whereas: 
    mean(Length)  # gives 109.84. 
# Why the difference?

# Note that if the function returns a vector, the output of tapply becomes a "list"
  tapply(Length, paste(Island,Sex), quantile)

# there is another, related, function called "aggregate" which provides more usable output.
  aggregate(Length, list(Island, Sex), quantile)

############################################
# EXERCISE 2: 
# Write a function that returns a vector with "n", "mean", and "sd", and 
# Use "aggregate" to create the same table as in the last exercise (basically in one line)
############################################

# SOLUTION:
  mySummary <- function(X)
    c(n = length(X), mean = mean(X), sd = sd(X))
  SummaryTable.Final <- aggregate(Length, list(Island, Sex), mySummary)

# note that this data.frame is a bit strange:
  dim(SummaryTable.Final)
  is(SummaryTable.Final[,3])
  data.frame(SummaryTable.Final[,3])
  
###############################
# DEALING WITH NA's
###############################

# NA causes big problems

  C <- read.csv("./data/CountryData.csv")
  mean(C$GDP)
  range(C$GDP)
  tapply(C$GDP, C$Continent, mean)

  # NA's will cause a LOT of misery
  
  # Several options:
  mean(C$GDP[!is.na(C$GDP)])
  mean(na.omit(C$GDP))

  # but
  tapply(na.omit(C$GDP), C$Continent, mean)
  #fails!

  # option:
  tapply(na.omit(C$GDP), C$Continent[!is.na(C$GDP)], mean)

  # OR, many functions have an "na.rm" option:
  mean(C$GDP, na.rm=TRUE)
  
  # it is often robust to slip in your own function:
  tapply(C$GDP, C$Continent, function(x) mean(x, na.rm=TRUE))

  # or, alternatively, you can add further arguments of the function into tapply
  tapply(C$GDP, C$Continent, mean, na.rm=TRUE)


#####################
# BOXPLOTS!
#####################

# Instant gratification
  boxplot(Length ~ Sex)
  boxplot(Length ~ Island, col="grey")

  # Note: the "+" notation
  boxplot(Length ~ Sex * Island)
  # Also: "*" works (we'll learn later why)
  boxplot(Length ~ Sex + Island, col="grey")
  boxplot(Length ~ Sex * Island, col=2:3)
  
  boxplot(Length ~ Sex * Island, col=2:3, xaxt="n")
  axis(1, at=1:5 * 2 - .5, levels(Island), cex.axis=1.25)
  legend("topright", fill=2:3, legend=levels(Sex), cex=1.5)

# Customization!
  boxplot(Length ~ Sex * Island, col=rgb(c(1,0),c(0,1),0,.5), 
          xaxt="n", at=rep(1:5*2, each=2) + c(-.3,.3),
          ylab="Length (cm)", cex.lab=1.5)
  axis(1, at=1:5 * 2, levels(Island), cex.axis=1.25)
  legend("topright", fill=rgb(c(1,0),c(0,1),0,.5), legend=levels(Sex), cex=1.5)

# compare with 
boxplot(Length ~ Island * Sex, col="grey")

# Note, that you do not have have "extracted" the vectors for boxplots to work
  rm(list=ls())  # wipe out all objects in memory
  Sealions <- read.csv("./data/PupTaggingData.csv")
  boxplot(Length ~ Sex * Island, data=Sealions, col="grey")

# In general, it is "safer" to analyze data directly within the data.frame


###########################################################################
# EXERCISE 3: 
# Summarize, with quartiles, the 
# and make boxplots of GDP with respect to continental region
###########################################################################


C <- read.csv("./data/CountryData.csv")
myquantile <- function(x) quantile(x, na.rm=TRUE)
aggregate(C$GDP, list(C$Continent), myquantile)

boxplot(GDP~Continent, data=C)
boxplot(GDP~Continent, data=C, varwidth=TRUE, col="grey")
text(1:6, 80000, paste("n =", tapply(C$GDP, C$Continent, length)), cex=1.5)


################################
# Plotting many dimensions

# the following code incrementally builds a scatter plot with 
# several layers of quantitative and categorical information. 

attach(C)
plot(Literacy, GDP)

plot(Literacy, GDP, log="y")

# make the circle areas proportional to population
# (note the "sqrt")
plot(Literacy, GDP, log="y", 
     cex=sqrt(Population/max(Population, na.rm=TRUE))*10)
# make the point character transparent
plot(Literacy, GDP, log="y", 
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

