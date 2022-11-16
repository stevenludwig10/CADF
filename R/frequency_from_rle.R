#' @export frequency_from_rle


frequency_from_rle <- function(x) {
  
  l <- rev(x$lengths)
  v <- rev(x$values)
  
  return(sum(x$lengths[x$values == 1]))
  
}