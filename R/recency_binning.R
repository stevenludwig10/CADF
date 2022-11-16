#' Create recency bins

#' Create recency bins
#' @details 
#' Create recency bins

#' @export recency_binning
#' @param x
#' @param max.recency
#' @return string representing categorical value

recency_binning <- function(x, max.recency) {
  
  for(y in 1:3) {
    ifelse(x < y, TRUE, FALSE)
  }
  
}

