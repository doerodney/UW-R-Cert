setwd("C:/Users/Rod/SkyDrive/R/301/Week03")
autos = read.csv("autoMPGtrain.csv", as.is = TRUE)

autos$gp100m = 100/autos$mpg
autos$continent = factor(autos$continent)
autos$name = tolower(autos$name)
autos$diesel = grepl("diesel", autos$name)
autos$diesel[autos$name == "mercedes-benz 240d"] = TRUE
autos$wagon = grepl("[(]sw[)]", autos$name)
autos$cylgroup = cut(autos$cyl, c(2, 5.5, 6.5, 9))

library(mgcv)
gam0 = gam(mpg ~ diesel + continent + s(weight) + s(year), data = autos)