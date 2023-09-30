

#' Calculates T from a purchase string.  Custom.
#' 
#' @param ps Purchase string.
#' @param skips Number of non purchase periods that the customer is still considered a customer for.
#' @return The sum of \code{x} and \code{y}.
#' @export ps_to_T_custom

#1 period of inactivity means the customer dies (is not a customer any more)

ps_to_T_custom <- function(ps, skips = 2) {
  #print(ps)
  
  if(typeof(ps) != "character") {
    return(1)
  }
  
  #skips.  Give buyer credit for missed purchases
  for (x in 1:skips) {
    ps <- sub("0", "1", ps)
  }
  
  a <- strsplit(ps, split = '')
  a <- unlist(a)
  a <- as.numeric(a)
  
  a <- rle(a)
  
  if (sum(is.na(a) < 1)) {
    ones <- which(a$values == 1)
    zeros <- which(a$values == 0)
    
    T <- a$lengths[ones][1]
    
  } else  {
    T <- 0
  }
  
  
  return(T)
}

