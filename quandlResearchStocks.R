# Quandl Research Trends on Stocks
library(Quandl) 
token <- 'jMzykr2TqHKytNTHknXH'
Quandl.auth(token)

stocks <- c("EBIX", "WNC", "MERU", "PKX", "AAPL") 
startRdate <-"2000-01-01"
endRdate <- "2013-09-01"
trans <- NULL #rdiff, diff, cumul, normalize, null
collapse <- NULL #"weekly","monthly","quarterly","annual"
# Search for "All Financial Ratios"

AAPL <- Quandl("OFDP/DMDRN_AAPL_ALLFINANCIALRATIOS")

AllRatios <- function(s){
  allData <- list()
  for (i in s){
    pasted <- paste("OFDP/DMDRN_",i,"_ALLFINANCIALRATIOS", sep="")
    print(pasted)
    data <- Quandl(pasted, type="zoo")
    allData[[i]] <- data
  }
  allData
}

AllDataList <- AllRatios(stocks)
# Combine the Rows and Take each column corresponding to each Category

one.df <- do.call(merge, AllDataList)
class(one.df)
dim(one.df)
df <- as.data.frame(one.df)
finalData <- t(df)
finalData[is.na(finalData)] <- c("")  # makes NA into whitespace before exporting to csv.

write.csv(finalData, file="QuandlStockRatiosResearch.csv")

# cash as % of revenue
string = "Cash as Percentage of Revenues."
combined <- paste(string,stocks, sep="")  
combined
cashP <- df[, combined]

# function to find the data
RelRat <- function(dfr, str, sto){
  x <- paste(str, sto, sep="")
  return(dfr[,x])
}

# Some % Valuations for Comparison
cashPer <- RelRat(df, "Cash as Percentage of Revenues.", stocks)
cashPer
cashFV <- RelRat(df, "Cash as Percentage of Firm Value.", stocks)
cashFV
ROE <- RelRat(df, "Return on Equity.", stocks)
ROE

# Reference the csv to find the row I'm trying to pull, and pull it into R
# Use the excel sheet to find the row numbers, because subsetting by row names is difficult when data missing

EvEb <- finalData[c(27, 94, 211, 279),]

t(EvEb)




