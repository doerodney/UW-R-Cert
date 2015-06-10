SummaryStatsA <- function(x, y) {
	summaryNames <- c("x.bar", "y.bar", "x.sd", "y.sd", "r", "a", "b", "ss.total", "ss.model", "ss.residual", "r2")
	n = length(x)
	x.bar = sum(x) / n
	y.bar = sum(y) / n
	
	x.var = sum((x - x.bar)^2) / (n - 1)
	y.var = sum((y - y.bar)^2) / (n - 1)
	
	x.sd = sqrt(x.var)
	y.sd = sqrt(y.var)
	
	ss.x = sum(x^2) - ((sum(x)^2) / n)
	ss.y = sum(y^2) - ((sum(y)^2) / n)
	ss.xy = sum(x * y) - ((sum(x) * sum(y)) / n)
	
	b = ss.xy / ss.x
	a = (sum(y) / n) - (b * sum(x) / n)
	
	y.hat = a + x * b
	
	r = ss.xy / sqrt(ss.x * ss.y)
	
	# SStotal = SSmodel + SSerror
	ss.total = sum((y - y.bar)^2)
	
	# SSmodel = sum((y.hat - y.bar)^2)
	ss.model = sum((y.hat - y.bar)^2)
	
	# SSresidual = sum((y - y.hat)^2)
	ss.residual = sum((y-y.hat)^2)
	
	r2 = r * r
	
	result = c(x.bar, y.bar, x.sd, y.sd, r, a, b, ss.total, ss.model, ss.residual, r2) 
	names(result) = summaryNames
	
	return(result)
}	


plot(x,y,pch=16)
abline(lm(y~x))
fitted = predict(lm(y ~ x))
for (i in 1:length(x)) lines(c(x[i], x[i],), c(y[i], fitted[i]))
Error in c(x[i], x[i], ) : argument 3 is empty
for (i in 1:length(x)) lines(c(x[i], x[i]), c(y[i], fitted[i]))

abline(a=mean(y), b=0, col=rgb(0,1,0))

for (i in 1:length(x)) lines( c(x[i], x[i]), c(y[i], mean(y)), col=rgb(0,1,0) )
x = c(0:8)
y = c(12,10,8,11,6,7,2,3,3)
par(mfrow=c(2,2))

tannin = c(0:8)
growth = c(12,10,8,11,6,7,2,3,3)

par(mfrow=c(2,2))
plot(tannin, growth, pch=16, main="Growth = f(tannin)")
abline(lm(growth~tannin))

plot(tannin, growth, pch=16, main="SStotal")
abline(lm(growth~tannin))
abline(h=mean(growth), col=rgb(1,0,0))
fitted=predict(lm(growth~tannin))
for (i in 1:length(tannin)) lines( c(tannin[i],tannin[i]), c(growth[i],mean(growth)), col=rgb(1,0,0) )

plot(tannin, growth, pch=16, main="SSmodel")
abline(lm(growth~tannin))
abline(h=mean(growth), col=rgb(0,1,0))
for (i in 1:length(tannin)) lines( c(tannin[i],tannin[i]), c(fitted[i],mean(growth)), col=rgb(0,1,0) )

plot(tannin, growth, pch=16, main="SSresidual")
abline(lm(growth~tannin))
for (i in 1:length(tannin)) lines( c(tannin[i],tannin[i]), c(fitted[i],growth[i]), col=rgb(0,0,1) )

history()

SummaryStatsB <- function(x, y) {
	summaryNames <- c("x.bar", "y.bar", "x.sd", "y.sd", "r", "a", "b", "ss.total", "ss.model", "ss.residual", "r2")
	n = length(x)
	x.bar = mean(x)
	y.bar = mean(y)
	
	x.sd = sd(x)
	y.sd = sd(y)
	
	m = lm(y~x)
	a = m$coefficients[1]
	b = m$coefficients[2]
	
	y.hat = m$fitted.values
	
	r = cor(x,y)
	
	# SStotal = SSmodel + SSerror
	ss.total = var(y) * (n - 1)
	
	# SSmodel = sum((y.hat - y.bar)^2)
	ss.model = var(y.hat) * (n - 1)
	
	# SSresidual = sum((y - y.hat)^2)
	ss.residual = ss.total - ss.model
	
	r2 = r * r
	
	result = c(x.bar, y.bar, x.sd, y.sd, r, a, b, ss.total, ss.model, ss.residual, r2) 
	names(result) = summaryNames
	
	return(result)
}

par(mfrow=c(2,2))
plot(anscombe$x1, anscombe$x2)
par(mfrow=c(2,2))
plot(anscombe$x1, anscombe$y1)
abline(lm(anscombe$y1 ~ anscombe$x1 + I(anscombe$x1^2))
)
par(mfrow=c(2,2))
plot(anscombe$x1, anscombe$y1,xlab="anscombe-1")
abline(lm(anscombe$y1 ~ anscombe$x1 + I(anscombe$x1^2)))
plot(anscombe$x2, anscombe$y2,xlab="anscombe-2")
abline(lm(anscombe$y2 ~ anscombe$x2 + I(anscombe$x2^2)))
plot(anscombe$x3, anscombe$y3,xlab="anscombe-3")
abline(lm(anscombe$y3 ~ anscombe$x3 + I(anscombe$x3^2)))
plot(anscombe$x4, anscombe$y4,xlab="anscombe-4")
abline(lm(anscombe$y4 ~ anscombe$x4 + I(anscombe$x4^2)))
x = c(1:10)
x
y = 2 * x^2 + 3 * x + 4
y
x = c(0:10)
y = 2 * x^2 + 3 * x + 4
x
y
plot(x, y)
abline(lm(y ~ x + I(x^2)))
history()





