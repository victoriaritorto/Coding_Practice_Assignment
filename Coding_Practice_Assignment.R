library(countrycode)
library(stargazer)
library(httr)

#Importing data
setwd("/Users/victoriaritorto/Documents/SODA496")
PopularVote <- read.csv("popularvote.csv")
worldbank = read.csv("inflation.csv")


#Clean
pv = PopularVote[c("Year", "DemPctVotes", "RepPctVotes", "DirectionVotesChange", "DemSeatsAndVotesDifference")]
pv = pv[pv$Year >= 2000,]

#Clean
wb = worldbank
wb$Series.Name = NULL
wb$Series.Code = NULL
wb$Time.Code = NULL
colnames(wb)[1] = "Year"
colnames(wb)[2] = "USInflationRate"
wb = na.omit(wb)


#Visualize
hist(pv$DemSeatsAndVotesDifference)

hist(wb$USInflationRate)
class(wb$USInflationRate)
as.numeric(wb$USInflationRate)

hist(wb$USInflationRate[wb$Year > 2010])


