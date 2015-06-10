count <- matrix(c(167, 79, 77, 77, 79, 167), nrow=2)
chisq.test(count)

count <- matrix(c(93, 74, 40, 37, 37, 42, 40, 39, 37, 40, 93, 74))
chisq.test(count)

count <- matrix(c(167, 79, 77), nrow=1)
chisq.test(count)

dwdl <- function(x) {dchisq(x, df=2)}  #dwdl is chisq distribution of win-lose-draw
curve(dwdl, 0, 100)
integrate(dwdl, 0, 49)