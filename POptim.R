library(fPortfolio)
######  User Inputs  ###########################
# Returns <- ret.ts  # data as returns time series format
# constraints  <- c('LongOnly') # constraints  <- c('minW[1:assets]=0', 'maxW[1:assets]=0.5', 'minsumW[c("LULU", "AAPL")]=0.1') 



####### Portfolio Optimisation #################
assets <- ncol(ret.ts)
constraints <- c('LongOnly')   #specify as long only
# constraints <- c('minW[1:assets]=0', 'maxW[1:assets]=0.5') #specify with min weights to max weights
# constraints  <- c('minW[1:assets]=0', 'maxW[1:assets]=0.5', 'minsumW[c("LULU", "AAPL")]=0.1') 
# can also add in constraints where you hold a certain amount of assets in your portfolio.

# optimisation specs
spec <- portfolioSpec()
setNFrontierPoints(spec) <- 25
setSolver(spec) <- "solveRquadprog"

# check the constraints
portfolioConstraints(ret.ts, spec, constraints)

# do optimisation
frontier <- portfolioFrontier(ret.ts, spec, constraints)
print(frontier)

# plot frontier
tailoredFrontierPlot(frontier)  #plots the efficient frontier

#plot weights
weightsPlot(frontier, col=rainbow(assets)) # uses different colours

