require(igraph)
require(zoo)
setwd("C:/Users/Rod/SkyDrive/R/301/Week10")
load("WindDirections.robj")


B1.mc <- cut(Theta$B1, c(0, 45 + 90*0:3,360), c("N","E","S","W","N"))

getNESW <- function(Theta)
  {
    NESW <- cut(Theta, c(0,45 + 90*0:3,360), c("N","E","S","W","N"))
    NESW <- factor(as.character(NESW))
    NESW <- relevel(NESW, "N")
    NESW
   } 
   
# Plot discrete Markov chain.

par(bty="l", mar=c(4,4,2,2))
plot(1:length(B1.mc), B1.mc, col="grey", type="l", ylab="", yaxt="n", xlab="")
points(1:length(B1.mc), B1.mc, col=rgb(0,0,0,.5), pch=19)
axis(2, 1:length(levels(B1.mc)), labels=levels(B1.mc), las=1  )



B1.mc <- getNESW(Theta[,1])

par(bty="l", mar=c(4,4,2,2))
plot(1:length(B1.mc), B1.mc, col="grey", type="l", ylab="", yaxt="n", xlab="")
points(1:length(B1.mc), B1.mc, col=rgb(0,0,0,.5), pch=19)
axis(2, 1:length(levels(B1.mc)), labels=levels(B1.mc), las=1)

plot.mc <- function(mc, col=as.integer(mc), ...)
  {
    plot(1:length(mc), mc, col="grey", type="l", yaxt="n", ...)
    points(1:length(mc), mc, col=col, pch=19)
    axis(2, 1:length(levels(mc)), labels=levels(mc), las=1)
  }

plot.mc(Theta)



# Estimate Markov Chains...
#Rita Chupalov 2: we want transition matrix
#Rita Chupalov 2: we need to build pairs - transitions
#Rita Chupalov 2: and count those
#Rita Chupalov 2: cbind(B1.mc[-length(B1.mc)], B1.mc[-1])

#Gurarie: M.count <- as.matrix(table(B1.mc[-length(B1.mc)], B1.mc[-1]))
#Gurarie: M <- M.count/rowSums(M.count)

getM.hat <- function(mc) 
{
M.count <- as.matrix(table(B1.mc[-length(B1.mc)], B1.mc[-1]))
M <- M.count/rowSums(M.count)
}


getM.hat <- function(mc) 
{
M.count <- as.matrix(table(B1.mc[-length(B1.mc)], B1.mc[-1]))
M <- M.count/rowSums(M.count)
}
M <- getM.hat(B1.mc)
M.graph <- graph.adjacency(M, mode="directed", weighted = TRUE)
plot(M.graph, layout = cbind(c(0,1,0,-1), c(11,0,-1,0)), edge.width = M * 10)
plot(M.graph, layout = cbind(c(0,1,0,-1), c(1,0,-1,0)), edge.width = M * 10)
plot(M.graph, layout = cbind(c(0,1,0,-1), c(1,0,-1,0)), edge.width = M * 10)


getNESW <- function(Theta)
  {
    NESW <- cut(Theta, c(0,45 + 90*0:3,360), c("N","E","S","W","N"))
    NESW <- factor(as.character(NESW))
    NESW <- relevel(NESW, "N")
    NESW
   } 

B1.mc <- getNESW(Theta[,1])

par(bty="l", mar=c(4,4,2,2))
plot(1:length(B1.mc), B1.mc, col="grey", type="l", ylab="", yaxt="n", xlab="")
points(1:length(B1.mc), B1.mc, col=rgb(0,0,0,.5), pch=19)
axis(2, 1:length(levels(B1.mc)), labels=levels(B1.mc), las=1)

plot.mc <- function(mc, col=as.integer(mc), ...)
  {
    plot(1:length(mc), mc, col="grey", type="l", yaxt="n", ...)
    points(1:length(mc), mc, col=col, pch=19)
    axis(2, 1:length(levels(mc)), labels=levels(mc), las=1)
  }

plot.mtm <- function(M, ...)
{
  M.graph <- graph.adjacency(M, mode="directed", weighted = TRUE)
  plot(M.graph, vertex.size = 40, edge.width = M[M>0]*10, edge.color=rgb(0,0,0,.5), 
     ...)
}

M1 <- getM.mc(getNESW(Theta$B1))
M2 <- getM.mc(getNESW(Theta$B2))
M3 <- getM.mc(getNESW(Theta$B2))

#---Fresh copy---------------------------------------------------------

getNESW <- function(Theta)
  {
    NESW <- cut(Theta, c(0,45 + 90*0:3,360), c("N","E","S","W","N"))
    NESW <- factor(as.character(NESW))
    NESW <- relevel(NESW, "N")
    NESW
   } 

plot.mc <- function(mc, col=as.integer(mc), ...)
  {
    plot(1:length(mc), mc, col="grey", type="l", yaxt="n", ...)
    points(1:length(mc), mc, col=col, pch=19)
    axis(2, 1:length(levels(mc)), labels=levels(mc), las=1)
  }

plot.mtm <- function(M, ...)
{
  M.graph <- graph.adjacency(M, mode="directed", weighted = TRUE)
  plot(M.graph, vertex.size = 40, edge.width = M[M>0]*10, edge.color=rgb(0,0,0,.5), 
     ...)
}
getM.mc <- function(mc)
{
	M.count <- as.matrix(table(mc[-length(mc)], mc[-1]))
	M.count/rowSums(M.count)
}
load("WindDirections.robj")

M1 <- getM.mc(getNESW(Theta$B1))
M2 <- getM.mc(getNESW(Theta$B2))
M3 <- getM.mc(getNESW(Theta$B2))

par(mfrow=c(1,3), mar=c(2,2,2,2))
layout <- cbind(c(0,1,0,-1), c(1,0,-1,0))
plot.mtm(M1, layout=layout, edge.label=round(M1,2))
plot.mtm(M2, layout=layout, edge.label=round(M2,2))
plot.mtm(M3, layout=layout, edge.label=round(M3,2))

# Clean workspace...
package.skeleton("mRkov", path="C:/Users/Rod/SkyDrive/R/301/package")


simChain <- function(M, t)
  {
    n <- nrow(M)
    Xs <- rep(0,t)
    X <- sample(1:n,1)
    Xs[1] <- X
    for (i in 2:t) {
      Xs[i] <- sample(1:n, 1, prob = M[Xs[i-1], ])
    }
    Chain <- factor(row.names(M)[Xs])
    class(Chain) <- "mc"
    return(Chain)
  }

B1.M <- getM.mc(getNESW(Theta[,1]))

plot(simChain(B1.M, 100))

 We can use simulated chains to perform a bootstrapped type comparison of two chains. For example, one way to statistically answer the question: could chain `B2` emerge from the same transition matrix as chain `B1`, would be to (1) estimate M1, (2) recreate a large number N of simulated chains of length 365, (3) for each chain obtain the probability transition matrix, and (4) compute the 95% quantile range of the transitions. 

Rod: You cut out about 50% of the time.

Rita Chupalov 2: not clear how to calculate quantile on matrices

Gurarie: You'll see soon

Gurarie: I made a 4x4x1000 array

Gurarie: M1.sim <- array(0,dim=c(4,4,N))

Gurarie: I filled each "layer" of the array with a re-estimated matrix.

Gurarie: And I use the "apply" function over the first two dimensions

Gurarie: LIke this:

Gurarie: M.low <- apply(M1.sim, c(1,2), quantile, .025)

Gurarie: M.high <- apply(M1.sim, c(1,2), quantile, .975)
