svdWmissing <-function(X,niter=200,ncomp=min(4,dim(X)[2]-1),conv.reldiff=0.001,iprint=FALSE,normalize=TRUE){
## Iterative svd calculation with missing data.
## Called by Fregion.svd.fit
## Paul Sampson, 2008
## Modifications by Assaf Oron, 2009-2012
## MESA-Air project, University of Washington 
## Another version by Johan Lindstrom is available in the 'SpatioTemporal' package

## Parameters passed to function:
#   X =         Matrix with Site IDs as columns and dates as rows; each column's mean should be set to zero!
#   niter = Integer number of interations
#   ncomp = Integer number of principal components
#   conv.reldiff = Real number;
#   iprint =    Boolean; if iprint, then diff and reldiff are printed during
#                 iterations of the computation

# Initial first element of U matrix is average curve.

    X <- scale(X,scale=normalize)
    u1 <- rowMeans(X, na.rm = T)
    XM <- matrix(1, nrow(X), ncol(X))
    XM[is.na(X)] <- 0
    XZ <- X

# v1 is proportional to X'u1/(u1'u1), but with calculations
# filling in zeros for missing values in the sums.
# Fill in missing values for initial complete SVD calculation.
# Then iterate using only complete data.
    XZ[is.na(X)] <- 0.
    v1 <- diag(t(XZ) %*% (XM * u1))/diag(t(XM * u1) %*% (XM * u1))
    XF <- X
    XF[is.na(X)] <- (matrix(u1, ncol = 1) %*% matrix(v1, nrow = 1))[is.na(X)]

    reldiff <- 1
    for(i in 1:niter) {
        if(reldiff > conv.reldiff) {
            svd0 <- svd(XF)
            Xnew <- X
            if (ncomp>1) {
                Xnew[is.na(X)] <- (svd0$u[, 1:ncomp] %*% diag(svd0$d[1:ncomp]) %*% t(svd0$v[, 1:ncomp]))[is.na(X)]
                } else Xnew[is.na(X)] <- ((svd0$d[1]*svd0$u[, 1:ncomp]) %*% t(svd0$v[, 1:ncomp]))[is.na(X)]
            diff <- max(abs(Xnew - XF))
            reldiff <- diff/max(abs(XF[is.na(X)]))
            if(iprint) print(c(diff, reldiff))
            XF <- Xnew
        }
    }
 #   cat("\nfinal abs change in fill-in: ", diff, "\n")
    rownames(svd0$v)=colnames(X)
    colnames(svd0$v)=paste("Component",1:ncol(svd0$v))
    rownames(svd0$u)=rownames(X)
    colnames(svd0$u)=colnames(X)


    return(list(svd = svd0, Xfill = XF))
}
