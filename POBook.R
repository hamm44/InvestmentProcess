# POptimization Book
library(fPortfolio)
library(Quandl) 
library(timeSeries)
token <- 'jMzykr2TqHKytNTHknXH'
Quandl.auth(token)
# preloaded data : SWX, LPP2005, SPISECTOR, GCCINDEX, SMALLCAP, MSFT

# get my own data in
startDate <-"2012-01-01"
endDate <- "2013-09-01"
AAPL  <- "GOOG/NASDAQ_AAPL.4"
LULU <- "GOOG/NASDAQ_LULU.4"
MX <- "GOOG/NYSE_MX.4"
TGA <- "GOOG/NASDAQ_TGA.4"
NLY <- "GOOG/NYSE_NLY.4"
data2 <- Quandl(stockList, start_date=startDate, end_date=endDate, type="zoo", transformation="rdiff")
colnames(data2) <- c("AAPL", "LULU", "MX", "TGA", "NLY")
head(data2)
data3 <- as.timeSeries(data2)
head(data3)

dIndex <- Quandl(stockList, start_date=startDate, end_date=endDate, type="zoo")
colnames(dIndex) <- c("AAPL", "LULU", "MX", "TGA", "NLY")
dIn <- as.timeSeries(dIndex)
head(dIn)

end(data3)
start(data3)

# sample a time series, with or without replacement
SAMPLE <- sample(data3[1:10],)
SAMPLE
class(SAMPLE)

S2 <- sample(SWX[1:10,])
S2
class(SWX)

sort(SAMPLE)
sort(S2)

data3[5:10,"MX"]
data3["2012-01-11",]

# window function to subset period
window(data3, start = "2012-03-01", end = "2012-06-30")
round(window(data3, start = "2012-03-01", end = "2012-06-30"), 4) 
  #returns the results rounded to 4 decimals

# Use Aggregate function create weekly, monthly, quarterly, yearly returns from daily
# sequence of date/time stamps defining group and function to be applied

# timeCalender() function returns monthly dates in vector
# Create articial time series
charvec <- timeCalendar()
data4 <- matrix(round(runif(24, 0, 10)), 12)
tS <- timeSeries(data4, charvec)
tS
# Create the quarterly breakpoints from the charvec seaching for the last day in a qtr for each date.
# To suppress the double dates we make the breakpoints unique
by <- unique(timeLastDayInQuarter(charvec))
?timeLastDayInQuarter #computes the first/last day in given month
by
# create monthly sums or averages with aggregated monthly sums
aggregate(tS, by, FUN=sum, units=c("TSQ.1", "TSQ.2"))

############ chapter 2 Financial Functions to Manipulate Assets ################
#returns
  # generates returns from a price/index series
#cumulated
  # generates indexed values from a returns series 
#drawdowns
  # computes drawdowns from financial returns
#lowess
  # smooths a price/index series
#turnpoints
  # finds turnpoints for a smoothed price/index series

######## pg 41  chapter 3 Basics Stats ######################
# basicStats()
# drawdownStats()
# mean, var, cov, skewness, kurtosis, colMeans()
# quantile, colQuantiles
# covRisk, varRisk, cvarRisk
  # x, weights, alpha (pg82)
# colCumreturns()

####### pg 71 chapter 5 Plotting Time Series ################
# plot()
# seriesPlot()
# returnPlot()
# cumulatedPlot()

xlim = c(start(data3), end(data3))
atlimit <- as.Date(seq(start(data3), end(data3), by="month"))
plot(data3, plot.type="single", ylab="Daily Returns", main="Stocks", col=rainbow(ncol(data3)))
axis.Date(1, at=atlimit, labels=atlimit, format="%b-%Y")
hgrid()
box_()
boxL()

plot(dIn, plot.type="single")
par(mfcol=c(1,5))
seriesPlot(dIn)
seriesPlot(dIn[,2]) # price index plot
returnPlot(dIn) # Can use price index
cumulatedPlot(data3[,4]) #must use returns data

boxplot(data3) # only plots one asset
boxPlot(data3) # this one plots all 5 assets
boxPercentilePlot(data3)

histPlot(data3)
densityPlot(data3)
logDensityPlot(data3)

par(mfcol = c(1,1))
qqnormPlot(data3[,1])
qqnormPlot(data3)
qqnigPlot(data3[,1])

##### pg 125 Selecting Similar Assets #######
hclustData <- assetsSelect(data3, method = "hclust", control=c(measure="euclidean", 
                                                               method="ward"))
plot(hclustData)

kmeansData <- assetsSelect(data3, method = "kmeans", 
                           control=c(centers=2, algorithm="Hartigan-Wong"))
sort(kmeansData$cluster)
plot(kmeansData)

#### pg 139 Comparing Multivariate Return and Risk statistics #####











