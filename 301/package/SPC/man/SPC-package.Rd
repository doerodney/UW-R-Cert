\name{SPC-package}
\alias{SPC-package}
\alias{SPC}
\docType{package}
\title{
SPC - Implements a Statistical Process Control (SPC) chart
~~ package title ~~
}
\description{
Analyzes data for Western Electric SPC (industry standard since 1956) rule violation(s).  Plots data to reveal issues or lack thereof.
}
\details{
\tabular{ll}{
Package: \tab SPC\cr
Type: \tab Package\cr
Version: \tab 1.0\cr
Date: \tab 2013-06-15\cr
License: \tab Fishing license\cr
}
Given a process in which results are produced in batchs (i.e., drive shafts, stored procedure invocations, eggs layed), measure the average value 
and the range of values produced by the batch.  A process owner will want to monitor trends in those data over time to determine if the process is
in control.  Excessive variation will be identified by SPC.  Any violation of SPC rules should trigger investigation and possible remedial action.
}
\author{
Rod Doe

Maintainer: <doerodney@gmail.com>

}
\references{
'Statistical Process Control' by Donald Wheeler
}

\keyword{ package }
\seealso{

}
\examples{
batchAverages = c(0, 1.1,1.2,1.1,  1.3,1.4,1.3, 1.4,1.5,1.4,   0,  1.1,-1,1.1,1.2,1.1,   0,  2.2,1.1,2.3,   0,   4.1, -4.1)
x.bar.batchAverages = 0 
sigma.batchAverages = 1
batchRanges = numeric(length(batchAverages))
x.bar.batchRanges = 10
sigma.batchRanges = 1.0
for (i in 1:length(batchRanges)) { batchRanges[i] = x.bar.batchRanges + rnorm(1, 0, 0.5) }
result = plotSpcChart(batchAverages, batchRanges, x.bar.batchAverages, sigma.batchAverages, x.bar.batchRanges, sigma.batchRanges)
(result)
}
