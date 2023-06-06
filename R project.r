#R Data Science project by Andrew Brown March 2019

#Read in csv file
crime <- read.csv("table-2.csv")
#Remove useless row on bottom
crime <- crime[-c(133),]
#Rename columns appropriately
names(crime) <- c("Region", "Year", "Population", "Violent Crime", "Violent Crime per 100k people", "Murder and nonnegligent manslaughter", "Murder and nonnegligent manslaughter per 100k people", "Rape revised definition", "Rape revised definition per 100k people", "Rape legacy definition", "Rape legacy definition per 100k people", "Robbery", "Robbery per 100k people", "Aggravated assault", "Aggravated assault per 100k people", "Property crime", "Property crime per 100k people", "Burglary", "Burglary per 100k people", "Larceny theft", "Larceny theft per 100k people", "Motor vehicle theft", "Motor vehicle theft per 100k people")
#Copy the row names so they each match for years 2015 and 2016
crime[seq(2,132,2),]$Region <- crime[seq(1,131,2),]$Region

#This next block of code cerates 10 sub-sets of the main data frame in order to make it easier to view certain parts at a time
#Creates a data frame with only the 2015 crime data
crime_2015 <- crime[seq(1,131,2),]
#Creates a data frame with only the 2016 crime data
crime_2016 <- crime[seq(2,132,2),]
#Creates a data fram with only the states crime data (Plus Puerto Rico and D.C.)
crime_states <- crime[-c(1,2,3,4,5,6,19,20,27,28,29,30,41,42,57,58,59,60,79,80,89,90,99,100,101,102,119,120),]
#Creates a data fram with only the larger regions crime data
crime_regions <- crime[c(1,2,3,4,5,6,19,20,27,28,29,30,41,42,57,58,59,60,79,80,89,90,99,100,101,102,119,120),]
#Creates separate data frames for the two years for both the states data frame and the regions one
crime_states_2015 <- crime_states[seq(1,103,2),]
crime_states_2016 <- crime_states[seq(2,104,2),]
crime_regions_2015 <- crime_regions[seq(1,27,2),]
crime_regions_2016 <- crime_regions[seq(2,28,2),]
#Creates a data frame called combined_crime_2015 that lists the 10 different crime rates for each state in 2015
combined_crime_2015 <- crime_states_2015[,-c(2,3,4,6,8,10,12,14,16,18,20,22)]
rownames(combined_crime_2015) <- combined_crime_2015$Region
combined_crime_2015 <- combined_crime_2015[,2:11]
#Creates a data frame called combined_crime_2016 that lists the 10 different crime rates for each state in 2016
combined_crime_2016 <- crime_states_2016[,-c(2,3,4,6,8,10,12,14,16,18,20,22)]
rownames(combined_crime_2016) <- combined_crime_2016$Region
combined_crime_2016 <- combined_crime_2016[,2:11]


#Bar graph comparing the different types of crime by how many times each has been committed
#GRAPH 1
barplot(t(c(crime[1,seq(4,23,2)]+crime[2,seq(4,23,2)])))
#Download as width=2536 and height=1700


#Plot for Alaska having the highest rape rate by a lot compared to other states
#GRAPH 2
barplot(crime_states_2016$`Rape revised definition per 100k people`, col="orange")


#Process of creating the data frame to be used to compare the two years
#First part for 2015
crime_total_2015 <- rbind(combined_crime_2015, c(sum(combined_crime_2015$`Violent Crime per 100k people`), sum(combined_crime_2015$`Murder and nonnegligent manslaughter per 100k people`), sum(combined_crime_2015$`Rape revised definition per 100k people`), sum(combined_crime_2015$`Rape legacy definition per 100k people`), sum(combined_crime_2015$`Robbery per 100k people`), sum(combined_crime_2015$`Aggravated assault per 100k people`), sum(combined_crime_2015$`Property crime per 100k people`), sum(combined_crime_2015$`Burglary per 100k people`), sum(combined_crime_2015$`Larceny theft per 100k people`), sum(combined_crime_2015$`Motor vehicle theft per 100k people`)))
rownames(crime_total_2015)[53] <- "2015 totals"
crime_total_2015<- crime_total_2015[53,1:10]
#Second part for 2016
crime_total_2016 <- rbind(combined_crime_2016, c(sum(combined_crime_2016$`Violent Crime per 100k people`), sum(combined_crime_2016$`Murder and nonnegligent manslaughter per 100k people`), sum(combined_crime_2016$`Rape revised definition per 100k people`), sum(combined_crime_2016$`Rape legacy definition per 100k people`), sum(combined_crime_2016$`Robbery per 100k people`), sum(combined_crime_2016$`Aggravated assault per 100k people`), sum(combined_crime_2016$`Property crime per 100k people`), sum(combined_crime_2016$`Burglary per 100k people`), sum(combined_crime_2016$`Larceny theft per 100k people`), sum(combined_crime_2016$`Motor vehicle theft per 100k people`)))
rownames(crime_total_2016)[53] <- "2016 totals"
crime_total_2016 <- crime_total_2016[53,1:10]
#Putting the parts together
crime_total <- rbind(crime_total_2015, crime_total_2016)
#GRAPH 3 & 4 now the same because of par
par(mfrow=c(1,2))
barplot(t(crime_total[1,]), col="red", beside=TRUE)
barplot(t(crime_total[2,]), col="blue", beside=TRUE)


#Bar graph of the combined crime rates for 2016 by state
#GRAPH HERE 5
par(mfrow=c(1,1))
barplot(t(combined_crime_2016))


#This block creates the 'pairs plot' for burglary to show that it doesn't really corrolate to other types of crime
#GRAPH 6
par(mfrow=c(3,3))
plot(combined_crime_2016[,8], combined_crime_2016[,1], main="Burglary by Violent Crime")
plot(combined_crime_2016[,8], combined_crime_2016[,2], main="Burglary by Murder")
plot(combined_crime_2016[,8], combined_crime_2016[,3], main="Burglary by Rape (RD)")
plot(combined_crime_2016[,8], combined_crime_2016[,4], main="Burglary by Rape (LD)")
plot(combined_crime_2016[,8], combined_crime_2016[,5], main="Burglary by Robbery")
plot(combined_crime_2016[,8], combined_crime_2016[,6], main="Burglary by Aggravated Assault")
plot(combined_crime_2016[,8], combined_crime_2016[,7], main="Burglary by Property Crime")
plot(combined_crime_2016[,8], combined_crime_2016[,9], main="Burglary by Larceny Theft")
plot(combined_crime_2016[,8], combined_crime_2016[,10], main="Burglary by Motor Vehicle Theft")


#Graph for aggravated assault vs violent crime becuase they have the strongest correlation among the crime types as found using a pairs plot
#GRAPH 7
par(mfrow=c(1,1))
plot(combined_crime_2016$`Aggravated assault per 100k people`, combined_crime_2016$`Violent Crime per 100k people`)


#This gives the p-value for the correlation of aggravated assault and violent crime
t.test(combined_crime_2016$`Aggravated assault per 100k people`, combined_crime_2016$`Violent Crime per 100k people`)




#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#CODE I DID NOT END UP NEEDING BELOW HERE
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#This creates a new column in combined_crime_2016 with the total of the crime rates for each state
#combined_crime_2016$Total <- combined_crime_2016$`Violent Crime per 100k people` + combined_crime_2016$`Murder and nonnegligent manslaughter per 100k people` + combined_crime_2016$`Rape revised definition per 100k people` + combined_crime_2016$`Rape legacy definition per 100k people` + combined_crime_2016$`Robbery per 100k people` + combined_crime_2016$`Aggravated assault per 100k people` + combined_crime_2016$`Property crime per 100k people` + combined_crime_2016$`Burglary per 100k people` + combined_crime_2016$`Larceny theft per 100k people` + combined_crime_2016$`Motor vehicle theft per 100k people`
#This creates a new column in combined_crime_2015 with the total of the crime rates for each state
#combined_crime_2015$Total <- combined_crime_2015$`Violent Crime per 100k people` + combined_crime_2015$`Murder and nonnegligent manslaughter per 100k people` + combined_crime_2015$`Rape revised definition per 100k people` + combined_crime_2015$`Rape legacy definition per 100k people` + combined_crime_2015$`Robbery per 100k people` + combined_crime_2015$`Aggravated assault per 100k people` + combined_crime_2015$`Property crime per 100k people` + combined_crime_2015$`Burglary per 100k people` + combined_crime_2015$`Larceny theft per 100k people` + combined_crime_2015$`Motor vehicle theft per 100k people`

#Idk why this line is here
#cime_total <- rbind( crime_2015, crime_2016)see if crime increased from 2015 to 2016, it looks like it really didn't

#These are just calculations I used in EDA
#colSums(crime_2015[,seq(5,23,2)])/66
#colSums(crime_2016[,seq(5,23,2)])/66

#Never figured this out but would still like to know
#I need to do this but one row at a time? For my 2nd interesting thing
#sum(crime_states_2016[,seq(4,23,2)])
#Because after i do that i can barplot it all and see which state has the highest overall crime rate and stuff (which i think is DC)