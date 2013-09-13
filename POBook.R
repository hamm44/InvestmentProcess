# POptimization Book
library(fPortfolio)

# preloaded data : SWX, LPP2005, SPISECTOR, GCCINDEX, SMALLCAP, MSFT

# get my own data in
startDate <-"2012-01-01"
endDate <- "2013-09-01"
AAPL  <- "GOOG/NASDAQ_AAPL.4"
LULU <- "GOOG/NASDAQ_LULU.4"
MX <- "GOOG/NYSE_MX.4"
TGA <- "GOOG/NASDAQ_TGA.4"
NLY <- "GOOG/NYSE_NLY.4"
data2 <- Quandl(stockList, start_date=startDate, end_date=endDate, type="xts", transformation="rdiff")
colnames(data2) <- c("AAPL", "LULU", "MX", "TGA", "NLY")
data2 <- as.timeSeries(data2)

end(data2)
start(data2)

# sample a time series, with or without replacement
SAMPLE <- sample(data2[1:10],)
SAMPLE
class(SAMPLE)

S2 <- sample(SWX[1:10,])
S2
class(SWX)

sort(SAMPLE)
sort(S2)

data2[5:10,"MX"]
data2["2012-01-11",]

# window function to subset period
window(data2, start = "2012-03-01", end = "2012-06-30")
round(window(data2, start = "2012-03-01", end = "2012-06-30"), 4) 
  #returns the results rounded to 4 decimals

# Use Aggregate function create weekly, monthly, quarterly, yearly returns from daily
# sequence of date/time stamps defining group and function to be applied

# timeCalender() function returns monthly dates in vector
# Create articial time series
charvec <- timeCalendar()
data3 <- matrix(round(runif(24, 0, 10)), 12)
tS <- timeSeries(data3, charvec)
tS
# Create the quarterly breakpoints from the charvec seaching for the last day in a qtr for each date.
# To suppress the double dates we make the breakpoints unique
by <- unique(timeLastDayInQuarter(charvec))
?timeLastDayInQuarter #computes the first/last day in given month
by
# create monthly sums or averages with aggregated monthly sums
aggregate(tS, by, FUN=sum, units=c("TSQ.1", "TSQ.2"))

############ chapter 2 Financial Functions to Manipulate Assets ################




