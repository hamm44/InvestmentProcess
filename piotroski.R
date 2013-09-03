# Piotroski F-score, download screener, then rank with P/B
# http://www.grahaminvestor.com/screens/piotroski-scores/
# Potroski has 9 categories, scored as binary, with the 9 measures described by
#  Net Income, Operating CF, ROA, Earnings Quality (operating CF>netincome), LT debt, CRatio, 
#   Shares outstanding, Gross margin, Asset Turnover


setwd("C:/Users/Mike/Dropbox/Investment/R/Piotroski")

require(XML)
# library(xtable) #for printing output of table

options(width=120)

piot.url <- "http://www.grahaminvestor.com/screens/piotroski-scores/"

piot.table <- readHTMLTable(piot.url, header=TRUE, 
                            colClasses=c("character","character","factor","character","character",
                                         "character", "character","character","character",
                                         "numeric", "numeric", "character", "numeric", "numeric",
                                          "numeric", "numeric", "numeric"),
                            as.data.frame=TRUE, which =2)
names(piot.table)
head(piot.table)

#clean up the data to leave out period end, curr qtr, prev qtr
piot <- piot.table[,-c(4,7,8,9)]
head(piot)

#function to return top 30 by sorted book value
piotPB <- function(lb,ub){
  
  p.subset <- subset(piot, piot[,13]>lb & piot[,13]<ub)
  p.sort <- p.subset[order(p.subset[,13]),]
  pscreen <- p.sort[1:100,-c(6,7,9,10)]
  return(pscreen)
  
}

pscreen <- piotPB(0.9,3)
pscreen[with(pscreen, order(Sector)),]  # return with sectors grouped

# print(xtable(pscreen), type="HTML")

# write to csv
write.table(pscreen, file="piotroski.csv", sep = ",", row.names=FALSE)

#function to return top 30 sorted by P/E
piotPE <- function(lb,ub){
  p.subset <- subset(piot, piot[,12]>lb & piot[,12]<ub)
  p.sort <- p.subset[order(p.subset[,12]),]
  pscreen2 <- p.sort[1:100,-c(6,7,9,10)]
  return(pscreen2)
}

pscreen2 <- piotPE(3,11)
pscreen2[with(pscreen2, order(Sector)),]

write.table(pscreen2, file="piotroskiPE.csv", sep = ",", row.names=FALSE)



