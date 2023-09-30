
#' Input must be attr(v3, "class")
#' The following function takes an R rle object as input.  Rle is base R functionality and information can be found by ?rle.
#' Rle can be ran on a vector of 1/0 to determine the number of time periods spent in each state.  This function reverses the information returned from rle.  If the streak ends in 0 (x$values = 0) then the value (x$lengths) associated with zero is returned.  Otherwise, 0 is returned.  The streak of zeros tells us the recency.  Larger numbers equal more latency between purchases.
#' @export recency_from_rle
recency_from_rle <- function(x) {

  l <- rev(x$lengths)
  v <- rev(x$values)
  
  if(v[1] == 0) {
    #no-buy
    return(l[1])
  }
  
  if(v[1] == 1) {
    return(0)
  }
  
  #exterior case
  return(NA)
  
}

