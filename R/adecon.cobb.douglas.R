#' @export adecon.cobb.douglas
#' 
#' 
#' 

adecon.cobb.douglas<- function(sales.var, mediums.var, dataset) {
  
  #log-log model
  y <- as.matrix(dataset[,analysis.var])
  x <- as.matrix(dataset[,mediums.var])
  
  ylog <- log(y)
  xlog <- log(x)
  
  xlog[is.infinite(x)] <- NA
  ylog[is.infinite(x)] <- NA
  
  model <- lm(ylog ~ xlog, na.action=na.exclude)
  
  result <- R6Class("result")
  result$self$model <- model
  result$self$betas <- model$coefficients[2:length(model$coefficients)]
  result$self$betasum <- sum(result$self$betas)
  result$self$optimalspend <- result$self$betas /result$self$betasum 
  
  result$self$baseline <- y / apply(x^result$self$betas, 1, prod)
  
  return(result)

}