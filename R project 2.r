#R Data Science project by Andrew Brown April 2019

#Read in csv file
crime <- read.csv("table-2.csv")
#Remove useless row on bottom
crime <- crime[-c(133),]
#Rename columns appropriately
names(crime) <- c("Region", "Year", "Population", "Violent Crime", "Violent_Crime_per_100k_people", "Murder and nonnegligent manslaughter", "Murder_and_nonnegligent_manslaughter_per_100k_people", "Rape revised definition", "Rape_revised_definition_per_100k_people", "Rape legacy definition", "Rape_legacy_definition_per_100k_people", "Robbery", "Robbery_per_100k_people", "Aggravated assault", "Aggravated_assault_per_100k_people", "Property crime", "Property_crime_per_100k_people", "Burglary", "Burglary_per_100k_people", "Larceny theft", "Larceny_theft_per_100k_people", "Motor vehicle theft", "Motor_vehicle_theft_per_100k_people")
#Copy the row names so they each match for years 2015 and 2016
crime[seq(2,132,2),]$Region <- crime[seq(1,131,2),]$Region

#Creates a data frame with only the states crime rates data plus their population (Plus Puerto Rico and D.C.)
crime_states <- crime[-c(1,2,3,4,5,6,19,20,27,28,29,30,41,42,57,58,59,60,79,80,89,90,99,100,101,102,119,120),]
crime_states <- crime_states[,c(1,2,3,5,7,9,11,13,15,17,19,21,23)]

require(ROCR)
require(stringr)
require(e1071)
require(tree)
set.seed(314159265)

#Creating the target column that we will try to predict
crime_states$Target <- as.integer(crime_states$`Motor_vehicle_theft_per_100k_people` > mean(crime_states$`Motor_vehicle_theft_per_100k_people`))

#Dividing the data into sets
crime_states$Group <- sample(1:5, nrow(crime_states), replace=TRUE)







#GLM model
modeling_variables <- c("Rape_legacy_definition_per_100k_people", "Larceny_theft_per_100k_people")

for (group in 1:5)
{
  train <- crime_states[crime_states$Group != group, c(modeling_variables, "Target")]
  test <- crime_states[crime_states$Group == group, modeling_variables]
  
  model <- glm(Target ~ ., train, family=binomial(link='logit'))
  
  crime_states$prediction[crime_states$Group == group] <- predict(model, test, type='response')
  train$prediction <- predict(model, train)
}

pr <- ROCR::prediction(crime_states$prediction, crime_states$Target)
prf <- performance(pr, measure = "tpr", x.measure = "fpr")
plot(prf)
auc <- performance(pr, measure = "auc")
auc <- auc@y.values[[1]]
print(auc)


pr <- ROCR::prediction(train$prediction, train$Target)
prf <- performance(pr, measure = "tpr", x.measure = "fpr")
plot(prf)
auc <- performance(pr, measure = "auc")
auc <- auc@y.values[[1]]
print(auc)







#SVM Model
modeling_variables <- c("Population", "Violent_Crime_per_100k_people", "Murder_and_nonnegligent_manslaughter_per_100k_people", "Rape_legacy_definition_per_100k_people", "Aggravated_assault_per_100k_people", "Burglary_per_100k_people", "Larceny_theft_per_100k_people")

for (group in 1:5)
{
  train <- crime_states[crime_states$Group != group, c(modeling_variables, "Target")]
  test <- crime_states[crime_states$Group == group, modeling_variables]
  
  model <- svm(Target ~ ., train, cost=10, tolerance =.00001)
  
  crime_states$prediction[crime_states$Group == group] <- predict(model, test, type='response')
  train$prediction <- predict(model, train)
}

pr <- ROCR::prediction(crime_states$prediction, crime_states$Target)
prf <- performance(pr, measure = "tpr", x.measure = "fpr")
plot(prf)
auc <- performance(pr, measure = "auc")
auc <- auc@y.values[[1]]
print(auc)


pr <- ROCR::prediction(train$prediction, train$Target)
prf <- performance(pr, measure = "tpr", x.measure = "fpr")
plot(prf)
auc <- performance(pr, measure = "auc")
auc <- auc@y.values[[1]]
print(auc)







#Tree model
modeling_variables <- c("Violent_Crime_per_100k_people", "Larceny_theft_per_100k_people")

for (group in 1:5)
{
  train <- crime_states[crime_states$Group != group, c(modeling_variables, "Target")]
  test <- crime_states[crime_states$Group == group, modeling_variables]
  
  model <- tree(Target ~ ., train)
  
  crime_states$prediction[crime_states$Group == group] <- predict(model, test)
  train$prediction <- predict(model, train)
}

pr <- ROCR::prediction(crime_states$prediction, crime_states$Target)
prf <- performance(pr, measure = "tpr", x.measure = "fpr")
plot(prf)
auc <- performance(pr, measure = "auc")
auc <- auc@y.values[[1]]
print(auc)


pr <- ROCR::prediction(train$prediction, train$Target)
prf <- performance(pr, measure = "tpr", x.measure = "fpr")
plot(prf)
auc <- performance(pr, measure = "auc")
auc <- auc@y.values[[1]]
print(auc)