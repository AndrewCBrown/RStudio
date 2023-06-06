set.seed(314159265)
modeling_list <- c("MinTemp", "MaxTemp", "Rainfall", "Evaporation", "Sunshine", "WindGustSpeed", "WindSpeed9am", "WindSpeed3pm", "Humidity9am", "Humidity3pm","Pressure9am", "Pressure3pm", "Cloud9am", "Cloud3pm", "Temp9am", "Temp3pm", "RainToday")
best_auc <- 0
best_model <- c()


for (loop in 1:100000)
{

rand_vector <- sample(1:17, 7, replace=FALSE)
i <- rand_vector[1]
j <- rand_vector[2]
k <- rand_vector[3]
l <- rand_vector[4]
m <- rand_vector[5]
n <- rand_vector[6]
o <- rand_vector[7]
# p <- rand_vector[8]
# q <- rand_vector[9]
# r <- rand_vector[10]
# s <- rand_vector[11]
# t <- rand_vector[12]

modeling_variables <- c(modeling_list[i], modeling_list[j], modeling_list[k], modeling_list[l], modeling_list[m], modeling_list[n], modeling_list[o])#, modeling_list[p], modeling_list[q], modeling_list[r], modeling_list[s], modeling_list[t])

for (group in 1:5)
{
  train <- df[df$group != group, c(modeling_variables, "RainTomorrow")]
  test <- df[df$group == group, modeling_variables]
  model <- gbm(RainTomorrow ~ ., train, distribution = "gaussian", n.trees = 75, shrinkage = .1, interaction.depth = 2)
  df$prediction[df$group == group] <- predict(model, test, n.trees = 75)
  train$prediction <- predict(model, train, n.trees = 75)
}
pr <- ROCR::prediction(df$prediction, df$RainTomorrow)
auc <- performance(pr, measure = "auc")
auc <- auc@y.values[[1]]                                                                                                                  

if(auc > best_auc)
{best_auc <- auc
best_model <- modeling_variables
print(auc)}
}