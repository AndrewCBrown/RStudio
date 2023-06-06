#R project 3: Heart Disease, by Andrew Brown and Sebastian Negrete. April 2019

require(dbscan)
require(ClusterR)
require(e1071)
require(randomForest)

hdf <- read.csv("heart.csv")
names(hdf)[1] <- "age"
hdf <- hdf[-c(49, 282),]
#hdf will be the copy used for EDA, but hf will be used for machine learning
hf <- as.matrix(read.csv("heart.csv"))
hf <- as.data.frame(hf)
hf <- hf[-c(49, 282),]

set.seed(2681678)


############EDA##############


#1 Age Histogram
#Shows distribution of people's age who have heart disease
hist(hdf$age[hdf$target==1], breaks=49, xlab="Age", main="Distriubtion of patient's ages who have heart disease", col="red")
#This graph shows a distribution of all the people's age in our data set
#hist(hdf$age, breaks=49)


#2 Histograms of normalish distributions
#These graphs show the distributions of certain parameters to see how the data collected was. Like if it was a normal distribution or not.
hist(hdf$trestbps, breaks=27, xlab="Trestbps", main="Distriubtion of patient's resting blood pressure in the dataset", col="green") #107
hist(hdf$chol, breaks=50, xlab="Chol", main="Distriubtion of patient's cholesteral in the dataset", col="green")
hist(hdf$thalach, breaks=66, xlab="Thalach", main="Distriubtion of patient's max heart rate in the dataset", col="green")
hist(hdf$oldpeak, breaks=24, xlab="Oldpeak", main="Distriubtion of patient's ST depression in the dataset", col="green")


#3 Simple Kmeans
kmclusters <- kmeans(hdf[,c(1,10)], centers=3)
hdf$km <- kmclusters$cluster
plot(hdf$age, hdf$oldpeak, col=hdf$km, xlab="Age", ylab="Oldpeak", main="A graph of a 2-dimensional KMeans clustering")
legend("topleft", legend = "Each color is a different group", cex = .9)


#4 Multi-variable Kmeans (Note that the graphs only let us look at 2 at a time, but if it was a 4-dimensional graph you could see all the groups easily)
kmclusters <- kmeans(hdf[,c(1,4,5,8)], centers=4)
hdf$km <- kmclusters$cluster
plot(hdf$age, hdf$trestbps, col=hdf$km, xlab="Age", ylab="Trestbps", main="A multi-dimensional KMeans graphed in 2 dimensions")
legend("topleft", legend = "Each color is a different group", cex = .9)
plot(hdf$age, hdf$chol, col=hdf$km, xlab="Age", ylab="Chol", main="A multi-dimensional KMeans graphed in 2 dimensions")
legend("topleft", legend = "Each color is a different group", cex = .9)
plot(hdf$age, hdf$thalach, col=hdf$km, xlab="Age", ylab="Thalach", main="A multi-dimensional KMeans graphed in 2 dimensions")
legend("bottomleft", legend = "Each color is a different group", cex = .9)


#5 DBSCAN
DB <- dbscan(hdf[,c(4,10)], eps = 1.9, minPts = 5)
hdf$db <- DB$cluster
plot(hdf$trestbps, hdf$oldpeak, col=hdf$db, xlab="Trestbps", ylab="Oldpeak", main="A graph of a DB Scan clustering")
legend("topright", legend = "Each color is a different group", cex = .9)


#6 Gaussian Mixture
gmm <- GMM(hdf[,c(5,8)], 1)
hdf$gm <- gmm$Log_likelihood
plot(hdf$chol, hdf$thalach, col=(as.integer(hdf$gm>mean(hdf$gm))+1), xlab="Chol", ylab="Thalach", main="A graph of a Gaussian Mixture clustering")
legend("bottomright", legend = "Each color is a different group", cex = .9)



###Seb's stuff starts



## Logistical Regression

Logistic Regression is used for both classifying and regression. The first thing that needed to happen was to retrieve the csv file by using read.csv. Then a training and testing model were created by making a new column of random numbers from 1-5. A fifth of the data set would be testing and the rest would be training. The for loop was used to initialize the train and test variables. At the same time the model was created along with adding a predicition column. After that the ROC AUC of the model and the training was created for compaison to tell whether or not the model is overfit.

```{r, echo=FALSE}
hf$group <- sample(1:5, nrow(hf), replace = TRUE)
modeling_variables <- c("age", "sex", "trestbps", "thal", "chol", "oldpeak", "exang", "thalach", "cp")
for (group in 1:5){
  train <- hf[hf$group != group, c(modeling_variables, "target")]
  test <- hf[hf$group == group, modeling_variables]
  model <- glm(target ~ ., family = binomial(link = 'logit'), data = train)
  hf$prediction[hf$group == group] <- predict(model, test)
  train$prediction <- predict(model, train)
}
pr <- ROCR::prediction(train$prediction, train$target)
prf <- performance(pr, measure = "tpr", x.measure = "fpr")
plot(prf, main = "Training ROC curve")
auc <- performance(pr, measure = "auc")
auc <- auc@y.values[[1]]
print(paste("Training ROC AUC: ",auc))
pr <- ROCR::prediction(hf$prediction, hf$target)
prf <- performance(pr, measure = "tpr", x.measure = "fpr")
plot(prf, main = "Test ROC curve")
auc <- performance(pr, measure = "auc")
auc <- auc@y.values[[1]]
print(paste("Model ROC AUC: ", auc))
```

## SVM

SVM is used for classification by using a hyperplane to seperate the two groups. The model in svm is different because it can change the function, kernel, used in the model. In our dataset the sigmoid kernel was best for our question we were asking.

```{s,echo=TRUE}
modeling_variables <- c("age", "sex", "cp", "oldpeak", "trestbps", "thal", "fbs", "ca", "exang")
for (group in 1:5){
  train <- hf[hf$group != group, c(modeling_variables, "target")]
  test <- hf[hf$group == group, modeling_variables]
  model <- svm(target ~ ., train, cost = 0.1, tolerance = 0.01, kernel='sigmoid')
  hf$prediction[hf$group == group] <- predict(model, test)
  train$prediction <- predict(model, train)
}
pr <- ROCR::prediction(train$prediction, train$target)
prf <- performance(pr, measure = "tpr", x.measure = "fpr")
plot(prf, main = "Training ROC curve")
auc <- performance(pr, measure = "auc")
auc <- auc@y.values[[1]]
print(paste("Training ROC AUC: ",auc))
pr <- ROCR::prediction(hf$prediction, hf$target)
prf <- performance(pr, measure = "tpr", x.measure = "fpr")
plot(prf, main = "Test ROC curve")
auc <- performance(pr, measure = "auc")
auc <- auc@y.values[[1]]
print(paste("Model ROC AUC: ", auc))
```

## Random Forest

Random forest algorithm can be used for both classifications and regression task. In the tree algorithm, only a singular tree was created for the model, but using the random forest model helped create more trees that fixed the overfitting problem. This process is called bagging. Also, we can increae the mtry and nodesize variables to decrease overfitting.

```{t, echo=TRUE}
modeling_variables <- c("age", "sex", "cp", "oldpeak", "trestbps", "thal", "fbs", "ca", "slope")
for (group in 1:5){
  train <- hf[hf$group != group, c(modeling_variables, "target")]
  test <- hf[hf$group == group, modeling_variables]
  model <- randomForest(target~., train, ntrees = 5000, mtry = 2000, nodesize = 250, maxnodes = 5)
  hf$prediction[hf$group == group] <- predict(model, test)
  train$prediction <- predict(model, train)
}
pr <- ROCR::prediction(train$prediction, train$target)
prf <- performance(pr, measure = "tpr", x.measure = "fpr")
plot(prf, main = "Training ROC curve")
auc <- performance(pr, measure = "auc")
auc <- auc@y.values[[1]]
print(paste("Training ROC AUC: ",auc))
pr <- ROCR::prediction(hf$prediction, hf$target)
prf <- performance(pr, measure = "tpr", x.measure = "fpr")
plot(prf, main = "Test ROC curve")
auc <- performance(pr, measure = "auc")
auc <- auc@y.values[[1]]
print(paste("Test ROC AUC: ", auc))
```

## PCA

The first two columns of the plot are PC1 and PC2 which is the most important. It is new varialbe that is a linear combination of the other variables.

```{u, echo=TRUE}
hf.pca <- prcomp(hf)
hf.rotated <- as.data.frame(hf.pca$x)
hf.vectors <- as.data.frame(hf.pca$rotation)

barplot(hf.pca$sdev, xlab = "PC1-PC14")
```


##performance and analysis
The first machine learning algorithm that was used was logistical regression. The reason for this is because that this type of regression is great for classification. The goal for this data set was to classify whether or not someone had heart disease. Yes would be 1, and No would be 0 in the target column in the heart data set. Since the logistical regression algorithm uses the sigmoid equation from 0-1 in the y axis, respones variable, it would be best for finding our answer of whether or not someone has heart disease. The second option for a machine learning algoithm is SVM. SVM is also a great classifier algorithm. For the SVM model, it finds the best separating hyperplane from the types of point (1’s and 0’s). These hyperplanes can vary depending on the kernel type. In this case, the sigmoid kernel was used since the answer is either 1 or 0. This created a model that was not too over fit or too under fit. Other functions included in kernel are polynomial, linear, and radical basis. The decision tree algorithm was the third machine learning model used for this data set. Using the randomforest model was better than trees because it prevented a large amout of overfitting. This is because of the bagging process which uses not one but multiple trees. Though, this model did overfit a little, it still provided a profficient ROC AUC. The best model out of the three was the SVM model. It provided a ROC AUC of 0.881379 with a training model ROC AUC of 0.8981124. This modle was not too under fit or too over fit, so this is a great model for this data set. 























#Stuff I'm not using for now at least
# summary(hdf[hdf$km==1,])
# summary(hdf[hdf$km==2,])


#I think meanshift is garbage but here it is just in case
#require(meanShiftR)
#meanShift <- meanShift(as.matrix(hdf[,c(1,5)]))
#hdf$ms <- meanShift$assignment
#plot(hdf$age, hdf$chol, col=hdf$ms)