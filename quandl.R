#Quandl Data Sets

setwd("C:/Users/Mike/Dropbox/Investment/R/RScripts")
token <- 'jMzykr2TqHKytNTHknXH'

library(Quandl)                                   # Quandl package
library(ggplot2)                              # Package for plotting
library(reshape2)     
library(xts)
library(fpp)

Quandl.auth(token)


# AUSBS/5206006_INDUSTRY_GVA_A2716160J  agriculture
ag <- Quandl("AUSBS/5206006_INDUSTRY_GVA_A2716160J", 
             start_date="2000-01-01",end_date="2013-07-30", type="xts")
mining <- Quandl("AUSBS/5206006_INDUSTRY_GVA_A2716163R", 
                 start_date="2000-01-01",end_date="2013-07-30", type="xts")
manu <- Quandl("AUSBS/5206006_INDUSTRY_GVA_A2716166W", 
               start_date="2000-01-01",end_date="2013-07-30", type="xts")
util <- Quandl("AUSBS/5206006_INDUSTRY_GVA_A2716175X", 
               start_date="2000-01-01",end_date="2013-07-30", type="xts")
construct <-  Quandl("AUSBS/5206006_INDUSTRY_GVA_A2716179J", 
                     start_date="2000-01-01",end_date="2013-07-30", type="xts")
wholesale <- Quandl("AUSBS/5206006_INDUSTRY_GVA_A2716180T", 
                    start_date="2000-01-01",end_date="2013-07-30", type="xts")
retail  <- Quandl("AUSBS/5206006_INDUSTRY_GVA_A2716181V", 
                  start_date="2000-01-01",end_date="2013-07-30", type="xts")
accom <- Quandl("AUSBS/5206006_INDUSTRY_GVA_A2716182W", 
                start_date="2000-01-01",end_date="2013-07-30", type="xts")
transport <- Quandl("AUSBS/5206006_INDUSTRY_GVA_A2716183X", 
                    start_date="2000-01-01",end_date="2013-07-30", type="xts")
media <- Quandl("AUSBS/5206006_INDUSTRY_GVA_A2716188K", 
                start_date="2000-01-01",end_date="2013-07-30", type="xts")
financial <- Quandl("AUSBS/5206006_INDUSTRY_GVA_A2716189L", 
                    start_date="2000-01-01",end_date="2013-07-30", type="xts")
rental <- Quandl("AUSBS/5206006_INDUSTRY_GVA_A2716190W", 
                 start_date="2000-01-01",end_date="2013-07-30", type="xts")
scientific <- Quandl("AUSBS/5206006_INDUSTRY_GVA_A2716191X", 
                     start_date="2000-01-01",end_date="2013-07-30", type="xts")
admin <- Quandl("AUSBS/5206006_INDUSTRY_GVA_A2716585R", 
                start_date="2000-01-01",end_date="2013-07-30", type="xts")
public <- Quandl("AUSBS/5206006_INDUSTRY_GVA_A2716192A", 
                 start_date="2000-01-01",end_date="2013-07-30", type="xts")
education <- Quandl("AUSBS/5206006_INDUSTRY_GVA_A2716193C", 
                    start_date="2000-01-01",end_date="2013-07-30", type="xts")
health <- Quandl("AUSBS/5206006_INDUSTRY_GVA_A2716194F", 
                 start_date="2000-01-01",end_date="2013-07-30", type="xts")
art <- Quandl("AUSBS/5206006_INDUSTRY_GVA_A2716195J", 
              start_date="2000-01-01",end_date="2013-07-30", type="xts")
other <- Quandl("AUSBS/5206006_INDUSTRY_GVA_A2716196K", 
                start_date="2000-01-01",end_date="2013-07-30", type="xts")

AusData <- c(ag, mining, manu, util, construct, wholesale, retail, accom, 
             transport, media, financial, rental, scientific, admin, 
             public, education, health, art, other)

ausd <- Quandl("USER_28O/28P", 
               start_date="2000-01-01",end_date="2013-07-30", type="xts")

names(ausd) <- c("agriculture", "mining", "manufacturing", "utility", 
                 "construction", "wholesale", "retail", "accommodation", 
                 "transport", "informationMedia", "financial", "rental",
                 "scientific", "administration", "public", "education",
                 "health", "art", "other")

#find % change of retail without making another API call, 
retailC <- diff(retail)/lag(retail)
finman <- (diff(financial)/lag(financial))[-1,]
# calling the API with transformation = rdiff is the same as above

#use zoo and rdiff transformation on API call and merge
findif <- Quandl("AUSBS/5206006_INDUSTRY_GVA_A2716189L", 
                 start_date="2000-01-01",end_date="2013-07-30", type="zoo", transformation="rdiff")
mindif <- Quandl("AUSBS/5206006_INDUSTRY_GVA_A2716163R", 
                 start_date="2000-01-01",end_date="2013-07-30", type="zoo", transformation="rdiff")
finmin <- merge(findif, mindif)
#regress the data financial against mining
lm(coredata(finmin[,1]) ~ coredata(finmin[,2]), na.action=na.omit)$coef[2]
fit <- lm(findif ~ mindif)   #lm regresses financial (y the response) ~ with mining (x - the inputs)
plot(residuals(fit) ~ mindif) #plotting the residuals of the fit in y (financials) checks for heteroskadici
lm(financial ~ mining)
plot(coredata(financial), coredata(mining))

#linear trends, from http://otexts.com/fpp/4/8/
miningTs  <- as.ts(mining)
fitMining  <- tslm(miningTs ~ trend)
f  <- forecast(fitMining, h=5, level=c(80,85)) #forecast 5 time periods with 80 - 85% confidence interval
plot(f, ylab="Australian Mining Industry Forecast", xlab="year")
lines(fitted(fitMining), col="blue")
summary(fitMining)
res <- residuals(fitMining)
Acf(res) #plot autocorrelation of the residuals of the fitted





























