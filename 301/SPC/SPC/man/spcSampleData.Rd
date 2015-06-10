\name{spcSampleData}
\alias{spcSampleData}
\docType{data}
\title{
spcSampleData - example of data produced by plotSpcData
}
\description{
Produced by invocation of plotSpcChart(batchAverages, batchRanges).
Contains the initial data in the batchAverage and batchRange columns, with the applicable SPC state in the state.* columns.	
}
\usage{data(spcSampleData)}
\format{
  A data frame with 23 observations on the following 4 variables.
  \describe{
    \item{\code{batchAverage}}{a numeric vector}
    \item{\code{state.batchAverage}}{a numeric vector}
    \item{\code{batchRange}}{a numeric vector}
    \item{\code{state.batchRange}}{a numeric vector}
  }
}
\details{
The data in the batchAverages are specifically designed to violate Western Electric rules 4,3,2,1.  The data in the batchRange are designed to be more
typical.
}
\source{
Low pressure atmospheric extraction (pulled from thin air)
}
\references{
None
}
\examples{
data(spcSampleData)
head(spcSampleData)
## maybe str(spcSampleData) ; plot(spcSampleData) ...
}
\keyword{datasets}
