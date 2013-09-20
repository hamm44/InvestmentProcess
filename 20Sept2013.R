# Analysis of Stock Purchase on 20 Sept 2013
# Purchased wnc, ebix, tga, meru, pkx  on 20th Sept 2013
library(fPortfolio)
library(timeSeries)
library(PerformanceAnalytics)
options(scipen=999, digits=4)


# Find the stock codes using the quandlSearch.R function
stocks <- c("EBIX", "WNC", "TGA", "MERU", "PKX") # list the codes you want to search, and find codes for
startDate <-"2012-01-01"
endDate <- "2013-09-20" 
trans <- NULL #rdiff, diff, cumul, normalize, null
collapse <- NULL #"weekly","monthly","quarterly","annual"

# Load the quandlSearch.R function
source("quandlSearch.R")

#Use loaded file to find the codes, then return data as price index
codes <- stockCodes(stocks) # returns the codes to return 4th column in the R API
codes   # after seeing that there is FRA pkx, i remove this column

prices <- stockData(codes, startDate, endDate, trans)
names(prices) <- stocks          # rename the columns

ret.ewtmp <- stockData(codes, "2010-01-01", endDate, trans="rdiff")
names(ret.ewtmp) <- stocks

head(prices)
head(ret.ewtmp)

# Plot the returns as time series
prices.ts <- as.timeSeries(prices)
ret.ts <- as.timeSeries(ret.ewtmp)

class(prices.ts)
plot(prices.ts, main="Stocks Purchased on 20th September")
charts.PerformanceSummary(ret.ts, color=rich6equal)

table.Stats(ret.ts)  #performance analytics package
# Do some monthly and quarterly performance aggregating
# functions:
  # timeLastDayInMonth(charvec)
  # timeLastDayInQuarter(charvec)

byMonth <- unique(timeLastDayInMonth(rownames(ret.ts)))  #returns only one end of month values(sometimes repeats)
byQtr <- unique(timeLastDayInQuarter(rownames(ret.ts)))
byMonth
byQtr

monthlyReturns <- aggregate(ret.ts*100, by=byMonth, FUN=mean) # returns the data in % returns
    # this function works only if ret.ts is in timeSeries format
monthlyReturns
summary(monthlyReturns)
qtr.AvRet <- aggregate(ret.ts*100, by=byQtr, FUN=mean)
qtr.AvRet
summary(qtr.AvRet)

par(mfcol = c(1,1))
boxPlot(ret.ts, title=FALSE)  # title = FALSE allows you to add your custom labels
title(main="boxplots of 20 sep Purchases", ylab="returns", xlab="EBIX")
boxPercentilePlot(ret.ts)
  #remember it's boxPlot not boxplot (the capital P allows all of the series to be plotted)
