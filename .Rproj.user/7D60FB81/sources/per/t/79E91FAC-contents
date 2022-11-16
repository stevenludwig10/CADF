
#' The customer analytics data format (CADF) relays heavily on correct input data.
#' Transactional data must:
#' 1.) be a data frame with two columns
#' 2.) Column one is the customer id
#' 3.) Column 2 is the transaction date.  Column 2 must be formatted as a date object in R.
#' @export qc_transactional_data
#' @param x R dataframe representing ..
#' @return A number representing whether it passes or not.


qc_transactional_data <- function(x) {
  condition.1 <- length(unique(x[[1]][1]))
  condition.2 <-  inherits(x[[2]], "Date")
  return(condition.1 + condition.2)
}