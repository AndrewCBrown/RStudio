#Plotting asignment by Andrew Brown 2/5/2019

data(USJudgeRatings)
pairs(USJudgeRatings) #Creates multiple scatter plots, one for each combination of variables
plot(USJudgeRatings$ORAL,USJudgeRatings$RTEN) #Creates a scatter plot of the variable most correlated with RTEN

data(mtcars)
boxplot(mtcars$disp ~ mtcars$cyl) #Creates a boxplot of displacement, separated by number of cylinders
boxplot(mtcars$mpg ~ mtcars$cyl) #Creates a boxplot of mpg, separated by number of cylinders

data(WorldPhones)
barplot(t(WorldPhones))#Creates a barplot of WorldPhones but it is transposed
barplot(t(WorldPhones), beside=TRUE) #Creates the same bar plot as above, but rather than stacking the countries on top of eachother they are beside eachother

#Assignment for the titanic set:
#Create the best plot you can to answer the following question:
#What factors increase your likelihood to survive?
#Is a particular group most likely to survive?
data(Titanic)
#These next 5 lines of code simply reshape the data frame to make graphing easier
v1<-c(as.data.frame(Titanic)$Freq[17:32])#Create a vector with the numbers of those who survived
df<-as.data.frame(Titanic)[1:16,]#Chop off the bottom half of the Titanic dataset
df$Survived<-v1 #Modify the survived column to have the number values rather than yes or no
colnames(df)[5]<-"Died" #Rename the last column appropriately
df$S_Rate<-c(df$Survived/(df$Survived+df$Died)) #Create a column that has the survival rate for that group
#Next two lines remove NaN valuesbecause there were no children on the crew
df<-df[-4,]
df<-df[-7,]
#Next two lines remove the survived and died columns so we are left with only the survival rate
df<-df[,-4]
df<-df[,-4]
#Now we create the barplot with height=df$S_Rate, meaning our y-axis will be the survival rate from 0 to 1
#The second argument sets the y-axis's label to "Survival Rate"
#The third argument labels each of the 14 bars respective to its class, gender, and age (the paste function is needed to concatenate the strings into one string)
barplot(df$S_Rate, ylab="Survival Rate", names.arg=paste(df$Class,"Class","\n",df$Sex,"\n",df$Age))