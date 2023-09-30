#' @export econ.elasticity
#quantity - price data to test elasticities

#Q = c(1000, 2300, 4000, 4500, 4000, 4500)
#X = c(20, 23, 28, 34, 40, 50)

#elasticity
#basic log~log elasticity model
#SAS way of doing it

econ.elasticity = function(Q,X) {
  
  model = lm(log(Q) ~ log(X))
  return(as.numeric(model$coefficients[2]))
  
}
