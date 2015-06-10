setwd("C:/Users/rod/SkyDrive/R/301/Week03")

drugpain = read.csv("Propofol40.csv")
str(drugpain)
length(drugpain[,1])
par(mfcol = c(1,2))

plot(drugpain$tempF, drugpain$Eroded)
plot(drugpain$tempF, drugpain$Intact)
par(mfcol = c(1,1))