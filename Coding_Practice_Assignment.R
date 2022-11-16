library(countrycode)
library(stargazer)
library(httr)

#Importing data
setwd("/Users/victoriaritorto/Documents/SODA496")
PopularVote <- read.csv("popularvote.csv")
worldbank = read.csv("inflation.csv")


#Clean (pv stands for popular vote, I got the data from Vital Statistics on Congress)
pv = PopularVote[c("Year", "DemPctVotes", "RepPctVotes", "DirectionVotesChange", "DemSeatsAndVotesDifference")]
colnames(pv)[2] = "DemPercentageVotes"
colnames(pv)[3] = "RepPercentageVotes"
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

#Merge
df = merge(pv, wb, by.x = c("Year"), by.y = c("Year"))

#Scatter plot
plot(df$DemSeatsAndVotesDifference, df$USInflationRate)

#Regression model
m1 = lm(USInflationRate ~ poly(DemSeatsAndVotesDifference,2), data = df)
summary(m1)

#Output Regression
stargazer(m1, type = "html", out = "model.html",
          covariate.labels = c("DemSeatsAndVotesDifference","DemSeatsAndVotesDifference\\^2", NA),
          dep.var.labels = c("USInflationRate"),
          omit.stat = c("ser", "f","adj.rsq"))
BROWSE("model.html")


