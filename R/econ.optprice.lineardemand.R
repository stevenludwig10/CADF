#' @export econ.optprice.lineardemand
econ.optprice.lineardemand = function(MRP, VC) {
  #max reservation price MRP
  #variable cost VC

  return((MRP+VC)/2)
  
}

