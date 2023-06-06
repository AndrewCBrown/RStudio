#Beaver program from Josiah Lovin, edited by Andrew Brown 1/31/2019

library(reshape2) #Allow use of functions: melt, dcast, and acast.
data(beavers) #Load data frames: beaver1 and beaver2.

beaver1$beaver_id<-"Tom" #Add a column to beaver1 with the beaver's name.
beaver2$beaver_id<-"Joe" #Add a column to beaver2 with the beaver's name.

combined_df<-rbind(beaver1,beaver2) #Add the rows of beaver2 to the bottom of beaver1.

#Changing the data to long form.
beaver_df1<-dcast(combined_df, beaver_id + day + activ ~ time, value.var="temp")
#First argument is the data frame being worked on.
#Second argument is the columns you wish to keep added together, by the column you want to turn into a bunch of columns.
#Third argument is the column you want to just turn into values that will go under your new columns.

View(beaver_df1)