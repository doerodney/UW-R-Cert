# Set the working directory.
getwd()
setwd("D:/R/101/Week02")
shell("dir")
shell("dir")

# Read the Students dataframe.
Students <- read.csv("StudentSurvey.csv")
Students
str(Students)
PingPong = table(Students$Pingpong)
PingPong
PingPong.Males = table(Students$Pingpong[Students$Sex == "Male"])
PingPong.Males
PingPong.Females = table(Students$Pingpong[Students$Sex == "Female"])
PingPong.Females
PingPong.All = table(Students$Pingpong)
PingPong.All 
PingPong.Names = c("None", "Low", "Moderate", "High", "Obsession") 
names(PingPong.All) = PingPong.Names
PingPongMatrix <- rbind(PingPong.All, PingPong.Females, PingPong.Males)
PingPongMatrix
# Draw side by side pie charts of ping pong interest by gender.
#par(mfrow=c(1,2), mar=c(4,4,4,4))
#pie(PingPong.Females, PingPong.Names, main="Ping Pong Appeal:  Females")
#pie(PingPong.Males, PingPong.Names, main="Ping Pong Appeal:  Males")
# Create a PNG version for import into Word.
#png(filename="PingPongInterestByGender.png")
#par(mfrow=c(1,2), mar=c(2,4,2,4))
#pie(PingPong.Females, PingPong.Names, main="Ping Pong Interest:  Females")
#pie(PingPong.Males, PingPong.Names, main="Ping Pong Interest:  Males")
#dev.off()

Students <- read.csv("StudentSurvey.csv")
Students
str(Students)
PingPong = table(Students$Pingpong)
PingPong
PingPong.Males = table(Students$Pingpong[Students$Sex == "Male"])
PingPong.Males
PingPong.Females = table(Students$Pingpong[Students$Sex == "Female"])
PingPong.Females
PingPong.All = table(Students$Pingpong)
PingPong.All 
PingPong.Names = c("None", "Low", "Moderate", "High", "Obsession") 
names(PingPong.All) = PingPong.Names
PingPongMatrix <- rbind(PingPong.All, PingPong.Females, PingPong.Males)
PingPongMatrix
getwd()
setwd("D:/R/101/Week02")
Students <- read.csv("StudentSurvey.csv")
Students
str(Students)
PingPong = table(Students$Pingpong)
PingPong
PingPong.Males = table(Students$Pingpong[Students$Sex == "Male"])
PingPong.Males
PingPong.Females = table(Students$Pingpong[Students$Sex == "Female"])
PingPong.Females
PingPong.All = table(Students$Pingpong)
PingPong.All 
PingPong.Names = c("None", "Low", "Moderate", "High", "Obsession") 
names(PingPong.All) = PingPong.Names
PingPongMatrix <- rbind(PingPong.All, PingPong.Females, PingPong.Males)
PingPongMatrix
ls()
Students
County.Males = table(Students$County[Students$Sex == "Male"])
County.Females = table(Students$County[Students$Sex == "Female"])
Country.Males
County.Males
Students$County[Students$Sex == "Male"]
Students$Country[Students$Sex == "Male"]
table(Students$Country[Students$Sex == "Male"])
Country.Male = table(Students$Country[Students$Sex == "Male"])
Country.Male = table(Students$Country[Students$Sex == "Female"])
Students$Sex
table(Students$Sex)
Students.Sex = table(Students$Sex)
Students.Sex
StudentGender = table(Students$Sex)
help(rowSums)
Students$Sex
PingPong.Females
PingPong.Females / rowSums(PingPong.Females)
PingPong.Females / rowSums(PingPong.Females)
PingPong
PingPong.Females / rowSums(PingPong)
ls()
StudentGender
PingPong.Female/StudentGender$Female
PingPong.Females/StudentGender$Female
PingPong
PingPongMatrix
M1 = rbind(PingPong.Females, PingPong.Males)
M1
M1[1,]
M1[1,]/sum(M1[1,]
)
M1 = rbind(M1[1,]/sum(M1[1,]), M1[2,]/sum(M1[2,]))
M1
sum(M1[1,])
sum(M1[2,])
PingPong
PingPongMatrix
M2 = cbind(PingPongMatrix[2,]/PingPongMatrix[1,], PingPongMatrix[3,]/PingPongMatrix[1,])
M2
barplot(M1, beside = TRUE)
barplot(t(M2))
dev.off()
dev.off()
help(barplot)
help(legend)
barplot(M1, beside = TRUE)
help(color)
legend("topright", fill = c("pink", "blue"), legend = c("Female", "Male"))
dev.off()
barplot(M1, beside=TRUE, col=c("pink", "blue") )
dev.off()
barplot(M1, beside=TRUE, col=c("pink", "blue"), legend.text=c("None", "Slight", "Moderate", "High", "Obsession") )
names(M1)
M1
names(M1) = c("None", "Slight", "Moderate", "High", "obsession")
M1
M1
PingPongMatrix
f = PingPongMatrix[2,] / sum(PingPongMatrix[2,]
)
f
M1 = rbind(f)
M1
Females = PingPongMatrix[2,] / sum(PingPongMatrix[2,]
)
Females
Males = PingPongMatrix[3,] / sum(PingPongMatrix[3,])
Males
M1 = rbind(Females)
M1
M1 = rbind(Females, Males)
M1
M2
CM2 = M2
CM2
names(CM2) = c("Female", "Male")
CM2
CM2 = M2
CM2
names(CM2[1,]) = c("Female", "Male")
CM2
names(CM2[,1]) = "Female"
CM2
M2.None = M2[1,]
M2.None
M2.Low = M2[2,]
M2.Moderate = M2[3,]
M2.High = M2[4,]
M2.Obsession = M2[5,]
names(M2.None) = c("Female", "Male")
M2.None
CM2 = rbind(M2.None, M2.Low, M2.Moderate, M2.High, M2.Obsession)
CM2
M2 = CM2
M2
M1
barplot(M1, beside=TRUE)
dev.off()
history(200)
barplot(M1, beside=TRUE, col=c("pink", "blue"), legend.text=c("None", "Slight", "Moderate", "High", "Obsession") )
barplot(M1, beside=TRUE, col=c("pink", "blue"), legend.text=c("None", "Slight", "Moderate", "High", "Obsession") )
barplot(M1, beside=TRUE, col=c("pink", "blue"))
legend("topright", fill=c("pink", "blue"), legend=c("Female", "Male")
)
barplot(M1, beside=TRUE, col=c("pink", "blue"), xlab="Ping Pong Interest by Gender")
legend("topright", fill=c("pink", "blue"), legend=c("Female", "Male")
)
history()
pdf(file="PingPongInterestByGender.pdf")
barplot(M1, beside=TRUE, col=c("pink", "blue"), xlab="Ping Pong Interest by Gender")
legend("topright", fill=c("pink", "blue"), legend=c("Female", "Male"))
dev.off()
png(filename="BarPlotPingPongInterestByGender.png")
barplot(M1, beside=TRUE, col=c("pink", "blue"), xlab="Ping Pong Interest by Gender")
legend("topright", fill=c("pink", "blue"), legend=c("Female", "Male"))
dev.off()
barplot(t(M2), beside=TRUE, col=c("pink", "blue"), xlab="Ping Pong Interest by Gender")
M2
None = M2[1,]
Low = M2[2,]
Moderate = M2[3,]
High = M2[4,]
Obsession = M2[5,]
names(None) = c("Female", "Male")
None
CM2 = rbind(None, Low, Moderate, High, Obsession)
CM2
M2 = CM2
barplot(t(M2), beside=TRUE, col=c("pink", "blue"), xlab="Ping Pong Interest by Gender")
legend("topright", fill=c("pink", "blue"), legend=c("Female", "Male"))
barplot(t(M2), col=c("pink", "blue"), xlab="Ping Pong Interest by Gender")
legend("topright", fill=c("pink", "blue"), legend=c("Female", "Male"))
legend("top", fill=c("pink", "blue"), legend=c("Female", "Male"))
legend("right", fill=c("pink", "blue"), legend=c("Female", "Male"))
legend("bottom", fill=c("pink", "blue"), legend=c("Female", "Male"))
legend("bottomleft", fill=c("pink", "blue"), legend=c("Female", "Male"))
legend("topleft", bg="white", fill=c("pink", "blue"), legend=c("Female", "Male"))
help(color)
legend("left", bg=rgb(255,0,0,0.8), fill=c("pink", "blue"), legend=c("Female", "Male"))
legend("left", bg=rgb(1,0,0,0.8), fill=c("pink", "blue"), legend=c("Female", "Male"))
legend("center", bg=rgb(0.5,0.5,0.5,0.8), fill=c("pink", "blue"), legend=c("Female", "Male"))
legend("topright", bg=rgb(0.5,0.5,0.5,0.5), fill=c("pink", "blue"), legend=c("Female", "Male"))
legend("topright", bg=rgb(1,1,1,0.5), fill=c("pink", "blue"), legend=c("Female", "Male"))
legend("topright", bg=rgb(1,1,1,0.2), fill=c("pink", "blue"), legend=c("Female", "Male"))
png(filename="TransposedPingPongInterestByGender.png")
barplot(t(M2), col=c("pink", "blue"), xlab="Ping Pong Interest by Gender")
legend("topright", bg=rgb(1,1,1,0.2), fill=c("pink", "blue"), legend=c("Female", "Male"))
dev.off()
history(200)



