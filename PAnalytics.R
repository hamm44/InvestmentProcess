# Performance Analytics
# http://www.youtube.com/watch?v=vUVAaDqz4cs
# http://cran.r-project.org/web/packages/PerformanceAnalytics/PerformanceAnalytics.pdf
options(digits=4)   
options(scipen=999)    # removes scientific notations in results
library(PerformanceAnalytics)
library(xts)
library(tseries)
library(plyr) # for renaming datasets
library(fPortfolio) # for portfolio optimisations
library(quadprog)

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

startDate <-"2012-01-01"
endDate <- "2013-09-01"
AAPL  <- "GOOG/NASDAQ_AAPL.4"
LULU <- "GOOG/NASDAQ_LULU.4"
MX <- "GOOG/NYSE_MX.4"
TGA <- "GOOG/NASDAQ_TGA.4"
NLY <- "GOOG/NYSE_NLY.4"

stockList  <- c(AAPL, LULU, MX, TGA, NLY)

data <- Quandl(stockList, start_date=startDate, end_date=endDate, type="xts", transformation="rdiff")
  # collapse = ("daily", "weekly", "monthly", "quarterly", "annual")

  #the .4 returns the 4th column of the google dataset
# dataRN <- rename(data, c("GOOG.NASDAQ_AAPL - Close" = "AAPL", 
  #                       "GOOG.NASDAQ_LULU - Close" ="LULU", 
   #                      "GOOG.NYSE_MX - Close"="MX", 
    #                     "GOOG.NASDAQ_TGA - Close"="TGA", 
     #                    "GOOG.NYSE_NLY - Close"="NLY"))

names(data) <- c("AAPL", "LULU", "MX", "TGA", "NLY")

# dataRet <- Return.calculate(data, method=c("simple","compound")) # no need for this, if already transformed

table.Stats(data)  # loads summaries

charts.PerformanceSummary(data, colorset=rich6equal)

###################### Creating Efficient Frontier with Chosen Assets ###############################
## Need a matrix with expected returns and covariances, in timeSeries format, i.e SPISECTOR
## http://cran.r-project.org/web/packages/fPortfolio/fPortfolio.pdf
## coerce zoo with as.timeSeries.foo(), as.timeSeries
data2 <- Quandl(stockList, start_date=startDate, end_date=endDate, type="xts", transformation="rdiff")
colnames(data2) <- c("AAPL", "LULU", "MX", "TGA", "NLY")
data2 <- as.timeSeries(data2)
data.cov <- covEstimator(data2)
data.cov

assets <- 5
constraints <- c('LongOnly')   #specify as long only
constraints <- c('minW[1:assets]=0', 'maxW[1:assets]=0.5') #specify with min weights to max weights
  # constraints  <- c('minW[1:assets]=0', 'maxW[1:assets]=0.5', 'minsumW[c("LULU", "AAPL")]=0.1') 
        # can also add in constraints where you hold a certain amount of assets in your portfolio.

# optimisation specs
spec <- portfolioSpec()
setNFrontierPoints(spec) <- 25
setSolver(spec) <- "solveRquadprog"

# check the constraints
portfolioConstraints(data2, spec, constraints)

# do optimisation
frontier <- portfolioFrontier(data2, spec, constraints)
print(frontier)

# plot frontier
