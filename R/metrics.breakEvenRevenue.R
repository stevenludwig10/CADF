#' @export metrics.breakEvenRevenue
metrics.breakEvenRevenue = function(breakEvenVolume, pricePerUnit) {
  
  return(breakEvenVolume - pricePerUnit)
  
}