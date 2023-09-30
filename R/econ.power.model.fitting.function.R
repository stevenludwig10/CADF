#' @export econ.power.model.fitting.function
#power model with intercept
econ.power.model.fitting.function <- function(x, b0, b1) {
  
  b0 + x^b1
  
}