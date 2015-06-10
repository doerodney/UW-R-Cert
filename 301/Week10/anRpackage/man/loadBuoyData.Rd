\name{loadBuoyData}
\alias{loadBuoyData}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
%%  ~~function to do ... ~~
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
loadBuoyData(buoyID)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{buoyID}{
%%     ~~Describe \code{buoyID} here~~
}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
%%  ~Describe the value returned
%%  If it is a LIST, use
%%  \item{comp1 }{Description of 'comp1'}
%%  \item{comp2 }{Description of 'comp2'}
%% ...
}
\references{
%% ~put references to the literature/web site here ~
}
\author{
%%  ~~who you are~~
}
\note{
%%  ~~further notes~~
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
}
\examples{
##---- Should be DIRECTLY executable !! ----
##-- ==>  Define data, use random,
##--	or do  help(data=index)  for the standard data sets.

## The function is currently defined as
function (buoyID) 
{
    url <- sprintf("http://www.ndbc.noaa.gov/view_text_file.php?filename=\%dc2012.txt.gz&dir=data/historical/cwind/", 
        buoyID)
    df <- read.table(url, skip = 1, header = TRUE, comment = "*")
    Time <- as.POSIXlt(sprintf("\%04d-\%02d-\%02d \%02d:\%02d:00", 
        df$X.yr, df$mo, df$dy, df$hr, df$mn))
    Speed <- df$m.s
    Direction <- df$degT
    df.tidy <- data.frame(Time, Speed, Direction)
    df.tidy
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
