\name{plotMap}
\alias{plotMap}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
plotMap
}
\description{
Plots a map of a specified latitude,longitude range and includes the positions of NOAA weather buoys in that range.
}
\usage{
plotMap(minLat, maxLat, minLong, maxLong, text = TRUE, pos = 1, cex = 0.8, font = 4)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{minLat}{
%%     ~~Describe \code{minLat} here~~
}
  \item{maxLat}{
%%     ~~Describe \code{maxLat} here~~
}
  \item{minLong}{
%%     ~~Describe \code{minLong} here~~
}
  \item{maxLong}{
%%     ~~Describe \code{maxLong} here~~
}
  \item{text}{
%%     ~~Describe \code{text} here~~
}
  \item{pos}{
%%     ~~Describe \code{pos} here~~
}
  \item{cex}{
%%     ~~Describe \code{cex} here~~
}
  \item{font}{
%%     ~~Describe \code{font} here~~
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
plotMap(45.0, 50.0, -130.0, -120.0)

## The function is currently defined as
function (minLat, maxLat, minLong, maxLong, text = TRUE, pos = 1, 
    cex = 0.8, font = 4) 
{
    data(Stations)
    idx.LE.max.lat = which(Stations$Latitude <= maxLat)
    idx.GE.min.lat = which(Stations$Latitude >= minLat)
    idx.valid.lat = intersect(idx.LE.max.lat, idx.GE.min.lat)
    idx.LE.max.long = which(Stations$Longitude <= maxLong)
    idx.GE.min.long = which(Stations$Longitude >= minLong)
    idx.valid.long = intersect(idx.LE.max.long, idx.GE.min.long)
    idx.valid.stations = intersect(idx.valid.lat, idx.valid.long)
    selected.stations = Stations[idx.valid.stations, ]
    latitude = selected.stations$Latitude
    longitude = selected.stations$Longitude
    map("world", xlim = range(c(minLong, maxLong)), ylim = range(c(minLat, 
        maxLat)), col = "darkgrey")
    points(longitude, latitude, pos = 1, cex = 0.8, font = 4)
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
