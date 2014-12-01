# ensure results are repeatable
set.seed(7)
# load the library
library(mlbench)
library(caret)
# load the dataset
Churndata=read.csv('path',stringsAsFactors=FALSE)
myvars = names(Churndata) %in% c("columsn", "to", "remove") 
Churndata_final = Churndata[!myvars]
str(Churndata_final)
Churndata_final$Cancelled = as.factor(ifelse(Churndata_final$Cancelled=='Not Cancelled',0,1))
table(Churndata_final$Cancelled)
# prepare training scheme
control = trainControl(method="repeatedcv", number=10, repeats=3)
# train the model
model = train(Cancelled~., data=Churndata_final, method="lvq", preProcess="scale", trControl=control)
# estimate variable importance
importance = varImp(model, scale=FALSE)
# summarize importance
print(importance)
# plot importance
plot(importance)