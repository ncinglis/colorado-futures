setwd("C:/ncstate/FUTURES/colorado/rawdata")
d<-read.csv("population.csv", stringsAsFactors = F)
library(data.table)
summary(d)
names(d)
names(d)[1] <- "county"
d<-as.data.table(d)
summary(d)
d2<-d[(fipsCode == 13 | fipsCode == 69) & dataType == "Forecast", 
      .(population = sum(totalPopulation)), by = .(fipsCode, year)]

d3<-reshape(d2, idvar = "year", timevar = "fipsCode", direction = "wide")
d3<-d3[order(year)]
d3<-as.data.frame(d3)
names(d3) <- c("year", "13", "69")

write.csv(d3, file = "C:/ncstate/FUTURES/colorado/data/population_projection.csv", row.names = F)


#trend - 1992, 2001, 2006, 2011
d4<-d[(fipsCode == 13 | fipsCode == 69) & dataType == "Estimate" & (year == 1992 | year == 2001 | year == 2006 | year == 2011), 
      .(population = sum(totalPopulation)), by = .(fipsCode, year)]

d5<-reshape(d4, idvar = "year", timevar = "fipsCode", direction = "wide")
d5<-d5[order(year)]
d5<-as.data.frame(d5)
names(d5) <- c("year", "13", "69")
d5

write.csv(d5, file = "C:/ncstate/FUTURES/colorado/data/population_trend.csv", row.names = F)
