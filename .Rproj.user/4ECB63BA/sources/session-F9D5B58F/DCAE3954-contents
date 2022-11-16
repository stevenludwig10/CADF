#annual halfing

data("ltv.transactions")
head(ltv.transactions)
a <- split(ltv.transactions, ltv.transactions$ID)
today <- as.Date("8/31/2020", '%m/%d/%Y')
cadf.data <- lapply(a, function(x) CADF::Customer$new(x, today=today))

dta <- lapply(cadf.data, function(x) tail(x$data, 1))
dta <- do.call(rbind, dta)

grid2 <- c(0,0,0,0)
grid2 <- c(.5388,.9289,.4865,-1.06)

rec <- as.numeric(dta$recency.studyperiod.years)
freq <- dta$Frequency.baseperiod
targetBuy = as.numeric(as.character(dta$target.buy))


res <- CADF::modeling.annualhalfing.likelihood(grid2, rec, freq, targetBuy)

### method 1

for (i in 1:20) {
  grid2 = c(sample(a,1),sample(a,1),sample(b,1),sample(b,1))
  model<- nlminb(CADF::modeling.annualhalfing.likelihood, start=grid2, 
                 upper=c(1,1,Inf,Inf), lower=c(0,0,-Inf,-Inf), control=list(eval.max=900), rec=rec, freq=freq, targetBuy = targetBuy)
  data_result[i,] <- c(model$par, model$objective)
  print(grid2)
  
}

#method 2
options(scipen=15)
optim(grid2, CADF::modeling.annualhalfing.likelihood, rec=rec, freq=freq, targetBuy=targetBuy)




