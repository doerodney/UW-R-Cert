rfTune=function(formula,data,ntree=200,mvals,nodevals,inorder=FALSE,nclust=3)
{
require(doSNOW)

	cl <- makeCluster(nclust, type = "SOCK")
	registerDoSNOW(cl)

tgrid=expand.grid(mtry=mvals,nodesize=nodevals)
#print(tgrid)
n=dim(data)[1]

tout<-system.time(cout<-foreach(a=1:dim(tgrid)[1],.combine='rbind',.packages='randomForest',.inorder=inorder) %dopar% {
	tmp=randomForest(formula=formula,data=data,ntree=ntree,mtry=tgrid$mtry[a],nodesize=tgrid$nodesize[a])
	data.frame(m=tgrid$mtry[a],nodesize=tgrid$nodesize[a],success=sum(diag(tmp$confusion))/n)
} )
stopCluster(cl)
return(list(times=tout,performance=cout))
}


rfTune0=function(formula,data,ntree=200,mvals,nodevals)
{

tgrid=expand.grid(mtry=mvals,nodesize=nodevals)
#print(tgrid)
n=dim(data)[1]

tout<-system.time(cout<-foreach(a=1:dim(tgrid)[1],.combine='rbind') %do% {
	tmp=randomForest(formula=formula,data=data,ntree=ntree,mtry=tgrid$mtry[a],nodesize=tgrid$nodesize[a])
	data.frame(m=tgrid$mtry[a],nodesize=tgrid$nodesize[a],success=sum(diag(tmp$confusion))/n)
} )
return(list(times=tout,performance=cout))
}