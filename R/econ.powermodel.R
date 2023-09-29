#' @export econ.powermodel
#power model / increasing returns to scale

#test data for power fitting
#source: http://www.itc.nl/~rossiter/teach/R/R_CurveFit.pdf

set.seed(520)
len = 24
x = runif(len)
y = x^3 + rnorm(len, 0, 0.06)
#ds = data.frame(X = x,  Q = y)
X = x
Q = y
econ.powermodel <- function(Q,X) {
  #returns power
  
  #visualize data
  print("plotting variables --- press c to continue")
  plot(Q ~ X)
  browser()
  model = nls(Q ~ I(X^power), start= list(power=1), trace = T)
  
  print(summary(model))
  power_model_result = (summary(model)$coefficients[1])
  power_model_result_standardError = (summary(model)$coefficients[2])
  
  #plot fitted model
  plot(Q ~ X, main="power model" , sub = "blue = known; red = fit")
  sequ = seq(0,1, by=.001)
  predictions = predict(model, sequ)
  lines(predictions, col=red)	
  
  return(power_model_result)
  
}
