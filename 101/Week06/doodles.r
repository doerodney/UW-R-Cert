data <-read.table("C:/Users/Rod/SkyDrive/R/Crawley", header=T)
attach(data)
plot( c(0,30), c(0,60), type="n", xlab="Sample Size", ylab="Confidence Interval")
for (k in seq(3, 30, 3)) {
	a <-numeric(10000)
	for (i in 1:10000) {
		a[i] <- mean(sample(values, k, replace=T))
	}
	points(c(k,k), quantile(a, c(0.025, 0.975)), type="b")
}


TestIfSharedBirthdays <- function(ClassSize) {
	Days <- 1:365
	ClassBirthdays <- sample(Days, ClassSize, replace=T)
	UniqueBirthdays <- unique(ClassBirthdays)
	length(ClassBirthdays) > length(UniqueBirthdays)
}


GetProbabilitySharedBirthdays <- function(ClassSize) { 
	nReps <- 1000
	Results <- rep(NA, nReps)
	for (i in 1:nReps) {
		Result[i] = TestIfSharedBirthdays(ClassSize)
	}
	sum(Result)/length(Result)
}

# N = class size
nTrials <- 1000
Result <-numeric(100)
for (n in 1:100) {
	r <-numeric(nTrials)
	for (i in 1:nTrials) {
		r[i] <- GetProbabilitySharedBirthdays(N)
	}
	Result[n] <- mean(r)
}

	
	
