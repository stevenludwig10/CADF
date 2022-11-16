

#' Calculates T from a purchase string
#' 
#' @param ps Purchase string.
#' @return The sum of \code{x} and \code{y}.
#' @export ps_to_T_strict_quitter

#1 period of inactivity means the customer dies (is not a customer any more)

ps_to_T_strict_quitter <- function(ps) {
  #print(ps)
  
  if(typeof(ps) != "character") {
    return(1)
  }
  
  a <- strsplit(ps, split = '')
  a <- unlist(a)
  a <- as.numeric(a)
  
  #gp1 <- which(a == 0)[[1]]
  #gp2 <- which(a == 0)[[2]]
  
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

