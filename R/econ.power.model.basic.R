#' @export econ.power.model.basic
#' power model
#' @param Q quantity
econ.power.model.basic = function(Q, X) {
  
  #uses R nls formula
  model = nls(Q~ I(X^power), start = list(power = 1), trace = T)
  
  print(summary(model))
  
  return (model)
}