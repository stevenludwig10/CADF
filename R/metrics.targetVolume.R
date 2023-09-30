#' @export metrics.targetVolume

#' Return optimal price for a linear demand curve
#'
#' `metrics.targetVolume` returns .....
#'
#' Description here
#' @param fixedcosts:
#' @param targetProfits
#' @param salesPrice
#' @param variableCosts



metrics.targetVolume = function(fixedCosts, targetProfits, salesPrice, variableCosts) {
  
  return((fixedCosts + targetProfits)/(salesPrice - variableCosts))
  
}
