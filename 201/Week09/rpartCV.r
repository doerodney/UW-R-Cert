rpartCV=function(formula,data,cvid,predtype='class',cpvec,...)
{
cat(date(),'\n')
cvg=unique(cvid)
n=dim(data)[1]
cout=matrix(NA,nrow=n,ncol=length(cpvec))

for (b in 1:length(cpvec))
{
	for (a in cvg)
	{
		ktree=rpart(formula=formula,data=data[cvid!=a,],control=rpart.control(cp=cpvec[b]),...)
		cout[cvid==a,b]=predict(ktree,newdata=data[cvid==a,],type=predtype)
	}
	cat('.')
}
cat(date(),'\n')
return(cout)
}
	