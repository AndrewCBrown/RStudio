#Rain in Australia R assignment by Andrew Brown 3/26/2019
#Pulled from kaggle competition: is it going to rain tomorrow in Australia?
#Machine learning model that can be adjusted with other data as well in the future

#Install the package ROCR and stringr

#Switch rain today column to be 1 and 0 because it is yes and no originally
#Don't use RISK_MM

require(ROCR)
require(stringr)
set.seed(314159265)

df <- read.csv("weatherAUS.csv")

#Switching rain column to be 1 and 0
df$RainToday <- as.integer(df$RainToday == "Yes")
df$RainTomorrow <- as.integer(df$RainTomorrow == "Yes")

df$Month <- str_split_fixed(as.character(df$Date), "-", 3)[,2]

df$WindGustDirNum<-0
df$WindGustDirNum[df$WindGustDir=="N"]<-1
df$WindGustDirNum[df$WindGustDir=="NNE"]<-2
df$WindGustDirNum[df$WindGustDir=="NE"]<-3
df$WindGustDirNum[df$WindGustDir=="ENE"]<-4
df$WindGustDirNum[df$WindGustDir=="E"]<-5
df$WindGustDirNum[df$WindGustDir=="ESE"]<-6
df$WindGustDirNum[df$WindGustDir=="SE"]<-7
df$WindGustDirNum[df$WindGustDir=="SSE"]<-8
df$WindGustDirNum[df$WindGustDir=="S"]<-9
df$WindGustDirNum[df$WindGustDir=="SSW"]<-10
df$WindGustDirNum[df$WindGustDir=="SW"]<-11
df$WindGustDirNum[df$WindGustDir=="WSW"]<-12
df$WindGustDirNum[df$WindGustDir=="W"]<-13
df$WindGustDirNum[df$WindGustDir=="WNW"]<-14
df$WindGustDirNum[df$WindGustDir=="NW"]<-15
df$WindGustDirNum[df$WindGustDir=="NNW"]<-16


df$group <- sample(1:5, nrow(df), replace=TRUE)

modeling_variables <- c("MinTemp", "Rainfall", "WindGustSpeed", "WindSpeed9am", "WindSpeed3pm", "Humidity9am", "Humidity3pm","Pressure9am", "Pressure3pm", "Temp9am", "RainToday", "Month", "WindGustDirNum")

for (group in 1:5)
{
  train <- df[df$group != group, c(modeling_variables, "RainTomorrow")]
  test <- df[df$group == group, modeling_variables]
  
  model <- glm(RainTomorrow ~ ., train, family=binomial(link='logit'))
  
  df$prediction[df$group == group] <- predict(model, test, type='response')
  train$prediction <- predict(model, train)
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