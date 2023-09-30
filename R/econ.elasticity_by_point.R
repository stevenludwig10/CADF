#' @export econ.elasticity.bypoint
econ.elasticity.bypoint = function(Q, X) { # linear model
  #source pg. 95 Static Response Models
  dataset = as.data.frame(x= X/Q)
  colnames(dataset) = c("x_q")
  #no slope for first calculation
  
  result = (diff(Q)/diff(X)) * dataset$x_q[2:nrow(dataset)]
  
  plot(Q, c("0" , result))
  
  return(result)
  
}