#' @export econ.optprice.lineardemand


#' Return optimal price for a linear demand curve
#'
#' `econ.optprice.lineardemand` returns .....
#'
#' Description here


econ.optprice.lineardemand = function(MRP, VC) {
  #max reservation price MRP
  #variable cost VC

  return((MRP+VC)/2)
  
}

