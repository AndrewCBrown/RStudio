#Rain in Australia Neural Net model by Andrew Brown 4/27/2019
#Pulled from kaggle competition: is it going to rain tomorrow in Australia?

#Don't use date, could cause overfitting
#Switch rain today column to be 1 and 0 because it is yes and no originally
#Don't use RISK_MM

require(ROCR)
require(stringr)
require(neuralnet)

set.seed(314159270)

df <- read.csv("weatherAUS.csv")

df <- df[complete.cases(df),]

df <- df[1:1000,]

#Switching rain column to be 1 and 0
df$RainToday <- as.numeric(df$RainToday == "Yes")
df$RainTomorrow <- as.numeric(df$RainTomorrow == "Yes")

df$group <- sample(1:5, nrow(df), replace=TRUE)

modeling_variables <- c("Sunshine", "Humidity3pm", "Evaporation")

for (group in 1:5)
{
  train <- df[df$group != group, c(modeling_variables, "RainTomorrow")]
  test <- df[df$group == group, modeling_variables]
  
  model <- neuralnet(RainTomorrow ~ ., train, hidden = 1, threshold = .001)
  
  df$prediction[df$group == group] <- compute(model, test)$net.result
  train$prediction <- compute(model, train)$net.result
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