
#' @export ca_SRM

ca_SRM <- function(df_logistic) {
  #estimates retention rate using logistic regression and the simple regression model
  #SAS DESCENDING OPTION is one minus in R
  #Intercept only model
  model <- stats::glm((1-cancel) ~ 1, family = "binomial", data = df_logistic)
  intercept <- model$coefficients[1]
  r <- 1 - exp(intercept)[[1]]
  r <- round(r, 3)
  return(r)
  
}