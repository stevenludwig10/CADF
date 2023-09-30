#' @export econ.fitmodel.semilog
econ.fitmodel.semilog <- function(Q,X) { 
  
  model = lm(Q ~ log(X))	
  predicted = as.numeric(model$coefficients[1])+ as.numeric(model$coefficients[2])  * log(X)
  
  plot(X, Q, col="blue")
  title ("semilog model")
  points(X, predicted, col="red")
  return()
}