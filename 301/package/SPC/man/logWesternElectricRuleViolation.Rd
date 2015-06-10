\name{logWesternElectricRuleViolation}
\alias{logWesternElectricRuleViolation}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
logWesternElectricRuleViolation
}
\description{
appends a new row onto an existing dataframe of rule violations
}
\usage{
logWesternElectricRuleViolation(results, idxInitial, idxFinal, rule)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{results}{
a (possibly empty) dataframe with these numeric columns:  idxInitial, idxFinal, rule
}
  \item{idxInitial}{
the index of the value in the source vector where a violation was initially detected
}
  \item{idxFinal}{
the index of the value in the source vector where the violation was last detected
}
  \item{rule}{
the Western Electric Rule number that was violated in the range idxInitial:idxFinal (inclusive). 0 if no violation.
}
}
\details{
Simply appends a new row in a standard fashion so that THAT wheel need not be reinvented.
}
\value{
the original results dataframe with one additional row added to it
}
\references{
None
}
\author{
Inigo Montoya
}
\note{
You are the man with six fingers.  You killed my father.  Prepare to die.
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
None
}
\examples{
## results <- data.frame(idxInitial = numeric(), idxFinal = numeric(), rule = numeric())
## results <- logWesternElectricRuleViolation(results, 5, 5, 1)
## (results)

## The function is currently defined as
function (results, idxInitial, idxFinal, rule) 
{
    result <- data.frame(idxInitial = idxInitial, idxFinal = idxFinal, 
        rule = rule)
    results <- rbind(results, result)
    return(results)
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
