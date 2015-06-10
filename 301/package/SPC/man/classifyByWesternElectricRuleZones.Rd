\name{classifyByWesternElectricRuleZones}
\alias{classifyByWesternElectricRuleZones}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
classifyByWesternElectricRuleZones
}
\description{
Given a vector of data, creates and returns a vector of Western Electric Rule zones for each point.
	Western Electric Rules classify data into zones of A (2-3 sigma), B (1-2 sigma), and C (0-1) sigma.
}
\usage{
classifyByWesternElectricRuleZones(x, x.bar = NULL, sigma = NULL)
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
standard deviation to be used for classification.  Is NULL by default.  Calculated as necessary.
}
}
\details{
Western Electric Rules classify data into zones of A (2-3 sigma), B (1-2 sigma), and C (0-1) sigma.
}
\value{
a vector with these values: 'O' = outlier, 'A' = zone A, 'B' = zone B, 'C' = zone C
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

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
None
}
\examples{
## x = c(3.1, 2.1, 1.1, 0.1, 0, -0.1, -1.1, -2.1, -3.1)
## x.bar = 0
## sigma = 1
## xclass = classifyByWesternElectricRuleZones.numeric(x, x.bar, sigma)
## (xclass)
## #[1] "O" "A" "B" "C" "C" "C" "B" "A" "O"

## The function is currently defined as
function (x, x.bar = NULL, sigma = NULL) 
{
    zones.numeric = classifyByWesternElectricRuleZones.numeric(x, 
        x.bar, sigma)
    zone.A = union(which(zones.numeric == 3), which(zones.numeric == 
        -3))
    zone.B = union(which(zones.numeric == 2), which(zones.numeric == 
        -2))
    zone.C = union(which(zones.numeric == 1), which(zones.numeric == 
        -1))
    zone.C = union(zone.C, which(zones.numeric == 0))
    zone.Outlier = union(which(zones.numeric == 4), which(zones.numeric == 
        -4))
    zones = character(length(x))
    zones[zone.A] = "A"
    zones[zone.B] = "B"
    zones[zone.C] = "C"
    zones[zone.Outlier] = "O"
    return(zones)
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
