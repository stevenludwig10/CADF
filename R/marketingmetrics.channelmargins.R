#' @export marketingmetrics.channelmargins
marketingmetrics.channelmargins = function(supplierSellingPrice, customerSellingPrice, customerMargin){
  
  #percentage customerMGN
  customerMarginPCT = customerSellingPrice/supplierSellingPrice
  
  supplierSellingPrice = customerSellingPrice - customerMargin
  customerSellingPrice= supplierSellingPrice/(1-customerMarginPCT)
  
  return(customerSellingPrice)
  
}