library(datarium)
data(marketing)
mediums.var <- c("facebook", "newspaper", "youtube")
analysis.var <- c("sales")
dataset <- marketing

analysis <- CADF::adecon.cobb.douglas(sales.var, mediums.var, dataset)