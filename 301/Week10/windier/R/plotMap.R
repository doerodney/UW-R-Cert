plotMap <-
function(minLat, maxLat, minLong, maxLong, text = TRUE, pos = 1, cex = 0.8, font = 4) {
data(Stations)

# Select indices of stations with valid latitude.
idx.LE.max.lat = which(Stations$Latitude <= maxLat)
idx.GE.min.lat = which(Stations$Latitude >= minLat)
idx.valid.lat = intersect(idx.LE.max.lat, idx.GE.min.lat)

# Select indices of stations with valid longitude. 
idx.LE.max.long = which(Stations$Longitude <= maxLong)
idx.GE.min.long = which(Stations$Longitude >= minLong)
idx.valid.long = intersect(idx.LE.max.long, idx.GE.min.long)

# Select indices of stations with valid latitude and longitude.
idx.valid.stations = intersect(idx.valid.lat, idx.valid.long)
selected.stations = Stations[idx.valid.stations,]

latitude = selected.stations$Latitude
longitude = selected.stations$Longitude

map("world", xlim = range(c(minLong, maxLong)), ylim = range(c(minLat, maxLat)), col = "darkgrey")
points(longitude, latitude, pos=1, cex=0.8, font=4)
}
