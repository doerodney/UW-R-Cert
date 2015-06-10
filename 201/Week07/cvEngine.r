### Utilities

mse=function(x,ref) mean((x-ref)^2,na.rm=TRUE)
qae=function(x,ref,q=0.75,...) quantile(abs(x-ref),na.rm=TRUE,p=q,...)
rmse=function(x,ref) sqrt(mse(x,ref))
r2cor=function(x,ref) { tmp=cor(x,ref,use='pairwise.complete.obs'); ifelse(tmp<0,0,tmp^2) }

#   cvEngine takes a dataframe of covariates, a list of strings that are
#   the covariates that will appear in the model, and the name of the column
#   that contains the outcome data.  The function
#   implements K-fold cross-validation groups for any regression-type model that uses standard R formulae  
#   as well as custom-made CV for kriging regression. 
#   The function computes a fit of the model for each group, and returns the R2 and RMSE of the model, the cross-
#   validated R2, RMSE and 'quant'-quantile AE for the model, and the model. 
#	The CV groups can be generated randomly - or specified by the user.
#
#  Credits: Laina Mercer, Amanda Gassett, Michael Young, Assaf Oron, 2009-2013
#  Modified version of a routine developed at MESA-Air Project, University of Washington

cvEngine<-function(dataf, cov.list, outcome,regfun=lm,cv.group=10,
	transform.list=NA,transfun=exp,rawpreds=FALSE,
	wts=rep(1,dim(dataf)[1]),xscale=FALSE,quant=0.75,
	kriging=FALSE,parlel=FALSE, nclusters=3,r2type="cor2",...)
{
# dataf: data frame containing the variables
# cov.list: character vector with names of terms in the model. For interactions, specify "x1","x2" and "x1:x2" separately.
# outcome: character, name of the y variable
# regfun: the regression function (many methods inheriting from 'lm' can be used)
# cv.groups: integer, either the number of groups (K), or a vector containing the CV group assignments of all observations.
# transform.list,transfun: use if y is transformed and you want metrics on the original scale.
# rawpreds: logical. Return only the vector of raw predictions?
# wts: vector of length n, weights used in the regression
# xscale: logical. Should the X matrix be scaled?
# quant: in (0,1), the quantile to use in the QAE metric
# kriging: logical. Should the regression function be 'kriging.cv'?
# parlel,nclusters: for use with 'kriging.cv', for parallel computing

#cat("in ")
    if(wts[1]==0) wts=rep(1,dim(dataf)[1])
    cv.data<-dataf[,names(dataf)==outcome]

### Optionally scaling the covariates (but not the outcome)
	if(xscale) dataf[,-outcome]=scale(dataf[,-outcome])
	
    if (!is.na(transform.list[[1]][1])) { 
### in case y is transformed, but original-scale evaluation is wanted

        original.data=cv.data
#### we assume scaling was done by date and there is a variable called "date" in the dataset
#### This routine designed for log-transformation, but you can retool it
#### user is responsible for everything to match up

        dates=sort(unique(dataf$date))
        for (a in 1:length(dates)) {

            original.data[dataf$date==dates[a]]=
                transfun(transform.list$mean[a]+transform.list$sd[a]*original.data[dataf$date==dates[a]])
        }
    }
### If needed, generate CV groups
    if (length(cv.group)==1)    cv.group<-sample(1:cv.group,size=length(cv.data),replace=TRUE)
    dataf$cv.group=cv.group

    cv.group.list<-unique(dataf$cv.group)
    cv.pred.lm<-rep(NA,nrow(dataf))

### making the formulas; 
    x<-paste(outcome,"~",cov.list[1],sep="")
    for(i in 2:length(cov.list)) x<-paste(x,"+",cov.list[i],sep="")
    lin.trend<-as.formula(x)

    ########## Model fits ##############

        if (kriging) {
            cv.pred.lm=kriging.cv(cv=cv.group,y=cv.data,X=dataf[,cov.list],parlel=parlel, nclusters=nclusters,...)
            ### "..." is for the distance matrix
#           print(summary(cv.pred.lm))

        } else {
			for (j in 1:length(cv.group.list)){
				lm.fit<-regfun(lin.trend,data=dataf,subset=which(dataf$cv.group!=cv.group.list[j]),weights=wts,...)
				cv.pred.lm[which(dataf$cv.group%in%cv.group.list[j])]<-
					predict(lm.fit,newdata=dataf[which(dataf$cv.group%in%cv.group.list[j]),])
			} # End CV group Loop
        }
 ######### Cross Validated stats  ######

    outR2<-r2cor(cv.pred.lm,cv.data)
	if(r2type=='mse') outR2 <- max(0,1-mse(cv.pred.lm,cv.data)/var(cv.data, na.rm=TRUE), na.rm=TRUE)
    if(r2type=='cor') outR2<-cor(cv.pred.lm,cv.data)
	outRMSE<-rmse(cv.pred.lm,cv.data)
    outQAE<-qae(cv.pred.lm,cv.data,q=quant,type=6)

    if (!is.na(transform.list[[1]][1])) { 
	### in case back-transformed, original-scale CV is wanted

    original.cv.pred=cv.pred.lm
    for (a in 1:length(dates)) {

            original.cv.pred[dataf$date==dates[a]]=
                transfun(transform.list$mean[a]+transform.list$sd[a]*original.cv.pred[dataf$date==dates[a]])
        }
    original.cv.r2<-r2cor(original.cv.pred,original.data)
    if(r2type=='mse') original.cv.r2 <- max(0,1-mse(original.cv.pred,original.data)/var(cv.data, na.rm=TRUE), na.rm=TRUE)
	if(r2type=='cor') original.cv.r2<-cor(original.cv.pred,original.data,use='pairwise.complete.obs')
    original.cv.robr2 <- cor(original.cv.pred,original.data,method="spearman",use='pairwise.complete.obs')^2
    original.cv.rmse<-rmse(original.cv.pred,original.data)
    original.cv.qae<-qae(original.cv.pred,original.data,q=quant,type=6)
}

# (optional) return predictions directly, do stats elsewhere...
if (rawpreds) return (cv.pred.lm)

        ############## Output the stats ################
    LUR.R2=NA
    LUR.RMSE=NA
### for reference, return also the in-sample (non-CV) stats
    if (!kriging) {
        regfit<-regfun(lin.trend,data=dataf)
        LUR.R2<-cor(regfit$fitted,dataf[,outcome])^2
		if(r2type=='cor') LUR.R2<-cor(regfit$fitted,dataf[,outcome])
		if(r2type=='mse') LUR.R2<-max(0,1-mse(regfit$fitted,cv.data)/var(cv.data, na.rm=TRUE), na.rm=TRUE)
        LUR.RMSE<-rmse(regfit$fitted,cv.data)
    }
 #cat("out... ")
if (!is.na(transform.list[[1]][1])) { 
# If back-transformation was requested, return a longer vector....
    return(list(stats=c(LUR.R2,LUR.RMSE,outR2,outRMSE,outQAE,original.cv.r2,
	original.cv.rmse,original.cv.robr2,original.cv.qae),model=x))
    }  ### ....otherwise, a shorter one...
        list(stats=c(LUR.R2,LUR.RMSE,outR2,outRMSE,outQAE),model=x)
}    #### \end{cvEngine}