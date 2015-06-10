safeXtab=function(formula,data,type="sum")
{
# We first count how many obs. in each output array cell
xvars=all.vars(formula)[-1]  
countform=paste('~',xvars[1])
for (a in 2:length(xvars)) countform=paste(countform,'+',xvars[a])
countarr=xtabs(as.formula(countform),data=data)
mainarr=xtabs(formula,data=data)
mainarr[countarr==0]=NA

if (type=="mean") { mainarr=mainarr/countarr
} else if (max(countarr)>1) cat("Warning! Some values are sums of multiple instances.\n")
return(mainarr)
}