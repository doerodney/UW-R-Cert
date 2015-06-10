f <- function(x) {
   y = c(6,5,4,6,6,3,12,7,4,2,6,7,4)
   fx = y * x
   
   result = sum(fx)
   return(result)	
}

fpts <- function(x) {
   y = c(6,5,4,6,6,3,12,7,4,2,6,7,4)
   res = numeric(length(x))
   for (i in 1:length(x)) {
	  fx = y * x[i]
	  res[i] = sum(fx)
	}	
   
   return(res)	
}


myhat <- function(mod, normalize=TRUE)
{
	x = model.matrix(mod)
	n = dim(x)[1]
	p = dim(x)[2]
	
	tmp = (diag(x%*% solve(t(x) %*% x)%*%t(x)))
	
	if(normalize) return(n*tmp/p)
	return(tmp)
}


x = matrix(rnorm(10000), nrow = 10)
y = matrix(rnorm(10000), nrow = 10)
mypees = mapply(function(z, w) {summary(lm(w~z)) $coef[2, 4], split(x, col(x)), split(y, col(y)