\name{classifyByWesternElectricRuleZones.numeric}
\alias{classifyByWesternElectricRuleZones.numeric}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
classifyByWesternElectricRuleZones.numeric
}
\description{
Given a vector of data, creates and returns a vector of Western Electric Rule numeric zones for each point.
Western Electric Rules classify data into zones of A (2-3 sigma), B (1-2 sigma), and C (0-1) sigma.
This function returns numeric classifications 4 (> 3 sigma), 3 (positive class A), 2 (positive class B), 1 (positive class C), and 0 (equals mean).
It also returns negative numeric classifications -4 (< 3 sigma), -3 (negative class A), -2 (negative class B), and -1 (negative class C).
}
\usage{
classifyByWesternElectricRuleZones.numeric(x, x.bar = NULL, sigma = NULL)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{x}{
a vector of numeric values that are to be classified into Western Electric Rule zones
}
  \item{x.bar}{
the mean value to be used for classification.  Is NULL by default.  Calculated as necessary.
}
  \item{sigma}{
the standard deviation to be used for classification.  Is NULL by default.  Calculated as necessary.
}
}
\details{
	Western Electric Rules classify data into zones of A (2-3 sigma), B (1-2 sigma), and C (0-1) sigma.
	This function returns numeric classifications 4 (> 3 sigma), 3 (positive class A), 2 (positive class B), 1 (positive class C), and 0 (equals mean).
	It also returns negative numeric classifications -4 (< 3 sigma), -3 (negative class A), -2 (negative class B), and -1 (negative class C).
}
\value{
a vector with these positive/negative values: |4| = outlier, |3| = zone A, |2| = zone B, |1| = zone C, 0 = x.bar

}
\references{
None
}
\author{
Rod Doe
}
\note{
None
}

%% 

\seealso{
classifyByWesternElectricRuleZones
}
\examples{
## x = c(3.1, 2.1, 1.1, 0.1, 0, -0.1, -1.1, -2.1, -3.1)
## x.bar = 0
## sigma = 1
## xclass = classifyByWesternElectricRuleZones.numeric(x, x.bar, sigma)
## (xclass)
## # [1]  4  3  2  1  0 -1 -2 -3 -4


## The function is currently defined as
function (x, x.bar = NULL, sigma = NULL) 
{
    if (is.null(x.bar) || is.null(sigma)) {
        x.bar = mean(x)
        sigma = sd(x)
    }
    gt.pos.three.sigma = which(x > (x.bar + (3 * sigma)))
    gt.pos.two.sigma = which(x > (x.bar + (2 * sigma)))
    gt.pos.one.sigma = which(x > (x.bar + sigma))
    gt.xbar = which(x > x.bar)
    eq.xbar = which(x == x.bar)
    lt.x.bar = which(x < x.bar)
    lt.neg.one.sigma = which(x < (x.bar - sigma))
    lt.neg.two.sigma = which(x < (x.bar - (2 * sigma)))
    lt.neg.three.sigma = which(x < (x.bar - (3 * sigma)))
    outliers = union(gt.pos.three.sigma, lt.neg.three.sigma)
    pos.A = setdiff(gt.pos.two.sigma, gt.pos.three.sigma)
    pos.B = setdiff(gt.pos.one.sigma, gt.pos.two.sigma)
    pos.C = setdiff(gt.xbar, gt.pos.one.sigma)
    neg.C = setdiff(lt.x.bar, lt.neg.one.sigma)
    neg.B = setdiff(lt.neg.one.sigma, lt.neg.two.sigma)
    neg.A = setdiff(lt.neg.two.sigma, lt.neg.three.sigma)
    zones = numeric(length(x))
    zones[gt.pos.three.sigma] = 4
    zones[pos.A] = 3
    zones[pos.B] = 2
    zones[pos.C] = 1
    zones[eq.xbar] = 0
    zones[neg.C] = -1
    zones[neg.B] = -2
    zones[neg.A] = -3
    zones[lt.neg.three.sigma] = -4
    return(zones)
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
