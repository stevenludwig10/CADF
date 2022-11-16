#' Compute the months between two purchase dates
#'
#' `f_intMonths` inputs are customer id and transactional data.
#'
#' Description here
f_intMonths = function(a, b) {
  i <- interval(a,b) %/% months(1)
  return(i + 1)}
