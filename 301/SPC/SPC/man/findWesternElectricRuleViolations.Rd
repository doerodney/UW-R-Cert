\name{findWesternElectricRuleViolations}
\alias{findWesternElectricRuleViolations}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
findWesternElectricRuleViolations
}
\description{
Given a vector of numeric zones, this function looks for sequences of data that constitute Western Electric Rule violations.
  
}
\usage{
findWesternElectricRuleViolations(x, x.bar = NULL, sigma = NULL)
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
	Rule 4 violation:  This is 9 consecutive points that fall on the same side of the centerline (Zone C or beyond).
	Rule 3 violation:  This is 4 out of 5 points that fall beyond the 1 sigma limit (Zone B or beyond) on the same side of the centerline.
	Rule 2 violation:  This is 2 out of 3 consecutive points that fall beyond the 2 sigma limit (Zone B or beyond) on the same side of the centerline.
	Rule 1 violation:  This is any point that falls beyond the 3 sigma limit (Zone C or beyond).
}
\value{
a (possibly empty) dataframe with these numeric columns:  idxInitial, idxFinal, rule
}
\references{
Western Electric Rules wikipedia site
}
\author{
Rod Doe
}
\note{
None
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
classifyByWesternElectricRuleZones
}
\examples{
x.bar = 0 
## sigma = 1	
## x = c(0, 1.1,1.2,1.1,  1.3,1.4,1.3, 1.4,1.5,1.4, 0,  1.1,-1.0,1.1,1.2,1.1, 0.0, 2.2,1.1,2.3, 0, 4.1, -4.1)

## results =  findWesternElectricRuleViolations(x, x.bar, sigma)
## (results)

## The function is currently defined as
function (x, x.bar = NULL, sigma = NULL) 
{
    if (is.null(x.bar) || is.null(sigma)) {
        x.bar = mean(x)
        sigma = sd(x)
    }
    results <- data.frame(idxInitial = numeric(), idxFinal = numeric(), 
        rule = numeric())
    nItems = length(x)
    zones.numeric = classifyByWesternElectricRuleZones.numeric(x, 
        x.bar, sigma)
    minRunLen = 9
    for (idxInitial in 1:(nItems - minRunLen + 1)) {
        idxFinal = (idxInitial + minRunLen - 1)
        if ((all(zones.numeric[idxInitial:idxFinal] > 0)) || 
            (all(zones.numeric[idxInitial:idxFinal] < 0))) {
            results = logWesternElectricRuleViolation(results, 
                idxInitial, idxFinal, 4)
        }
    }
    minRunLen = 5
    for (idxInitial in 1:(nItems - minRunLen + 1)) {
        idxFinal = (idxInitial + minRunLen - 1)
        if ((any(zones.numeric[idxInitial:idxFinal] > 1)) || 
            (any(zones.numeric[idxInitial:idxFinal] < -1))) {
            countZoneB = 0
            countOpposite = 0
            matched = 0
            for (i in idxInitial:idxFinal) {
                if (zones.numeric[i] > 1) {
                  countZoneB = countZoneB + 1
                }
                else if (zones.numeric[i] < 0) {
                  countOpposite = countOpposite + 1
                }
            }
            if ((countZoneB == 4) && (countOpposite == 1)) {
                matched = 1
            }
            if (matched == 0) {
                countZoneB = 0
                countOpposite = 0
                for (i in idxInitial:idxFinal) {
                  if (zones.numeric[i] < -1) {
                    countZoneB = countZoneB + 1
                  }
                  else if (zones.numeric[i] > 0) {
                    countOpposite = countOpposite + 1
                  }
                  if ((countZoneB == 4) && (countOpposite == 
                    1)) {
                    matched = 1
                  }
                }
            }
            if (matched == 1) {
                results = logWesternElectricRuleViolation(results, 
                  idxInitial, idxFinal, 3)
            }
        }
    }
    minRunLen = 3
    for (idxInitial in 1:(nItems - minRunLen + 1)) {
        idxFinal = (idxInitial + minRunLen - 1)
        if ((any(zones.numeric[idxInitial:idxFinal] > 2)) || 
            (any(zones.numeric[idxInitial:idxFinal] < -2))) {
            countZoneA = 0
            countSameSide = 0
            matched = 0
            for (i in idxInitial:idxFinal) {
                if (zones.numeric[i] > 2) {
                  countZoneA = countZoneA + 1
                }
                else if (zones.numeric[i] > 0) {
                  countSameSide = countSameSide + 1
                }
            }
            if ((countZoneA == 2) && (countSameSide == 1)) {
                matched = 1
            }
            if (matched == 0) {
                countZoneA = 0
                countSameSide = 0
                for (i in idxInitial:idxFinal) {
                  if (zones.numeric[i] < -2) {
                    countZoneA = countZoneA + 1
                  }
                  else if (zones.numeric[i] < 0) {
                    countSameSide = countSameSide + 1
                  }
                  if ((countZoneB == 2) && (countSameSide == 
                    1)) {
                    matched = 1
                  }
                }
            }
            if (matched == 1) {
                results = logWesternElectricRuleViolation(results, 
                  idxInitial, idxFinal, 2)
            }
        }
    }
    violations = sort(union(which(zones.numeric == 4), which(zones.numeric == 
        -4)))
    if (length(violations) > 0) {
        for (i in 1:length(violations)) {
            results = logWesternElectricRuleViolation(results, 
                violations[i], violations[i], 1)
        }
    }
    return(results)
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
