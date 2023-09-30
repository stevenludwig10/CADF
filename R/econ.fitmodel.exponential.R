#' @export econ.fitmodel.exponential
econ.fitmodel.exponential <-function(dataset) {
  
  nls(Q ~ exp(b0) * exp(b1 * X), data = dataset, start = list(b0=0, b1=0))
  lines(temp$x, predict(mod, list(x = temp$x)))
  
  
  
}