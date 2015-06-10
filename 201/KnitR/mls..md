
Analysis of Home Field Advantage in Major League Soccer 2012
========================================================

This is the report of a project that studied the effect of home field advantage in the 2012 Major League Soccer (MLS) season. 
Project data reveal that in 341 matches, the home side won 174 matches, drew 85, and lost 82.  Given that a team receives three points for a win, one point for a draw, and no points for a loss, the home teams accumulated 607 points, while the visitors accumulated 331 points.
Data studied include results of all MLS matches during the regular season and playoffs.  The data do not include results of matches between MLS and non-MLS sides, nor do they include results from MLS sides playing in tournaments such as the US Open Cup or the Canada Cup.  Put another way, the data include matches that contribute to MLS final standings, and the resultant MLS championship tournament for teams that qualified. 


```{r}
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

```


```{r fig.width=7, fig.height=6}
# boxplot of home goal differential by team.
homeGoalDiff = mls$HomeGoalDiff
homeTeam = factor(mls$HomeAbbr)
lmfit = (homeGoalDiff ~ homeTeam)
boxplot(lmfit, main="Home team goal differential", xlab="Team", ylab="Home team score - visitor team score")
)
```

