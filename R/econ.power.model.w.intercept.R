#' @export econ.power.model.w.intercept
econ.power.model.w.intercept = function(Q,X) {
  
  model = nls(Q ~ power_model_fitting_function(X, intercept, power), start = list(intercept = 0, power = 2), trace = T)
  
  
}


