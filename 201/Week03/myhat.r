myhat=function(mod,normalize=TRUE)
{
x=model.matrix(mod)
n=dim(x)[1]
p=dim(x)[2]

tmp=diag(x%*%solve(t(x)%*%x)%*%t(x))

if(normalize) return(n*tmp/p)
return(tmp)
}