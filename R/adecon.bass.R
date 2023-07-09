#' @export adecon.bass.linearized
adecon.bass.linearized <- function(sales, periods.out) {

  sales_lagged <- lag(cumsum(sales))
  sales_lagged_sq <- sales_lagged^2
  
  #linearized model
  model <- lm(sales ~ sales_lagged + sales_lagged_sq)
  a <- model$coefficients["(Intercept)"]
  b <- model$coefficients["sales_lagged"]
  c <- model$coefficients["sales_lagged_sq"]
  m <- (-b - sqrt((b^2) - 4 * a * c)) / (2 * c)
  
  model$bass.p <- a/m
  model$bass.q <- -m*c
  model$bass.m <- m
  
  model$bass.time_to_peak_sales <-  log(model$bass.p/model$bass.q) / (model$bass.p+model$bass.q)
  model$bass.sales_at_peak <- model$bass.m * ((model$bass.q + model$bass.p)^2 ) / (4 * model$bass.q)
  model$bass.cum_sales_at_peak <- (model$bass.m * (model$bass.q - model$bass.p)) / (2 * model$bass.q)
  
  model$bass.T <- 1:(length(sales) + periods.out)
  
  return(model)
}