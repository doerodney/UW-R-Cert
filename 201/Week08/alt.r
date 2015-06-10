#==My Way================================================
setwd("C:/Users/Rod/SkyDrive/R/201/Week08")  # SkyDrive from home
data = read.csv("seedTrain.csv", header=TRUE)

# Convert Variety to a factor.  Classification NEEDS this!
data$Variety = factor(data$Variety)  # MUY IMPORTANTE!!  
levels(data$Variety)

idxVariety.1 = which(data[,idxVariety] == 1)
idxVariety.2 = which(data[,idxVariety] == 2)
idxVariety.3 = which(data[,idxVariety] == 3)

idxAll = 1:length(data[,1])
nFolds = 10
size = 5
Cp = 0.01
# vcp = 0.1^seq(1, 4, 0.5)  # errs = 14 11 11 11 11 11 11
# vcp = 10^seq(-3.5, -0.5, 0.5)  # errs =  11 11 11 11 11 14 14
# vcp = 0.1^seq(1.0, 2.5, 0.25)  #errs = 14 14 11 11 11 11 11
# vcp = 10^seq(-3.0, -0.5, 0.25) # errs = 11 11 11 11 11 11 11 14 14 14 14
# vcp = 10^seq(-5.0, -0.5, 0.25)  # errs  =  11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 14 14 14 14
vcp = c(0.005, 0.01, 0.015)  # errs =  11 11 11

cvResult=matrix(NA,nrow=length(idxAll), ncol=length(vcp))

for (idxCp in 1:length(vcp)) {
	#cat('c')
	for (nFold in 1:nFolds)
	{
		# Determine where to start to read fold data.
		idxStart = ((nFold - 1) * size) + 1
		
		# Select a small, uniform set of validation indices.
		idxValidation = c(	idxVariety.1[idxStart:(idxStart + (size - 1))],
							idxVariety.2[idxStart:(idxStart + (size - 1))],
							idxVariety.3[idxStart:(idxStart + (size - 1))])
		
		# Select all remaining indices as training indices.
		idxTrain = setdiff(idxAll, idxTest)	
		
		# Select validation data.
		dataValidation = data[idxValidation, ]
		
		# Select training data.
		dataTrain = data[idxTrain, ]
		
		# Generate a model using training data.
		model = rpart(dataTrain$Variety ~ ., 
			data=dataTrain,
			control=rpart.control(cp=vcp[idxCp]),
			parms=list(split="information"))
		
		# Predict values using validation data.
		cvResult[idxValidation, idxCp] = predict(model, newdata=dataValidation, type="class")
		#cat('f')
	}	
}

errs = numeric(length(vcp))
for (i in 1:length(vcp)) {
  errs[i] = sum(data$Variety != cvResult[,i])
}  
(errs)
