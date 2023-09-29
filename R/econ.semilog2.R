#' @export econ.semilog
econ.semilog = function(Q, X) {
  #build model
  model = lm(Q~log(X))
  return(model)
}     
