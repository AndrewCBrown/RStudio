#Statistical inference assignment by Andrew Brown 2/21/2019

data(chickwts)

t.test(weight ~ feed, chickwts[chickwts$feed %in% c("linseed", "sunflower"),], paired=FALSE, var.equal=TRUE)
#First argument is the first column you want to compare by the second column you want to prepare

#Second argument is the dataframe that your columns come from. But in this case it is specified
#to be just the feed column in the vector containing 2 of the values from the column that has 6 values in it.

#Third argument is paried=FALSE because we already know that this data was not paired. Meaning that
#The feed was given to different chicks, rather than the same chick trying out the different foods.
#So because maybe some chicks could be genetically fatter by default, than we can't be as sure of our assumption
#Therefore we say that paired=FALSE so that our t.test doesn't give quite as strong of a correlation.

#Fourth argument is variable equal if false it would be a larger p value by A LITTLE bit. It has something to do
#with the data being spread out or something is what the prof said.

