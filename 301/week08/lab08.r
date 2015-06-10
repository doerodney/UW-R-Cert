require(RCurl)
url <- "http://www.ndbc.noaa.gov/stndesc.shtml"

a <- getURL(url)

b <- sub(".*?<pre>(.*?)(</pre>.*|$)", "//1", a)
setwd("C:/Users/Rod/SkyDrive/R/301/week08")

write(b, file = "StationData.txt", ncolumns = 12)
Stations <- read.table("StationData.txt", skip = 4, header = TRUE)


Latitude <- Stations$DEG + Stations$MIN/60 + Stations$SEC/60/60
Longitude <- Stations$DEG.1 + Stations$MIN.1/60 + Stations$SEC.1/60/60
##=================
require(RCurl)
url <- "http://www.ndbc.noaa.gov/stndesc.shtml"

a <- getURL(url)

b <- sub(".*?<pre>(.*?)(</pre>.*|$)", "\\1", a)
setwd("C:/Users/Rod/SkyDrive/R/301/week08")

write(b, file = "StationData.txt", ncolumns = 12)
Stations <- read.table("StationData.txt", skip = 4, header = TRUE)


Latitude <- Stations$DEG + Stations$MIN/60 + Stations$SEC/60/60
Longitude <- Stations$DEG.1 + Stations$MIN.1/60 + Stations$SEC.1/60/60

require(mapdata)
map("world", xlim = range(Longitude), ylim = range(Latitude), col = "darkgrey")

Longitude <- Longitude*ifelse(Stations$E.W == "E", 1, -1)
map("world", xlim = range(Longitude), ylim = range(Latitude), col = "darkgrey")
points(Longitude, Latitude)

locator(2)  # to find corners around Hawaii

keep <- which(findInterval(Longitude, c(-170, -148)) == 1 & findInterval(Latitude,     c(14, 28)) == 1)


Longitude <- Longitude*ifelse(Stations$E.W == "E", 1, -1)
Longitude[Longitude > 90] <- Longitude[Longitude > 90] - 360

map("world", xlim = range(Longitude), ylim = range(Latitude), col = "darkgrey")
points(Longitude, Latitude)

url <- "http://www.ndbc.noaa.gov/view_text_file.php?filename=51000c2012.txt.gz&dir=data/historical/cwind/"
S.51000 <- read.table(url, skip = 1, header = TRUE)

head(S.51000)


url <- sprintf("http://www.ndbc.noaa.gov/view_text_file.php?filename=51000c2012.txt.gz&dir=data/historical/cwind/"
S.51000 <- read.table(url, skip = 1, header = TRUE)


loadBuoyData <- function(s)
{
  url <- paste("http://www.ndbc.noaa.gov/view_text_file.php?filename=",s,"c2012.txt.gz&dir=data/historical/cwind/",sep="")
  try(read.table(url, skip=1, header=TRUE, comment="*"))
 
}

for(s in Stations$STATION)
{
    mydata <-  try(loadBuoyData(51001))
    if(is(mydata) != "try-error")
        assign(paste("WS", s, sep="."), mydata)
}


tidyBuoyData <- function(S) {
    Time <- as.POSIXlt(paste(S$X.yr, "-", S$mo, "-", S$dy, " ", S$hr, ":", S$mn, 
        sep = ""), format = "%Y-%m-%d %H:%M")
    Speed <- S$m.s
    Direction <- S$degT
    data.frame(Time, Speed, Direction)
}


Wind.51000 <- tidyBuoyData(S.51000)






