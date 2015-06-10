## from rgl demo
ellipsoid3d <- function(rx=1,ry=1,rz=1,n=30,ctr=c(0,0,0),
                        qmesh=FALSE,
                        trans = par3d("userMatrix"),...) {
  if (missing(trans) && !rgl.cur()) trans <- diag(4)
  degvec <- seq(0,2*pi,length=n)
  ecoord2 <- function(p) {
    c(rx*cos(p[1])*sin(p[2]),ry*sin(p[1])*sin(p[2]),rz*cos(p[2])) }
  v <- apply(expand.grid(degvec,degvec),1,ecoord2)
  if (qmesh) v <- rbind(v,rep(1,ncol(v))) ## homogeneous
  e <- expand.grid(1:(n-1),1:n)
  i1 <- apply(e,1,function(z)z[1]+n*(z[2]-1))
  i2 <- i1+1
  i3 <- (i1+n-1) %% n^2 + 1
  i4 <- (i2+n-1) %% n^2 + 1
  i <- rbind(i1,i2,i4,i3)
  if (!qmesh)
    quads3d(v[1,i],v[2,i],v[3,i],...)
  else return(rotate3d(qmesh3d(v,i,material=...),matrix=trans))
}

## the unit sphere
.sphere <- ellipsoid3d(qmesh=TRUE,trans=diag(4))

## apply transformations to the unit sphere
rgl.ellipsoid2 <- function (x=0,y=0,z=0, a = 1,b=1,c=1, phi=0,theta=0,psi=0,
                       subdivide = 3, smooth = TRUE, ...)
{

    result <- scale3d(.sphere, a,b,c)
    rotM <- euler(phi,theta,psi)
    result <- rotate3d(result,matrix=rotM)
    result <- translate3d(result, x,y,z)
    invisible(result)
}

## loop over the specification of a cluster
rgl.ellipsoids2 <- function(positions, sizes, angles,...){

  N <- NROW(positions)
  ll <- lapply(seq(1,N), function(ii)
               rgl.ellipsoid2(positions[ii,1],positions[ii,2],positions[ii,3],
                         sizes[ii,1],sizes[ii,2],sizes[ii,3],
                         angles[ii,1],angles[ii,2],angles[ii,3], ...))

  shapelist3d(ll,...)

}

N <- 100
set.seed(123)
positions <- matrix(rnorm(3*N), ncol=3)
sizes <- matrix(runif(3*N, 0.01, 0.05), ncol=3)
angles <- matrix(runif(3*N, 0, 2*pi), ncol=3)