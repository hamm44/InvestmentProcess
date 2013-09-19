# quandl search and return stock list in xts, rdiff  
library(Quandl) 
library(timeSeries)
token <- 'jMzykr2TqHKytNTHknXH'
Quandl.auth(token)

options(digits=4)   

# user defined input variables
stocks <- c("AAPL", "WNC", "EBIX", "MX", "TGA", "NLY") # list the codes you want to search, and find codes for
startDate <-"2012-01-01"
endDate <- "2013-09-01" 
trans <- "rdiff" #diff, cumul, normalize
coll <- "none" #daily, weekly, monthly, quarterly, annual

# initialise list, then find the codes using regexp on the search results
code <- list()
for (i in stocks) {
  res <- as.character(Quandl.search(i))
  resInd <- regexpr(paste("GOOG/[A-Z]*_", i, sep=""), res)
  code[[i]] <- (regmatches(res, resInd))
} 

# Make the list into a vector and add .4 ( to return the 4th column of data)
stockList <- paste(unlist(code), ".4", sep="")
# once we have the codes, we want to download the data
data <- Quandl(stockList, start_date=startDate, end_date=endDate, type="zoo", transformation=trans, collapse=coll)
names(data) <- stocks
head(data)