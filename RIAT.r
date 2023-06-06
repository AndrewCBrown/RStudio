#Rain in Australia Decision Tree Model by Andrew Brown 4/28/2019
#Pulled from kaggle competition: is it going to rain tomorrow in Australia?

#Don't use date, could cause overfitting
#Switch rain today column to be 1 and 0 because it is yes and no originally
#Don't use RISK_MM

require(ROCR)
require(stringr)
require(gbm)

set.seed(314159265)

df <- read.csv("weatherAUS.csv")

df <- df[complete.cases(df),]

df <- df[1:400,]

#Switching rain column to be 1 and 0
df$RainToday <- as.integer(df$RainToday == "Yes")
df$RainTomorrow <- as.integer(df$RainTomorrow == "Yes")

df$group <- sample(1:5, nrow(df), replace=TRUE)

modeling_variables <- c("Humidity3pm", "MinTemp", "Sunshine", "WindSpeed9am", "Pressure3pm", "Rainfall", "Pressure9am")

for (group in 1:5)
{
  train <- df[df$group != group, c(modeling_variables, "RainTomorrow")]
  test <- df[df$group == group, modeling_variables]

  model <- gbm(RainTomorrow ~ ., train, distribution = "gaussian", n.trees = 100, shrinkage = .1, interaction.depth = 2)
  
  df$prediction[df$group == group] <- predict(model, test, n.trees = 100)
  train$prediction <- predict(model, train, n.trees = 10)
}



pr <- ROCR::prediction(df$prediction, df$RainTomorrow)
prf <- performance(pr, measure = "tpr", x.measure = "fpr")
plot(prf)
auc <- performance(pr, measure = "auc")
auc <- auc@y.values[[1]]                                                                                                                  
print(auc)

pr <- ROCR::prediction(train$prediction, train$RainTomorrow)
prf <- performance(pr, measure = "tpr", x.measure = "fpr")
plot(prf)
auc <- performance(pr, measure = "auc")
auc <- auc@y.values[[1]]                                                                                                                  
print(auc)