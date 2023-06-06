#Statistical Inference assignment by Andrew Brown

#Question 1.
#t.test(weight ~ feed, chickwts[chickwts$feed %in% c("horsebean", "sunflower"),], paired=FALSE, var.equal=TRUE)
#From this line I found a p-value of .00000002374, which means that, statistically speaking, chicks fed sunflower weigh more than chicks fed horsebean.

#Question 2.
#airquality$Month8<-airquality$Month==8
#t.test(Temp~Month8, data=airquality)
#The 8th month is hotter than all the others, p-value of .000001967

#Question 3.
#Average Number of Insects after using each spray
#A: 14.5
#B: 15.33
#C: 2.08
#D: 4.92
#E: 3.5
#F: 16.67
#t.test(count ~ spray, InsectSprays[InsectSprays$spray %in% c("C", "F"),], paired=FALSE, var.equal=TRUE)
#Spray C is more effective at eliminating bugs than spray F, p-value of .00000009992

#t.test(count ~ spray, InsectSprays[InsectSprays$spray %in% c("E", "B"),], paired=FALSE, var.equal=TRUE)
#Spray E is more effective at eliminating bugs than spray B, p-value of .000000009737

#InsectSprays$sprayC<-InsectSprays$spray=="C"
#t.test(count~sprayC, data=InsectSprays)
#Spray C is more effective at eliminating bugs than all the other sprays, p-value of .000000000008933

#Question 4.
# v1<-c(as.data.frame(Titanic)$Freq[17:32])
# df<-as.data.frame(Titanic)[1:16,]
# df$Survived<-v1
# colnames(df)[5]<-"Died"
# df$S_Rate<-c(df$Survived/(df$Survived+df$Died))
# df<-df[-4,]
# df<-df[-7,]
# df<-df[,-4]
# df<-df[,-4]
#mean(df$S_Rate[df$Sex=="Female"]) #.8020316
#mean(df$S_Rate[df$Sex=="Male"])   #.4378509
#t.test(S_Rate ~ Sex, df[df$Sex %in% c("Male", "Female"),], paired=FALSE, var.equal=TRUE)
#Females have a greater chance to survive than Males, p-value of .05856
#Because the p-value is BARELY above .05, it's technically not a statistically significant statement.

#mean(df$S_Rate[df$Class=="1st"])  #.8244841
#mean(df$S_Rate[df$Class=="Crew"]) #.5461515
#t.test(S_Rate ~ Class, df[df$Class %in% c("1st", "Crew"),], paired=FALSE, var.equal=TRUE)
#1st Class passengers have a better chance to survive than Crew members, p-value of .4317
#Becuase of such a high p-value, this statement is not statistically significant

#mean(df$S_Rate[df$Age=="Child"]) #.7870744
#mean(df$S_Rate[df$Age=="Adult"]) #.4945915
#t.test(S_Rate ~ Age, df[df$Age %in% c("Child", "Adult"),], paired=FALSE, var.equal=TRUE)
#Children have a greater chance to survive than adults, p-value of .1447
#Because the p-value is above .05 this is not strongly statistically significant