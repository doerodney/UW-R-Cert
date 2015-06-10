### Utilities

matchlen=function(x,ref) length(ref[ref %in% x])  ### for weeding out models with unwanted combos

map = function(x) ### for scrambling membership in cv groups
{
v=unique(x) 
key=sample(v,size=length(v))
y=x
for (a in 1:length(v)) y[x==v[a]]=key[a]
return(y) 
}

##############################################################

#### The calling function, managing the Cross-Validated constrained-subset search  #######

##############################################################

#  Credits: Laina Mercer, Amanda Gassett, Michael Young, Assaf Oron, 2009-2013
#  Modified version of a routine developed at MESA-Air Project, University of Washington


cvConSubsets<-function(covar.dataframe, outcome, cov.list, cv.group=10,max.covariates=length(cov.list),
forced=NULL,avoid=NULL,randomize=FALSE,rand.length=100,transform.list=NA,kriging=FALSE,...)
# covar.dataframe: the dataset
# outcome: character, the name of the outcome ('y') variable
# cov.list: character vector, names (or algebraic formulae) for the covariates to be considered.
# cv.group: either the # of CV groups to randomize, or a vector of length n with CV group assignments
# max.covariates: the maximum model size to consider
# forced: if not NULL, then a vector of indices indicating the covariates in 'cov.list' that should be in *all* models
# avoid: if not NULL, then a list of integer vectors, indicating groups of indices, in each of which at most 1 should be in any model
# randomize, rand.length: To avoid combinatoral explosion, the search can run in a mode that randomizes 'rand.length' combinations, 
### -> each of length 'max.covariates'. This can serve as a pre-filtering step.
# transform.list: use if y is transformed and you want metrics on the original scale.
# kriging: logical. Should the regression function be 'kriging.cv'?
# parlel,nclusters: for use with 'kriging.cv', for parallel computing
{
startime=date()
cat(startime)
nsamp=dim(covar.dataframe)[1]
# If no CV group specified, do random K-fold CV
if (length(cv.group)==1) {
	cat ("No CV group specified, doing plain ",cv.group,"-fold CV...\n")
	cv.group=sample(1:cv.group,size=nsamp,replace=TRUE)
}

ticktime=ifelse(kriging,100,500)
nstats=ifelse(is.na(transform.list[[1]][1]),7,11)

names(covar.dataframe)<-tolower(names(covar.dataframe))
outcome<-tolower(outcome)
cov.list<-tolower(cov.list)
if(!any(grepl("date",names(covar.dataframe)))) covar.dataframe$date=rep(1,nsamp)
covar.dataframe<-covar.dataframe[!(is.na(covar.dataframe[,names(covar.dataframe)==outcome])),]
max.R2<-0
min.RMSE<-10000
    all.results<-as.data.frame(matrix(NA,nrow=1,ncol=nstats))

 ### Setting search boundaries and constraints
 max.covariates<-min(length(cov.list), max.covariates)

num.covars=max(2,length(forced))
overlaps=length(unlist(avoid))-length(avoid)

#   cat("overlaps ",overlaps)


if (randomize) { num.covars=max.covariates }

while (num.covars<=min(length(cov.list)-overlaps,max.covariates)){

         if (randomize) {
		 
			model.list=matrix(NA,ncol=rand.length,nrow=num.covars)
			for (b in 1:rand.length) model.list[,b]=sample(cov.list,size=num.covars)
			model.list=unique(model.list,MARGIN=2)
		}  else  {
### Generating all term combinations for a given model size
		model.list<-combn(x=cov.list,m=num.covars)
		}
        cat("\n Size and initial combinations: ",dim(model.list),'...')
		
		if (length(forced)>0 && num.covars<length(cov.list)) 
		{ 
			for (a in cov.list[forced]) model.list=model.list[,apply(model.list,2,function(x,b) b%in%x,b=a)]
			if (num.covars==length(forced)) model.list=matrix(model.list,ncol=1)
		}
        if(length(avoid)>0 && num.covars>length(forced)+1) 
		{
            for (a in 1:length(avoid)) 
			{
                multvec=apply(model.list,2,matchlen,ref=cov.list[avoid[[a]]])
                model.list=model.list[,multvec<2]
            }
        }
        nmodels=dim(model.list)[2]
		cat("now ",nmodels)
        presult<-as.data.frame(matrix(NA,nrow=nmodels,ncol=nstats))

        for (i in 1:nmodels ){
        if (i %% 10 ==0) cat ('.')
        if (i %% ticktime ==0) cat(date(),'\n')

		### Calling the individual regression run
        tmp=cvEngine(covar.dataframe, model.list[,i], outcome,cv.group=cv.group,transform.list=transform.list,kriging=kriging,...)
		presult[i,-c(1,nstats)]=tmp$stats
		presult[i,nstats]=tmp$model
		presult[i,1]=num.covars
# print(result[i,])
         }
        all.results<-rbind(all.results, presult)
        num.covars=num.covars+1
}

cat("\nStarted: ",startime,"     Ended: ",date(),'\n')	
cat("Run Completed. It is advisable to perform statistics on top/bottom performing models, rather than choose the single best one.\n")

 #   all.results$V1<-as.numeric(all.results$V1)
  #  all.results$V2<-as.numeric(all.results$V2)
  #  all.results$V3<-as.numeric(all.results$V3)
  #  all.results$V4<-as.numeric(all.results$V4)
#    names(all.results)<-c("LUR.R2","LUR.RMSE","CV.LUR.R2","CV.LUR.RMSE","model")

    names(all.results)[1:7]<-c("nVars","Insample.R2","Insample.RMSE","CV.R2","CV.RMSE","CV.QAE","model")

    if(!is.na(transform.list[[1]][1])) names(all.results)=c(names(all.results)[1:6],c("orig.cv.R2","orig.cv.RMSE","cv.rank.R2","orig.cv.QAE","model"))

    all.results=all.results[-1,]
    cat(date(),'\n')
    if(!is.na(transform.list[[1]][1])) {

        return(all.results[order(as.numeric(all.results$orig.cv.RMSE)),])
    }
    all.results[order(all.results$CV.RMSE),]



}
