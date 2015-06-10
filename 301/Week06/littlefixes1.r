#### Little Fixes Package, Code File 1
#### Assaf Oron, May 2013

myhist<-function(x,col='lightblue',right=TRUE,...) hist(x,col=col,right=right,...)

mytab<-function(x,useNA='ifany',...) table(x,useNA=useNA,...)

myq<-function(x,type=6,...) quantile(x,type=type,...)

myread<-function(fname,as.is=TRUE,...) read.csv(file=fname,as.is=as.is,...)

