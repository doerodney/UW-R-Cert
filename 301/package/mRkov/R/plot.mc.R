plot.mc <-
function(mc, col=as.integer(mc), ...)
  {
    plot(1:length(mc), mc, col="grey", type="l", yaxt="n", ...)
    points(1:length(mc), mc, col=col, pch=19)
    axis(2, 1:length(levels(mc)), labels=levels(mc), las=1)
  }
