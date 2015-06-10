pkgname <- "windier"
source(file.path(R.home("share"), "R", "examples-header.R"))
options(warn = 1)
options(pager = "console")
library('windier')

assign(".oldSearch", search(), pos = 'CheckExEnv')
cleanEx()
nameEx("Stations")
### * Stations

flush(stderr()); flush(stdout())

### Name: Stations
### Title: Stations
### Aliases: Stations
### Keywords: datasets

### ** Examples

data(Stations)
head(Stations)



cleanEx()
nameEx("loadBuoyData")
### * loadBuoyData

flush(stderr()); flush(stdout())

### Name: loadBuoyData
### Title: loadBuoyData
### Aliases: loadBuoyData
### Keywords: ~kwd1 ~kwd2

### ** Examples

##---- Should be DIRECTLY executable !! ----
##-- ==>  Define data, use random,
##--	or do  help(data=index)  for the standard data sets.
loadBuoyData(46067)  # A buoy in the Gulf of Alaska

## The function is currently defined as
function (buoyID) 
{
    url <- sprintf("http://www.ndbc.noaa.gov/view_text_file.php?filename=%dc2012.txt.gz&dir=data/historical/cwind/", 
        buoyID)
    df <- read.table(url, skip = 1, header = TRUE, comment = "*")
    Time <- as.POSIXlt(sprintf("%04d-%02d-%02d %02d:%02d:00", 
        df$X.yr, df$mo, df$dy, df$hr, df$mn))
    Speed <- df$m.s
    Direction <- df$degT
    df.tidy <- data.frame(Time, Speed, Direction)
    df.tidy
  }



cleanEx()
nameEx("plotMap")
### * plotMap

flush(stderr()); flush(stdout())

### Name: plotMap
### Title: plotMap
### Aliases: plotMap
### Keywords: ~kwd1 ~kwd2

### ** Examples

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



cleanEx()
nameEx("windier-package")
### * windier-package

flush(stderr()); flush(stdout())

### Name: windier-package
### Title: What the package does (short line) windier
### Aliases: windier-package windier
### Keywords: package

### ** Examples

data(Stations)
head(Stations)
loadBuoyData(46067)
plotMap(45.0, 50.0, -130.0, -120.0)



### * <FOOTER>
###
cat("Time elapsed: ", proc.time() - get("ptime", pos = 'CheckExEnv'),"\n")
grDevices::dev.off()
###
### Local variables: ***
### mode: outline-minor ***
### outline-regexp: "\\(> \\)?### [*]+" ***
### End: ***
quit('no')
