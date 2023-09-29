#' @export metrics.targetVolume
metrics.targetVolume = function(fixedCosts, targetProfits, salesPrice, variableCosts) {
  
  return((fixedCosts + targetProfits)/(salesPrice - variableCosts))
  
}
