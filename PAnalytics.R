# Performance Analytics
# http://www.youtube.com/watch?v=vUVAaDqz4cs
# http://cran.r-project.org/web/packages/PerformanceAnalytics/PerformanceAnalytics.pdf

library(PerformanceAnalytics)
library(xts)
library(tseries)
# library("plottrix") # for 3d pie charts

# functions list.

# Return.read() function loads csv files where dates in first column, returns for period in subsequent columns


# return.calculate(prices, method=c("compound", "simple")), assumes adjusted close prices
  # to.period in xts package to create regular price data i.e monthly/daily/yearly
  # aggregate.zoo supports management and conversion of irregular time series
  # calculateReturns() is the same function

# get some data to chart, (can use strategy returns, hedge fund manager returns)
library(Quandl) 
token <- 'jMzykr2TqHKytNTHknXH'
Quandl.auth(token)

startDate <-"2011-01-01"
endDate <- "2013-09-01"
AAPL  <- "GOOG/NASDAQ_AAPL.4"
LULU <- "GOOG/NASDAQ_LULU.4"
MX <- "GOOG/NYSE_MX.4"
CSC <- "GOOG/NYSE_CSC.4"
TGA <- "GOOG/NASDAQ_TGA.4"
NLY <- "GOOG/NYSE_NLY.4"
PKX <- "GOOG/NASDAQ_PKX.4"
stockList  <- c(AAPL, LULU, MX, CSC, TGA, NLY, PKX)

data <- Quandl(stockList, start_date=startDate, end_date=endDate, type="xts")
  #the .4 returns the 4th column of the google dataset
names(data) <- c("AAPL", "LULU", "MX", "CSC", "TGA", "NLY", "PKX")

dataRet <- return.calculate(data, method="simple")

table.Stats(dataRet)  # loads summaries

charts.PerformanceSummary