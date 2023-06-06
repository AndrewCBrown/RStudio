#Correlation program by Andrew Brown 1/22/2019
#Assignment is to combine all data from 4 data sets into one table to find correlation between sunspots and various deaths.
data(sunspots)#Dataset with the mean of the sunspots in a month, for each month from 1749-1983.
data(UKLungDeaths)#Contains 3 data sets: all measure deaths from Lung Diseases in the UK from 1974-1979. ldeaths is total, while mdeaths and fdeaths are male and female only respectively.
data(UKDriverDeaths)#Dataset with number of UK Driver deaths per month from 1969-1984.
data(USAccDeaths)#Dataset with number of accidental deaths per month in the USA from 1973-1978.
#Goal is to create a dataset by months from Jan. 1974 - Dec. 1978. Rows will be the different months
#Columns will be sun spots, ldeaths, mdeaths, fdeaths, ukdriverdeaths, accidentalUSdeaths, and total deaths

#Get data frame of sunspots with appropriate dates.
sunspots74_8<-data.frame(sunspots)[2701:2760,]
sunspots74_8<-data.frame(sunspots74_8)

#Get data frame of ldeaths with appropriate dates.
ldeaths74_8<-data.frame(ldeaths)[1:60,]
ldeaths74_8<-data.frame(ldeaths74_8)

#Get data frame of mdeaths with appropriate dates.
mdeaths74_8<-data.frame(mdeaths)[1:60,]
mdeaths74_8<-data.frame(mdeaths74_8)

#Get data frame of fdeaths with appropriate dates.
fdeaths74_8<-data.frame(fdeaths)[1:60,]
fdeaths74_8<-data.frame(fdeaths74_8)

#Get data frame of UKDriverDeaths with appropriate dates.
UKDriverDeaths74_8<-data.frame(UKDriverDeaths)[61:120,]
UKDriverDeaths74_8<-data.frame(UKDriverDeaths74_8)

#Get data frame of USAccDeaths with appropriate dates.
USAccDeaths74_8<-data.frame(USAccDeaths)[13:72,]
USAccDeaths74_8<-data.frame(USAccDeaths74_8)

correlationDF<-cbind(sunspots74_8,ldeaths74_8,mdeaths74_8,fdeaths74_8,UKDriverDeaths74_8,USAccDeaths74_8)
correlationDF$totals<-correlationDF[,2]+correlationDF[,5]+correlationDF[,6]

View(correlationDF)
plot(correlationDF$sunspots74_8,correlationDF$totals)

#How many rows and columns does the final dataset have?
#60 rows and 7 columns.
#What type of join(s) did you use?
#I used inner joins so that I could look at the relationship between deaths and sunspots in all
#the years common among the data sets.
#Are there any areas of your data which need to be imputed? Why?
#No, because I used only years which had no missing data.

#New stuff now 1/30/2019
#time(fdeaths) returns a vector with the year and month. ie. 1999 March would be 1999.250
#except now do as.numeric(time(fdeaths))
#still doesn't work cause 1974!=1974
#Can only merge 2 at time.
#merge function: merge(fdeaths, sunspots, all=TRUE, by="time")