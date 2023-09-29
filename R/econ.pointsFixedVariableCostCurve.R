#' @export econ.pointsFixedVariableCostCurve
econ.pointsFixedVariableCostCurve = function(quantity, fixedCost, variableCost) {
  
  totalCost = fixedCost + (quantity * variableCost)
  return(totalCost)
  
  
}
