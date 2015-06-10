require(RCurl)
url <- "http://www.ndbc.noaa.gov/stndesc.shtml"

a <- getURL(url)

b <- sub(".*?<pre>(.*?)(</pre>.*|$)", "\\1", a)
setwd("c:/eli/miscellaneous")

write(b, file = "StationData.txt", ncolumns = 12)
Stations <- read.table("StationData.txt", skip = 4, header = TRUE)


Latitude <- Stations$DEG + Stations$MIN/60 + Stations$SEC/60/60
Longitude <- Stations$DEG.1 + Stations$MIN.1/60 + Stations$SEC.1/60/60

require(mapdata)

Longitude <- Longitude*ifelse(Stations$E.W == "E", 1, -1)
Longitude[Longitude > 90] <- Longitude[Longitude > 90] - 360

map("world", xlim = range(Longitude), ylim = range(Latitude), col = "darkgrey")
points(Longitude, Latitude)

url <- "http://www.ndbc.noaa.gov/view_text_file.php?filename=51000c2012.txt.gz&dir=data/historical/cwind/"
S.51000 <- read.table(url, skip = 1, header = TRUE)

s <- 51002

loadBuoyData <- function(s)
{
  url <- paste("http://www.ndbc.noaa.gov/view_text_file.php?filename=",s,"c2012.txt.gz&dir=data/historical/cwind/",sep="")
  try(read.table(url, skip=1, header=TRUE, comment="*"))
}

#for(s in Stations$STATION)
#{
#    mydata <-  try(loadBuoyData(51001))
#    if(is(mydata) != "try-error")
#        assign(paste("WS", s, sep="."), mydata)
#}

WS1 <- loadBuoyData(51000)
WS2 <- loadBuoyData(51002)
WS3 <- loadBuoyData(51003)

head(S.51000)

tidyBuoyData <- function(S) {
    Time <- as.POSIXlt(paste(S$X.yr, "-", S$mo, "-", S$dy, " ", S$hr, ":", S$mn, 
        sep = ""), format = "%Y-%m-%d %H:%M")
    Speed <- S$m.s
    Direction <- S$degT
    data.frame(Time, Speed, Direction)
}

WS1.tidy <- tidyBuoyData(WS1)
WS2.tidy <- tidyBuoyData(WS2)
WS3.tidy <- tidyBuoyData(WS3)


Wind.51000 <- tidyBuoyData(S.51000)

