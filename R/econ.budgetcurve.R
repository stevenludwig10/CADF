#' @export econ.budgetcurve
#' Analyze consumer tradeoffs between two goods (in this case advertising vs no advertising)
#' For advertising analysis the two goods could be number of programs versus number of advertisements
#' Or, Total ad viewing time and total program viewing time
econ.budgetcurve <- function(x1, x2, p1, p2) {

   return((p1*x1) + (p2*x2))
  
}