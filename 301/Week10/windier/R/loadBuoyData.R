loadBuoyData <-
function(buoyID)
{
# Load data from NOAA site.
url <- sprintf("http://www.ndbc.noaa.gov/view_text_file.php?filename=%dc2012.txt.gz&dir=data/historical/cwind/", buoyID)
df <- read.table(url, skip=1, header=TRUE, comment="*")
    
# Convert data to acceptable format.
Time <- as.POSIXlt(sprintf("%04d-%02d-%02d %02d:%02d:00", df$X.yr, df$mo, df$dy, df$hr, df$mn)) 
    Speed <- df$m.s
    Direction <- df$degT

# Construct a refined dataframe and return.
    df.tidy <- data.frame(Time, Speed, Direction)
df.tidy
}
