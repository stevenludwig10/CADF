#' @export frequency_from_ps


#The CADF toolkit contains a series of "from_ps" functions.  All of these functions are designed to work with purchase strings as long as the purchase strings meet the following condition(s).


frequency_from_ps <- function(x) {
  
  l <- rev(x$lengths)
  v <- rev(x$values)
  
  return(sum(x$lengths[x$values == 1]))
  
}