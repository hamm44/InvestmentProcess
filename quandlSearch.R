# quandl search and return stock list in xts, rdiff  
library(Quandl) 
library(timeSeries)
token <- 'jMzykr2TqHKytNTHknXH'
Quandl.auth(token)

# notes about the Quandl.search() function
# add in Quandl.search("term", source="GOOG")  or source="YHOO", "FRED", etc



options(digits=4)   

# user defined input variables
# stocks <- c("AAPL", "WNC", "EBIX", "MX", "TGA", "NLY") # list the codes you want to search, and find codes for
# startDate <-"2012-01-01"
# endDate <- "2013-09-01" 
# trans <- "rdiff" #diff, cumul, normalize
# collapse <- "none" #daily, weekly, monthly, quarterly, annual

# initialise list, then find the codes using regexp on the search results
stockCodes <- function(stocks){
  code <- list()
  for (i in stocks) {
    res <- as.character(Quandl.search(i, source="GOOG", silent=TRUE))
    resInd <- regexpr(paste("GOOG/[A|N|L][A-Z]+_", i, sep=""), res) # searches with google data
    code[[i]] <- (regmatches(res, resInd))
  } 
  
  # Make the list into a vector and add .4 ( to return the 4th column of data)
  stockL <- paste(unlist(code), ".4", sep="")
  return(stockL)
}

  # once we have the codes, we want to download the data
stockData <- function(stockC, startDate, endDate, trans=NULL, collapse=NULL){  
  data <- Quandl(stockC, start_date=startDate, end_date=endDate, type="zoo", transformation=trans, 
                 collapse=collapse)
  # show the data format
  return(data)
  
}


