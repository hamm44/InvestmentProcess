#forecasting principles and practise
#http://otexts.com/fpp/2/5/

setwd("C:/Users/Mike/Dropbox/Investment/R/ForecastPP")
require(fpp) #load library with data from fpp text

# three examples
beer <- aggregate(ausbeer)
head(beer)
summary(beer)
beer
ausbeer
plot(beer) #sales of beer
plot(a10) #sales of pharma products
plot(taylor) #half hourly electricity demand

# Fully automated forecasting
plot(forecast(beer))
plot(forecast(a10))
plot(forecast(taylor))

# Test methods on a test set
beertrain <- window(beer, end=1999.99)
  #window() function gets subset of timeseries whilst maintaining 
  #properties of the series
beertest <- window(beer, start=2000)
a10train <- window(a10, end=2005.99)
a10test <- window(a10, start=2006)

# Simple methods for the BEER data
f1 <- meanf(beertrain, h=8)
f2 <- rwf(beertrain, h=8)
f3 <- rwf(beertrain, drift=TRUE, h=8)
#in-sample accuracy
accuracy(f1)
accuracy(f2)
accuracy(f3)
#out of sample accuracy
accuracy(f1, beertest)
accuracy(f2, beertest)
accuracy(f3, beertest)

plot(f1)
plot(f2)
plot(f3)

#Exponential Smoothing

fit1 <- ets(beertrain, model="ANN", damped = FALSE)
fit2 <- ets(beertrain) #this is the automatic method

fcast1 <- forecast(fit1, h=8)
fcast2 <- forecast(fit2, h=8)
plot(fcast2)
accuracy(fcast2)

fit <- ets(a10train)
test <- ets(a10test, model=fit)
accuracy(test)
accuracy(forecast(fit, 30), a10test)

#Box.Cox Transformations
lam <- BoxCox.lambda(a10) #0.131 is the lambda value for transform to log
fit <- ets(a10, additive=TRUE, lambda=lam)
plot(forecast(fit))
plot(forecast(fit), include=60)

# ARIMA forecasting
tsdisplay(beertrain)
tsdisplay(diff(beertrain))
fit3 <- Arima(beertrain, order=c(3,1,0))
fit4 <- auto.arima(beertrain)
fcast3 <- forecast(fit3, h=8)
fcast4 <- forecast(fit4, h=8)
plot(fcast3)
plot(fcast4)
accuracy(fcast3)
accuracy(fcast4)

#seasonal plots of multiple years
seasonplot(a10,ylab="$ million", xlab="Year", 
           main="Seasonal plot: antidiabetic drug sales",
           year.labels=TRUE, year.labels.left=TRUE, col=1:20, pch=19)

monthplot(a10,ylab="$ million",xlab="Month",xaxt="n",
          main="Seasonal deviation plot: antidiabetic drug sales")
axis(1,at=1:12,labels=month.abb,cex=0.8)


acf(beer)
beer2 <- window(ausbeer, start=1992, end=2006-.1)
lag.plot(beer2, lags=9, do.lines=FALSE)
acf(beer2)

snaive(beer2, h=8)

beer2 <- window(ausbeer,start=1992,end=2006-.1)
beerfit1 <- meanf(beer2, h=11)
beerfit2 <- naive(beer2, h=11)
beerfit3 <- snaive(beer2, h=11)

plot(beerfit1, plot.conf=FALSE, 
     main="Forecasts for quarterly beer production")
lines(beerfit2$mean,col=2)
lines(beerfit3$mean,col=3)
legend("topright",lty=1,col=c(4,2,3),
       legend=c("Mean method","Naive method","Seasonal naive method"))













