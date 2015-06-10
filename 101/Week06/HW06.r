Suit=c(rep("Clubs", 13), rep("Diamonds", 13), rep("Hearts", 13), rep("Aces", 13))
SuitCode=c(rep(1, 13), rep(2, 13), rep(3, 13), rep(4, 13))
Value = c(2:14, 2:14, 2:14, 2:14)
Deck <- cbind(Suit, SuitCode, Value)

IsFlush <- function(nCards) {
	deck = c(rep(1, 13), rep(2, 13), rep(3, 13), rep(4, 13))
	hand = sample(deck, nCards, replace = FALSE)
	suit = hand[1]
	result = prod(hand == suit)
}	

flushes <- numeric(10000)
for (j in 1:length(flushes)) { flushes[j] <- IsFlush(5) }
pFlush = 100 * sum(flushes)/length(flushes)

trials <- numeric(100)
flushes <- numeric(10000)
for (i in 1:length(trials)) {
	for (j in 1:length(flushes)) { flushes[j] <- IsFlush(5) }
	trials[i] = 100 * sum(flushes)/length(flushes)
}
plot(trials, xlab="Trial", ylab="Percent Flushes")	

IsStraight <- function(nCards) {
	result = TRUE
	deck = c(c(2:14), c(102:114), c(202:214), c(302:314))
	hand = sample(deck, nCards, replace = FALSE)
	numbers = sort(hand%%100)
	for (i in 1:(nCards - 1)) {
		if (numbers[i + 1] != (numbers[i] + 1)) {
			result = FALSE
			break
		}
	}		
	return(result)
}	


IsStraight <- function(nCards) {
	result = TRUE
	deck = c(c(2:14), c(102:114), c(202:214), c(302:314))
	hand = sample(deck, nCards, replace = FALSE)
	numbers = sort(hand%%100)
	minNumber = min(numbers)
	maxNumber = max(numbers)
	# Is range correct for consecutive numbers?
	if ((max(numbers) - min(numbers)) == (nCards - 1)) {
		# Min and max are correct.  Check inner numbers.
		innerNumbers = numbers[2:(nCards - 1)]
		nextNumbers = numbers[3:nCards]
		if (sum(nextNumbers - innerNumbers) != (length(numbers) - 2)) { 
			result = FALSE
		}
	}		
	return(result)
}	


straights <- numeric(10000)
for (j in 1:length(straights)) { straights[j] <- IsStraight(5) }
pStraight = 100 * sum(straights)/length(straights)

trials <- numeric(100)
straights <- numeric(10000)
for (i in 1:length(trials)) {
	for (j in 1:length(straights)) { straights[j] <- IsStraight(5) }
	trials[i] = 100*sum(straights)/length(straights)
}	
summary(trials)
hist(trials, prob=TRUE, main="Percentage of straight poker hands", xlab="")
lines(density(trials))


numbers = sort(hand%%100)
for (i in 1:(nCards - 1)) {
if (numbers[i + 1] != (numbers[i] + 1)) {
result = FALSE
break
}
}
return(result)
}
trials <- numeric(100)
straights <- numeric(10000)
for (i in 1:length(trials)) {
for (j in 1:length(straights)) { straights[j] <- IsStraight(5) }
trials[i] = 100*sum(straights)/length(straights)
}
summary(trials)
hist(trials, prob=TRUE, main="Percentage of straight poker hands", xlab="")
lines(density(trials))
100 / 0.3453
straights <- numeric(10000)
for (j in 1:length(straights)) { straights[j] <- IsStraight(5) }
pStraight = 100 * sum(straights)/length(straights)
pStraight
100/pStraight
help(rbinom)
history()


failures <- numeric(1000000)
for (i in 1:1000000) {
	trial <-rbinom(100, 1, 0.999)
	failures[i] = sum(trial == 0)
}
	

	
ala <- dbinom(x=0:100, size=100, prob=0.39, log = FALSE)
ind <- dbinom(x=0:100, size=100, prob=0.505, log = FALSE)
cal<- dbinom(x=0:100, size=100, prob=0.62, log = FALSE)
cols = c("red", "purple", "blue")
plot(ala, xlab="", ylab="", main="Binomial Distributions of State Election Results", col="red")
points(ind, col="purple")
points(cal, col="blue")
legend("topright", legend=c("Alaska", "Indiana", "California"), col=cols, pch=19)
history()



