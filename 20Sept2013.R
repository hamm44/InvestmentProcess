# Analysis of Stock Purchase on 20 Sept 2013
# Purchased wnc, ebix, tga, meru, pkx  on 20th Sept 2013

# Find the stock codes using the quandlSearch.R function
stocks <- c("EBIX", "WNC", "TGA", "MERU", "PKX") # list the codes you want to search, and find codes for
startDate <-"2012-01-01"
endDate <- "2013-09-01" 
trans <- NULL #rdiff, diff, cumul, normalize, null

# Load the quandlSearch.R function
source("quandlSearch.R")

#Use loaded file to find the codes, then return data as price index
codes <- stockCodes(stocks) # returns the codes to return 4th column in the R API
codes   # after seeing that there is FRA pkx, i remove this column
prices <- stockData(codes, startDate, endDate, trans)
names(prices) <- stocks
