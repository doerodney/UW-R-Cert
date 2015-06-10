setwd("C:/Users/Rod/SkyDrive/R/101/Project")
mls<-read.csv(file="MLSWinDrawLose2012.csv")
# Q: Home field advantage - is it significant in MSL soccer?
# H0:  There was no such thing as home field advantage in the 2012 MLS soccer season.
# Expressed mathematically:
# Count of home wins = count of draws = count of home losses.
# H1:  It was advantageous to play on the home field in the 2012 MLS soccer season.
# Expressed mathematically:
# Count of home wins > count of draws and count of home wins > count of home losses.
# Chi-squared test of counts of home wins, home draws, and home losses.
# Nuances:  Exclude results from LA Galaxy versus Chivas USA, since they both play in the same stadium.

# Summarize home team advantage in wins.
data.frame(sum(mls$HomeWin), sum(mls$Draw), sum(mls$HomeLoss))

# But wait, it's even worse.  Summarize home points.
data.frame(sum(mls$HomePoints), sum(mls$VisitorPoints))

# Get win-draw-loss sums into a matrix, then perform chisq-test.
wldCount <- matrix(c(sum(mls$HomeWin), sum(mls$Draw), sum(mls$HomeLoss)), nrow=1)
wldCount
     [,1] [,2] [,3]
[1,]  174   82   85
chisq.test(wldCount)

        Chi-squared test for given probabilities

data:  wldCount 
X-squared = 48.0762, df = 2, p-value = 3.634e-11

# Function used to plot chisq density with df=2.
dwdl <- function(x) {dchisq(x, df=2)}  #dwdl is chisq distribution of win-lose-draw

# Home team summary results
aggregate(x = cbind(HomeTeamScore, VisitorScore), list(HomeTeam), FUN=sum)


# boxplot of home goal differential by team.
homeGoalDiff = mls$HomeGoalDiff
homeTeam = factor(mls$HomeAbbr)
lmfit = (homeGoalDiff ~ homeTeam)
boxplot(lmfit, main="Home team goal differential", xlab="Team", ylab="Home team score - visitor team score")


# boxplot of home goal differential as a function of home time zone - visitor time zone.
lmfit = (mls$HomeGoalDiff ~ mls$VisitorTimeZoneDiff)
boxplot(lmfit, xlab="Home time zone - Visitor time zone", ylab="Home team goal differential", main="Effect of time zone difference on home team goal differential")

# boxplot of home point differential as a function of home time zone - visitor time zone.
lmfit = (mls$HomePoints ~ mls$VisitorTimeZoneDiff)
boxplot(lmfit)

lmfit = (mls$HomePoints ~ mls$VisitorTimeZoneDiff)
boxplot(lmfit)

# Get the home goal differential and visitor time zone differntial by home team.
goalDiffByTimeZoneDiff = cbind(mls$HomeTeam, mls$HomeGoalDiff, mls$VisitorTimeZoneDiff)
names(goalDiffByTimeZoneDiff) = c("HomeTeam", "HomeTeamGoalDifferential", "VisitorTimeZoneDiff")

# Get the home goal differential and visitor time zone differential by home team.
homeTeam = mls$HomeTeam
homeTeam = levels(mls$HomeTeam)
homeGoalDiff = mls$HomeGoalDiff
visitorTimeZoneDiff = mls$VisitorTimeZoneDiff
goalDiffByTimeZoneDiff = cbind(homeTeam, homeGoalDiff, visitorTimeZoneDiff)

# Home goal differential as a function of visitor time zone difference.
homeTeam = levels(mls$HomeTeam)
homeGoalDiff = mls$HomeGoalDiff
visitorTimeZoneDiff = mls$VisitorTimeZoneDiff
lmfit = lm(homeGoalDiff ~ visitorTimeZoneDiff)
plot(visitorTimeZoneDiff, jitter(homeGoalDiff), xlab="Home team time zone - Visitor team time zone", ylab="Home team goal differential", main="Home team goal differential versus visitor team time zone difference")
abline(lmfit)

goalDiffByTimeZoneDiff = cbind(levels(mls$HomeTeam), mls$HomeGoalDiff, mls$VisitorTimeZoneDiff)
names(goalDiffByTimeZoneDiff) = c("HomeTeam", "HomeTeamGoalDifferential", "VisitorTimeZoneDiff")

# Scatter plot of home goal differential as a function of visitor time zone difference.
homeTeam = levels(mls$HomeTeam)
homeGoalDiff = mls$HomeGoalDiff
visitorTimeZoneDiff = mls$VisitorTimeZoneDiff
lmfit = lm(homeGoalDiff ~ visitorTimeZoneDiff)
plot(visitorTimeZoneDiff, jitter(homeGoalDiff), xlab="Home team time zone - Visitor team time zone", ylab="Home team goal differential", main="Home team goal differential versus visitor team time zone difference")
cols = c("red", "orange", "yellow", "green", "cyan", "blue", "violet")
abline(h=mean(mls$HomeGoalDiff[which(mls$VisitorTimeZoneDiff == -3)]), col=cols[1])
abline(h=mean(mls$HomeGoalDiff[which(mls$VisitorTimeZoneDiff == -2)]), col=cols[2)
abline(h=mean(mls$HomeGoalDiff[which(mls$VisitorTimeZoneDiff == -1)]), col=cols[3)
abline(h=mean(mls$HomeGoalDiff[which(mls$VisitorTimeZoneDiff == 0)]), col=cols[4])
abline(h=mean(mls$HomeGoalDiff[which(mls$VisitorTimeZoneDiff == 1)]), col=cols[5])
abline(h=mean(mls$HomeGoalDiff[which(mls$VisitorTimeZoneDiff == 2)]), col=cols[6])
abline(h=mean(mls$HomeGoalDiff[which(mls$VisitorTimeZoneDiff == 3)]), col=cols[7])
legend("topleft", legend=c(-3:3), col=cols, pch=19, pt.cex=2, horiz=TRUE)

# Time zone difference effects sizes
summary.lm(aov(mls$HomeGoalDiff ~ mls$VisitorTimeZoneDiff))

# Effect of visitor distance travelled upon home goal differential
plot(mls$NauticalMiles, mls$HomeGoalDiff, main="Home team goal differential versus visitor travel distance", 
xlab="Nautical miles traveled by visitor", ylab="Home goal differential")
abline(lm(mls$HomeGoalDiff ~ mls$NauticalMiles))

# Travel distance effects sizes
summary.lm(aov(mls$HomeGoalDiff ~ mls$NauticalMiles))

# Effect of upon average home stadium attendance upon home goal differential
plot(mls$HomeTeamAttendance, mls$HomeGoalDiff, main="Home team goal differential versus home team attendance", 
xlab="Average home team attendance", ylab="Home goal differential")
abline(lm(mls$HomeGoalDiff ~ mls$HomeTeamAttendance))

# Average attendance effect size
summary.lm(aov(mls$HomeGoalDiff ~ mls$HomeTeamAttendance))

# Plot the almost significant attendance 
dfx = function(x) {df(x, 1, 339)}
curve(dfx, from=0, to=5)
abline(v=3.346)

# Effect of upon average home stadium attendance upon home goal differential
plot(mls$HomeTeamCapacity, mls$HomeGoalDiff, main="Home team goal differential versus home team stadium capacity", 
xlab="Average home team stadium capacity", ylab="Home goal differential")
abline(lm(mls$HomeGoalDiff ~ mls$HomeTeamCapacity))

# Average attendance effect size
summary.lm(aov(mls$HomeGoalDiff ~ mls$HomeTeamCapacity))
==============================================

# Get the average goal differential as a function of time zone difference.
goalDiffByTimeZoneDiff = aggregate(x=mls$HomeGoalDiff[which(mls$NauticalMiles > 0)], by=list(mls$VisitorTimeZoneDiff[which(mls$NauticalMiles > 0)]), FUN=mean)
names(goalDiffByTimeZoneDiff) = c("VisitorTimeZoneDifferential", "AverageHomeTeamGoalDifferential") 

# Get the average goal differential as a function of time zone difference.
goalDiffByTimeZoneDiff = aggregate(x=mls$HomeGoalDiff[which(mls$NauticalMiles > 0)], by=list(mls$VisitorTimeZoneDiff[which(mls$NauticalMiles > 0)]), FUN=mean)
names(goalDiffByTimeZoneDiff) = c("VisitorTimeZoneDifferential", "AverageHomeTeamGoalDifferential") 
plot(mls$NauticalMiles[mls$NauticalMiles > 0], jitter(mls$HomeGoalDiff[mls$NauticalMiles > 0]))
# Get the average home goal differential as a function of the stadium utilization.
goalDiffByUtiliztion = aggregate(x=mls$HomeGoalDiff[which(mls$NauticalMiles > 0)], by=list(mls$HomeTeam[which(mls$NauticalMiles > 0)]), FUN=mean)
names(goalDiffByUtiliztion) = c("HomeTeam", "AvgHomeGoalDiff")

homeGoalDiffByTeam = aggregate(x=mls$HomeGoalDiff[which(mls$NauticalMiles > 0)], by=list(mls$HomeTeam[which(mls$NauticalMiles > 0)]), FUN=mean)
names(homeGoalDiffByTeam) = c("VisitorTimeZoneDifferential", "AverageHomeTeamGoalDifferential") 

setwd("C:/Users/Rod/SkyDrive/R/101/Project")
mls<-read.csv(file="MLSWinDrawLose2012.csv")
str(mls)
attach(mls)
sum(HomeWin)
HomeWin
setwd("C:/Users/Rod/SkyDrive/R/101/Project")
mls<-read.csv(file="MLSWinDrawLose2012.csv")
attach(mls)
sum(HomeWin)
sum(HomeDraw)
sum(Draw)
sum(HomeLoss)
HomeWin[NauticalMiles > 0]
sum(HomeWin[NauticalMiles > 0])
sum(Draw[NauticalMiles > 0])
sum(HomeLoss[NauticalMiles > 0])
mlsHomeWinLoseDraw = cbind(sum(HomeWin[NauticalMiles > 0]), sum(Draw[NauticalMiles > 0]), sum(HomeLoss[NauticalMiles > 0]))
names(mlsHomeWinLoseDraw) = c("HomeWins", "Draws", "HomeLosses")
mlsHomeWinLoseDraw
chisq.test(c(sum(HomeWin[NauticalMiles > 0]), sum(Draw[NauticalMiles > 0]), sum(HomeLoss[NauticalMiles > 0]))
)
chisq.test(c(sum(HomeWin[NauticalMiles > 0]), sum(Draw[NauticalMiles > 0]), sum(HomeLoss[NauticalMiles > 0]))
)
chisq.test(c(sum(HomeWin[NauticalMiles > 0]), sum(Draw[NauticalMiles > 0]), sum(HomeLoss[NauticalMiles > 0])))
curve(dchisq, 0,100)
curve(dchisq, df=2, 0,100)
help(dchisq)
str(mls)
sum(mls$HomeWin[mls$NauticalMiles > 0])
sum(mls$Draw[mls$NauticalMiles > 0])
sum(mls$HomeLoss[mls$NauticalMiles > 0])
wldCount <- matrix(c(sum(mls$HomeWin[mls$NauticalMiles > 0]), sum(mls$Draw[mls$NauticalMiles > 0]), sum(mls$HomeLoss[mls$NauticalMiles > 0])), nrow=1)
wldCount
dwdl <- function(x) {dchisq(x, df=2)}  #dwdl is chisq distribution of win-lose-draw
chisq.test(count)
chisq.test(wdlCount)
wdlCount <- matrix(c(sum(mls$HomeWin[mls$NauticalMiles > 0]), sum(mls$Draw[mls$NauticalMiles > 0]), sum(mls$HomeLoss[mls$NauticalMiles > 0])), nrow=1)
wdlCount
chisq.test(wdlCount)
dwdl <- function(x) {dchisq(x, df=2)}  #dwdl is chisq distribution of win-lose-draw
curve(dwdl, 0, 100)
dwdl <- function(x) {dchisq(x, df=2)}  #dwdl is chisq distribution of win-lose-draw
curve(dwdl, 0, 100, ylab="Chi-squared DF=2", main="Home Field Advantage:  Evidence of Effect")
abline(v=66.125)


integrate(dwdl, 0, 66.125)
wdlCount
sum(wdlCount)
history()
history(100)
curve(dwdl, 0, 100, main="Chi-Squared Distribution with Two Degrees of Freedom")
curve(dwdl, 0, 100, main="Chi-Squared Distribution with Two Degrees of Freedom", xlab="Chi-Squared", ylab="")
abline(v=46.9)
curve(dwdl, 0, 100, main="Chi-Squared Distribution, df=2", xlab="Chi-Squared", ylab="")
abline(v=46.9)
str(mls)
hist(mls$HomeGoalDiff)
hist(mls$HomeGoalDiff, prob=TRUE)
curve(density(mls$HomeGoalDiff))
line(density(mls$HomeGoalDiff))
lines(density(mls$HomeGoalDiff))
hist(mls$HomeGoalDiff, prob=TRUE)
hist(mls$HomeGoalDiff)
abline(v=mean(mls$HomeGoalDiff))
mean(mls$HomeGoalDiff)
homeGoalDiffByTeam = aggregate(x=mls$HomeGoalDiff[which(mls$NauticalMiles > 0)], by=list(mls$HomeTeam[which(mls$NauticalMiles > 0)]), FUN=mean)
homeGoalDiffByTeam
names(homeGoalDiffByTeam) = c("Team", "HomeGoalDifferential")
homeGoalDiffByTeam
qqplot(mls$HomeGoalDiff)
help(qqplot)
qqnorm(mls$HomeGoalDiff)
 homeGoalDiffByConf = aggregate(x=mls$HomeGoalDiff[which(mls$NauticalMiles > 0)], by=list(mls$HomeConf[which(mls$NauticalMiles > 0)]), FUN=mean)
homeGoalDiffByConf
 aggregate(x=mls$HomeGoalDiff[which(mls$NauticalMiles > 0)], by=list(mls$HomeConf[which(mls$NauticalMiles > 0)]), FUN=mean)
aggregate(x=mls$HomeGoalDiff[which(mls$NauticalMiles > 0)], by=list(mls$NauticalMiles[which(mls$NauticalMiles > 0)]), FUN=mean)
homeGoalDiffByMiles = aggregate(x=mls$HomeGoalDiff[which(mls$NauticalMiles > 0)], by=list(mls$NauticalMiles[which(mls$NauticalMiles > 0)]), FUN=mean)
plot(homeGoalDiffByMiles)
history(200)




season=read.csv(file="Sounders2012.csv", header=TRUE)
str(season)
cor(season)
sum(season$RosalesGoals)
sum(season$RosalesAssists)
attach(season)
names(season)
MLSGoalsFor <- which(GoalsBySounders[MLS == 1])
GoalsBySounders[MLS == 1]
MLSGoalsFor = GoalsBySounders[MLS == 1]
MLSGoalsAgainst = GoalsByOpponent[MLS == 1]
MLSGoalDiff = MLSGoalsFor - MLSGoalsAgainst
MLSMiles = Travelled[MLS == 1]
plot(MLSMiles, MLSGoalDiff)
MLSTimeDiff = TimeZoneDiff[MLS == 1]
plot(MLSTimeDiff, MLSGoalDiff)
MLSOpponent = Opponent[MLS == 1]
MLSHome = Home[MLS == 1]
ls()
names(season)
MLSDate = Date[MLS == 1]
ls(MLS*)
ls()
MLSSeason = cbind(MLSDate, MLSHome, MLSOpponent, MLSMiles, MLSTimeDiff, MLSGoalsFor, MLSGoalsAgainst, MLSGoalDiff)
str(MLSSeason)
MLSSeason
sum(MLSGoalsAgainst[MLSTimeDiff = 1])
sum(MLSGoalsAgainst[MLSTimeDiff = 2])
sum(MLSGoalsAgainst[MLSTimeDiff = 3])
sum(MLSGoalsAgainst[MLSTimeDiff == 3])
sum(MLSGoalsAgainst[MLSTimeDiff == 2])
sum(MLSGoalsAgainst[MLSTimeDiff == 1])
sum(MLSGoalsDiff[MLSTimeDiff == 0])
sum(MLSGoalDiff[MLSTimeDiff == 0])
sum(MLSGoalDiff[MLSTimeDiff == 1])
sum(MLSGoalDiff[MLSTimeDiff == 2])
sum(MLSGoalDiff[MLSTimeDiff == 3])
plot(MLSMiles, MLSGoalDiff)

GoalDiff = c(sum(MLSGoalDiff[MLSTimeDiff == 0]), 
             sum(MLSGoalDiff[MLSTimeDiff == 1]), 
			 sum(MLSGoalDiff[MLSTimeDiff == 2]), 
			 sum(MLSGoalDiff[MLSTimeDiff == 3]))
TimeDiff = c(0,1,2,3)
GoalDiffByTimeZone = cbind(TimeDiff, GoalDiff)			 

attach(mls)
homePointsByTeam = aggregate(x=mls$HomePoints[which(mls$NauticalMiles > 0)], by=list(mls$HomeAbbr[which(mls$NauticalMiles > 0)]), FUN=sum)
names(homePointsByTeam) = c("Team", "PointsEarnedAtHome")
homePointsAllowedByTeam = aggregate(x=mls$VisitorPoints[which(mls$NauticalMiles > 0)], by=list(mls$HomeAbbr[which(mls$NauticalMiles > 0)]), FUN=sum)
names(homePointsAllowedByTeam) = c("Team", "PointsAllowedAtHome")
roadPointsByTeam = aggregate(x=mls$VisitorPoints[which(mls$NauticalMiles > 0)], by=list(mls$VisitorAbbr[which(mls$NauticalMiles > 0)]), FUN=sum)
names(roadPointsByTeam) = c("Team", "PointsEarnedOnRoad")
merge(homePointsByTeam, homePointsAllowedByTeam, by.x="Team", by.y="Team")

homeGoalDiff = mls$HomeGoalDiff
homeTeam = factor(mls$HomeAbbr)
lmfit = (homeGoalDiff ~ homeTeam)
boxplot(lmfit)

[1] "Date"                "HomeTeam"            "HomeAbbr"            "HomeTeamScore"       "VisitorScore"       
 [6] "HomeGoalDiff"        "VisitorTeam"         "VisitorAbbr"         "HomeWin"             "Draw"               
[11] "HomeLoss"            "HomePoints"          "VisitorPoints"       "HomeTimeZone"        "VisitorTimeZone"    
[16] "VisitorTimeZoneDiff" "HomeConf"            "VisitorConf"         "HomeLat"             "HomeLong"           
[21] "VisitorLat"          "VisitorLong"         "NauticalMiles"       "HomeTeamSalary"      "HomeTeamAttendance" 
[26] "HomeTeamCapacity"    "FractionFull"   
cbind(HomeTeam, HomeTeamScore, VisitorScore)


# Home goal differential as a function of visitor time zone difference and nautical miles.
homeTeam = levels(mls$HomeTeam)
homeGoalDiff = mls$HomeGoalDiff
visitorTimeZoneDiff = mls$VisitorTimeZoneDiff*mls$NauticalMiles
lmfit = lm(homeGoalDiff ~ visitorTimeZoneDiff)
plot(visitorTimeZoneDiff, jitter(homeGoalDiff), xlab="Home team time zone - Visitor team time zone", ylab="Home team goal differential", main="Home team goal differential versus visitor team time zone difference")
abline(lmfit)

# Home goal differential as a function of covariates.
homeTeam = levels(mls$HomeTeam)
homeGoalDiff = mls$HomeGoalDiff
visitorTimeZoneDiff = mls$VisitorTimeZoneDiff
lmfit = lm(homeGoalDiff ~ visitorTimeZoneDiff + mls$NauticalMiles + mls$HomeTeamSalary + mls$HomeTeamAttendance + mls$HomeTeamCapacity + mls$FractionFull)
plot(visitorTimeZoneDiff, jitter(homeGoalDiff), xlab="Home team time zone - Visitor team time zone", ylab="Home team goal differential", main="Home team goal differential versus visitor team time zone difference")
abline(lmfit)
