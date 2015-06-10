# StatR 101
# Eli Gurarie


######################################################
# 
# Lab 2: SUMMARY STATISITCS AND VISUALIZATIONS
# 
######################################################

######################
# CATEGORICAL DATA


# A first step to any good R session is to set your working directory. 
# This is the directory you will be loading your data from and potentially 
# saving your output (figures and summary tables) into.

setwd("c:/eli/teaching/StatR101/Week2/data")

# (NOTE: this can be done using point and click windows in Rstudio)

# Copy the data files from Week 2 into whatever folder you've set as your
# working directory.  

# We will start by loading the student survey data

Students <- read.csv("StudentSurvey.csv")

# look at some properties of this data file.

dim(Students)
names(Students)
head(Students)
str(Students)

# Extract the Country column
Country <- Students$Country

# make a summary table
table(Country)

# draw a barplot
barplot(table(Country))

# draw a sorted barplot
barplot(sort(table(Country)))

# draw a sorted barplot
barplot(sort(table(Country)))

# Note that we cannot really read the x-axis because the country names are so long
# We need to tweak this plot in a couple of ways: (1) make the country names vertical
# and (2) make the lower margins larger.
#
# The motherlode of all plot tweaks is in the "par()" function, which sets all graphical
# parameters.  These settings remain until they are changed or until the graphics device 
# is "renewed".  You will spend much time poking around in the help file of par()!
#
# "las" sets the orinetation of labels, "mar" sets the margin sizes.

par(las = 2, mar=c(7,5,2,2))
barplot(sort(table(Country)))

# you can label the y-axis
barplot(sort(table(Country)), ylab="Number of students")
# or add colors
barplot(sort(table(Country)), ylab="Number of students", col=rainbow(15))

# There are several good ways to export graphics, like:
# "pdf()" or "jpeg()" or "png()" or "tiff()" or "bmp()". Each of these functions 
# has its own ways to set the size, resolution, etc.

# I personally like making ".pdf"'s - because they are vector graphics
# and therefore the resolution is effectively infinite.

# the initial command opens a new graphics device (with the specified name)
pdf("StudentBarplot.pdf")
  # you have to redefine your graphical parameter for this new "device"
  par(las = 2, mar=c(7,5,2,2))
  barplot(sort(table(Country)), ylab="Number of students", col=rainbow(15))
dev.off()
# this last command closes the graphics device.


# save the summary table as a data frame
  Country.df <- data.frame(table(Country))

# We can save this useful summary table to the computer as follows:
  write.csv(Country.df, file="CountrySummaryTable.csv")

# We can analyze these data by sex as well.
# We subset to country data into two data frames: males and females

  Students.M <- Students[Students$Sex == "Male",]
  Students.F <- Students[Students$Sex == "Female",]
  Country.M <- Students.M$Country
  Country.F <- Students.F$Country

  Country.df <- data.frame(table(Country.M), table(Country.F), table(Country))

# this is a slightly awkward looking table. 

  Country.df <- data.frame(table(Country),
                Female = as.vector(table(Country.F)), 
                Male = as.vector(table(Country.M)))
# rename the Totals column

  names(Country.df)[2] <- "Total"
  write.csv(Country.df, file="CountrySummaryTable2.csv")


# Lets say we want to make a good visual comparison of the proportions by country
# of males and females.

# First, break the graphics device into two windows

  par(mfrow = c(1,2))
  barplot(table(Country.F))  
  barplot(table(Country.M))
  # that isn't so helpful for comparison

  # here's a version with horizontal bars
  barplot(table(Country.F), horiz=TRUE, main="Females")  
  barplot(table(Country.M), horiz=TRUE, main="Males")

  # here's a version with horizontal bars, where we tricked the barplots
  par(mfrow = c(1,1), mar=c(5,7,2,2))
  barplot(-table(Country.F), horiz=TRUE, yaxt="n", xlim=c(-20,20), col="red")  
  barplot(table(Country.M), horiz=TRUE, add=TRUE, col="blue")
  
  # the plot can keep being improved in countless ways, but you get the idea.
  


  # MORE ON FACTORS. 
  # Note that "Country" is a factor
  is(Country)
  levels(Country)
  
  # Note that the "levels" of Country are alphabetical
  # We can reorder the levels to reflect the frequencies.
  
  levels.ordered <- names(sort(table(Country)))
  
  # this is a character vector of the ordered levels, which we use to "recreate" Country
  
  Country <- factor(Country, levels=levels.ordered)
  levels(Country)
  
  # Now, if we recreate our vectors, the figure from above will be comparable
  Country.M <- Country[Students$Sex == "Male"]
  Country.F <- Country[Students$Sex == "Female"]
  
  par(mfrow = c(1,1), mar=c(5,7,2,2))
  barplot(-table(Country.F), horiz=TRUE, yaxt="n", xlim=c(-20,20), col="red")  
  barplot(table(Country.M), horiz=TRUE, add=TRUE, col="blue")


###############################################
# Part 2: Quantitative Data I

  
  # load the sea lion pup data set
    Pups <- read.csv("PupTaggingData.csv")
    dim(Pups)
    head(Pups)

  # use the table function to make a quick table of number of pups by Island and Sex
    table(Pups$Island, Pups$Sex)

  # Extract the weight, girth, length, sex, and island vectors
    Length <- Pups$Length
    Weight <- Pups$Weight
    Girth <- Pups$Girth
    Sex <- Pups$Sex
    Island <- Pups$Island    

  # Note that this is tedious.  There are two shortcuts we discussed in class to doing this.
  # One is the handy, easy, but not-particularly-recommended "attach()" function.  So:
  
    rm(list=ls())   # removes all objects in memory
    Pups <- read.csv("PupTaggingData.csv")
    attach(Pups)
    plot(Length, Weight)

  # The other is my preferred "unstripping spaghetti" loop:
    n <- names(Pups)
    for(i in 1:length(n))
      assign(n[i], Pups[,i])
  # you do not need to understand this fully yet, but we discussed it in class at length.


  # On to histograms: 
    hist(Length)

  # Note, the coarse binning.  We can increase the number of bins. 
    hist(Length, breaks=20)

  # or, with more control, strictly set the number of bins
    hist(Length, breaks=seq(90,130,2.5), col="grey")

  # or, with more  generality:
    mybreaks <- seq(min(Length),max(Length) + 2, 2)
    hist(Length, breaks=mybreaks, col="grey")

  # Lets compare males and females
    hist(Length[Sex=="M"], breaks=mybreaks, col="grey")
    hist(Length[Sex=="F"], breaks=mybreaks, col="grey", add=TRUE)
  # Note the very important "add = TRUE" parameter, which does not generate a new histogram 
  # every time.

  # It is hard to see because of the overlap!  We use transparent colors
  # with "rgb()"
    hist(Length[Sex=="M"], breaks=mybreaks, col=rgb(1,0,0,.2), main="Histogram of lengths")
    hist(Length[Sex=="F"], breaks=mybreaks, col=rgb(0,0,1,.2), add=TRUE)

  # and many additional tweaks are possible

  # We can add density curve to a histogram as well
    Length.density <- density(Length)
  # this is a density plot 
    plot(Length.density)
  # ... note that "plot" draws specific type of objects in very specific ways.

  # How does the density object work?  
    str(density)

  # You can extract the "x" and "y" coordinates, and add them to a histogram
    hist(Length, breaks = 20, freq=FALSE, col="grey")
    lines(Length.density$x, Length.density$y, lwd=3)

  # In class, we created a customized function for generating a histrogram 

    MyHist <- function(X, xlab, binwidth)
    {
      hist(X, 
           breaks = 
             seq(min(floor(X)), max(ceiling(X)), binwidth), 
           col=rgb(.5,0,1,.5), xlab = xlab)
    }

######################
# In-Class EXERCISE

# 3. Produce a plot with three windows (using "par(mfrow=c(1,3))") which draws 
#    overlapping histograms of pup weight, length and girth for males and females.
#    Add density lines. 


  # As part of hte solution to the above, we created a function that would plot
  # overlapping transparent histograms for males and females respectively.
  # here is a version of this function

    MyDoubleHist <- function(X, xlab, main = "", binwidth = 1)
    {
      hist(X[Sex=="F"], 
           breaks = seq(min(X), max(X) + binwidth, binwidth), 
           col=rgb(1,0,0,.5), xlab = xlab, main=main)
      lines(density(X[Sex=="F"]), col="darkred")
      hist(X[Sex=="M"], 
           breaks = seq(min(X), max(X) + binwidth, binwidth), 
           col=rgb(0,0,1,.5), add=TRUE)
      lines(density(X[Sex=="M"]), col="darkblue")
    }

# this works:
    MyDoubleHist(Weight, xlab="weight (kg)")
    MyDoubleHist(Length, xlab="length (cm)")
# but this doesn't work!
    MyDoubleHist(Girth, xlab="girth (cm)")
# This is our first encounter with the dreaded NA!
# Note that when we try to calculate the max and min of Girth we get "NA":
    max(Girth); min(Girth)
# This is gumming up out generation of the bins. 
# To fix this, we need to add "na.rm = TRUE" to those calculations.  Note also that
# in this version we present density histograms and add density lines. 

  MyDoubleHist2 <- function(X, xlab="", main = "", binwidth = 1)
  {
    X.F <- X[Sex=="F"]
    X.M <- X[Sex=="M"]
    
    hist(X.F, freq=FALSE,
         breaks = seq(min(X, na.rm=TRUE), max(X, na.rm=TRUE) + binwidth, binwidth), 
         col=rgb(1,0,0,.3), xlab = xlab, main=main)
    hist(X.M, freq=FALSE,
         breaks = seq(min(X, na.rm=TRUE), max(X, na.rm=TRUE) + binwidth, binwidth), 
         col=rgb(0,0,1,.3), add=TRUE)
    lines(density(X.F, na.rm=TRUE), col="darkred", lwd=2)
    lines(density(X.M, na.rm=TRUE), col="darkblue", lwd=2)
  }

  par(mfrow=c(1,3))
  MyDoubleHist2(Length, "Length (cm)")
  MyDoubleHist2(Girth, "Girth (cm)")
  MyDoubleHist2(Weight, "Weight (kg)")

# I think this looks pretty darned good.


