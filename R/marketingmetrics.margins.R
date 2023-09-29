#' @export marketingmetrics.margins
marketingmetrics.margins = function(costPerUnit, sellingPricePerUnit, type) {
  
  unitMargin = sellingPricePerUnit - costPerUnit
  
  if (type == "%") {return(unitMargin/sellingPricePerUnit)}
  if (type == "num") {return (unitMargin)}
  

}