setwd("C:/Users/Rod/SkyDrive/R/101/Week11")

metrics = read.table(file="FlowerMetrics.txt", header=TRUE)
# Model the sepal length (Y) with respect to sepal width (X) using a linear regression of the form
# M1:Yi=a+ßXi+?i

M1 <- lm(metrics$Sepal.Length ~ metrics$Sepal.Width)
plot(metrics$Sepal.Width, metrics$Sepal.Length, main="Plant Metrics", xlab="Sepal Width", ylab="Sepal Length")
abline(lm(metrics$Sepal.Length ~ metrics$Sepal.Width))
#Coefficients:
#        (Intercept)  metrics$Sepal.Width  
#             6.5262              -0.2234 

mean(M1$residuals)
# [1] -3.268574e-17
sd(M1$residuals)
# [1] 0.8223232

# i.i.d = independent and identically distributed
# plot qqnorm and histogram to show normal distribution
par(mfrow=c(1,2))
qqnorm(M1$residuals, main="qqnorm(residuals)")
hist(M1$residuals, prob=T, main="residuals")
lines(density(M1$residuals))
# Canned plot of model.
par(mfrow=c(2,2))
plot(M1)


sepal = data.frame(
					cbind(	metrics$Sepal.Length[metrics$Species == "setosa"], 
							metrics$Sepal.Length[metrics$Species == "versicolor"], 
							metrics$Sepal.Length[metrics$Species == "virginica"])
				)			
names(sepal) = c("setosa", "versicolor", "virginica")
boxplot(sepal, main="Sepal Length by Species", col=c(2,3,4))

Sepal.Length = metrics$Sepal.Length  
Sepal.Length = factor(metrics$Species) 
lmfit = lm(Sepal.Length ~ Species)
boxplot(lmfit, main="Sepal Length by Species", col=c(2,3,4))

SummaryTable <- data.frame(n = tapply(Sepal.Length, Species, length), mean = tapply(Sepal.Length, 
    Species, mean), sd = tapply(Sepal.Length, Species, sd))
SummaryTable


===History===================
setwd("C:/Users/Rod/SkyDrive/R/101/Week11")
metrics = read.table(file="FlowerMetrics.txt", header=TRUE)
# Model the sepal length (Y) with respect to sepal width (X) using a linear regression of the form
# M1:Yi=a+ßXi+?i
M1 <- lm(metrics$Sepal.Length ~ metrics$Sepal.Width)
plot(metrics$Sepal.Width, metrics$Sepal.Length)
abline(lm(metrics$Sepal.Length ~ metrics$Sepal.Width))
#Coefficients:
#        (Intercept)  metrics$Sepal.Width  
#             6.5262              -0.2234 
mean(M1$residuals)
# [1] -3.268574e-17
sd(M1$residuals)
# [1] 0.8223232
M1 <- lm(metrics$Sepal.Length ~ metrics$Sepal.Width)
plot(metrics$Sepal.Width, metrics$Sepal.Length, main="Plant Metrics", xlab="Sepal Width", ylab="Sepal Length")
abline(lm(metrics$Sepal.Length ~ metrics$Sepal.Width))
summary(M1)
# i.i.d = independent and identically distributed
# plot qqnorm and histogram to show normal distribution
par(mfrow=c(1,2))
qqnorm(M1$residuals, main="qqnorm(residuals)")
hist(M1$residuals, prob=T, main="residuals")
lines(density(M1$residuals)
)
sum(M1$residuals)
length(M1$residuals)
par(mfrow=c(2,2))
plot(M1)
anova(M1)
a = anova(M1)
a
?df
ff <- function(x) {df(x, 1 )}
curve(ff, 0, 1)
ff <- function(x) {df(x, 1, 0 )}
curve(ff, 0, 1)
ff <- function(x) {df(x, 1, 1 )}
curve(ff, 0, 1)
curve(ff, 0, 1)
curve(ff, 0, 1, xlab="", ylab="F value", main="F distribution with 1 DF")
?pf
x = seq(0, 1, 0.05)
x
pf(x, 1, 1)
xx = seq(0, 0.1, 0.001)
pf(xx, 1, 1)
xx = seq(0, 0.1, 0.01)
pf(xx, 1, 1)
curve(ff, 0, 1, xlab="", ylab="F value", main="F distribution with 1 DF")
abline(v=0.06)
metrics
tmetrics = t(metrics)
tmetrics
boxplot(metrics)
rm(tmetrics)
metrics
table(metrics)
metrics
length(metrics[metrics$Species = 'virginica"])
length(metrics[metrics$Species == 'virginica"])
length(metrics[metrics$Species == "virginica"])
length(metrics[metrics$Species == "virginica"])
length(metrics$Species[metrics$Species == "virginica"])
length(metrics$Species[metrics$Species == "versicolor"])
length(metrics$Species[metrics$Species == "setosa"])
sepal = data.frame(metrics$Species[metrics$Species == "virginica"], metrics$Species[metrics$Species == "versicolor"], metrics$Species[metrics$Species == "setosa"])
sepal
sepal = cbind(metrics$Species[metrics$Species == "virginica"], metrics$Species[metrics$Species == "versicolor"], metrics$Species[metrics$Species == "setosa"])
sepal
str(metrics0
str(metrics)
str(metrics)
?cbind
metrics$Sepal.Length[metrics$Species == "setosa"]
metrics$Sepal.Length[metrics$Species == "versicolor"]
metrics$Sepal.Length[metrics$Species == "virginica"]
sepal = cbind(metrics$Sepal.Length[metrics$Species == "setosa"], metrics$Sepal.Length[metrics$Species == "versicolor"],
metrics$Sepal.Length[metrics$Species == "virginica"])
sepal
names(sepal) = c("setosa", "versicolor", "virginica")
sepal
sepal = cbind(metrics$Sepal.Length[metrics$Species == "setosa"], metrics$Sepal.Length[metrics$Species == "versicolor"],
sepal = cbind(metrics$Sepal.Length[metrics$Species == "setosa"], metrics$Sepal.Length[metrics$Species == "versicolor"], metrics$Sepal.Length[metrics$Species == "virginica"])
sepal
names(sepal)
names(sepal)=c("setosa", "versicolor", "virginica")
sepal
names(sepal)=c("setosa", "versicolor", "virginica")
sepal
sepal = cbind(metrics$Sepal.Length[metrics$Species == "setosa"], metrics$Sepal.Length[metrics$Species == "versicolor"], metrics$Sepal.Length[metrics$Species == "virginica"])
boxplot(sepal)
class(sepal)
sepal = data.frame(sepal)
sepal
names(sepal) = c("setosa", "versicolor", "virginica")
sepal
boxplot(sepal)
boxplot(sepal, main="Sepal Length by Species")
boxplot(sepal, main="Sepal Length by Species", col=(2,3,4))
boxplot(sepal, main="Sepal Length by Species", col=c(2,3,4))
sepal = data.frame(cbind(metrics$Sepal.Length[metrics$Species == "setosa"], metrics$Sepal.Length[metrics$Species == "versicolor"], metrics$Sepal.Length[metrics$Species == "virginica"]))
sepal
?data.frame
sepal = cbind(metrics$Sepal.Length[metrics$Species == "setosa"], 
metrics$Sepal.Length[metrics$Species == "versicolor"], 
metrics$Sepal.Length[metrics$Species == "virginica"])
names(sepal) = c("setosa", "versicolor", "virginica")
sepal = cbind(metrics$Sepal.Length[metrics$Species == "setosa"], 
metrics$Sepal.Length[metrics$Species == "versicolor"], 
metrics$Sepal.Length[metrics$Species == "virginica"])
names(sepal) = c("setosa", "versicolor", "virginica")
boxplot(sepal, main="Sepal Length by Species", col=(2,3,4))
sepal = cbind(metrics$Sepal.Length[metrics$Species == "setosa"], 
metrics$Sepal.Length[metrics$Species == "versicolor"], 
metrics$Sepal.Length[metrics$Species == "virginica"])
names(sepal) = c("setosa", "versicolor", "virginica")
boxplot(sepal, main="Sepal Length by Species", col=c(2,3,4))
sepal
sepal = data.frame(
cbind(metrics$Sepal.Length[metrics$Species == "setosa"], 
metrics$Sepal.Length[metrics$Species == "versicolor"], 
metrics$Sepal.Length[metrics$Species == "virginica"])
)
names(sepal) = c("setosa", "versicolor", "virginica")
boxplot(sepal, main="Sepal Length by Species", col=c(2,3,4))
metrics
model = lm(Sepal.Length ~ Species, data=metrics)
model
plot(model)
lmfit = lm(Sepal.Length ~ Species, data=metrics)
lmfit
metrics
boxplot(ZOD ~ Pie, col = c("green", "blue", "red"), ylab = "ZOD (minutes)", 
Sepal.Length = metrics$Sepal.Length
Sepal.Length
Species = factor(metrics$Species)
levels(Species)
boxplot(Sepal.Length ~ Species)
boxplot(Sepal.Length ~ Species, main="Sepal Length by Species", col=c(2,3,4))
lmfit = lm(Sepal.Length ~ Species)
boxplot(lmfit, main="Sepal Length by Species", col=c(2,3,4))
lmfit
anova(lmfit)
names(anova(lmfit))
str(lmfit)
names(anova(lmfit))
lmfit$Pr
lmfit$SUm
lmfit$Sum
summary(lmfit)
SummaryTable <- data.frame(	n = tapply(Sepal.Length, Species, length), 
							mean = tapply(Sepal.Length, Species, mean), 
							sd = tapply(Sepal.Length, Species, sd))
SummaryTable
lmfit = lm(Sepal.Length ~ Species)
lmfit
par(mfrow=c(2,2))
plot(lmfit)
anova(lmfit)

mean(metrics$Sepal.Length)
[1] 5.843333
sum((metrics$Sepal.Length - mean(metrics$Sepal.Length))^2)
[1] 102.1683
sum((metrics$Sepal.Length[metrics$Species == 'setosa'] - mean(metrics$Sepal.Length[metrics$Species == 'setosa']))^2)
[1] 6.0882
sum((metrics$Sepal.Length[metrics$Species == 'versicolor'] - mean(metrics$Sepal.Length[metrics$Species == 'versicolor']))^2)
[1] 13.0552
sum((metrics$Sepal.Length[metrics$Species == 'virginica'] - mean(metrics$Sepal.Length[metrics$Species == 'virginica']))^2)
[1] 19.8128

residuals = 
sum((metrics$Sepal.Length[metrics$Species == 'setosa'] - mean(metrics$Sepal.Length[metrics$Species == 'setosa']))^2)
+
sum((metrics$Sepal.Length[metrics$Species == 'versicolor'] - mean(metrics$Sepal.Length[metrics$Species == 'versicolor']))^2)
+
sum((metrics$Sepal.Length[metrics$Species == 'virginica'] - mean(metrics$Sepal.Length[metrics$Species == 'virginica']))^2)


Source	Sum of Squares	Degrees of Freedom	Mean Square	F-ratio
