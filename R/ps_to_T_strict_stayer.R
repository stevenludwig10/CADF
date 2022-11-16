

#' Calculates T from a purchase string under the "strict stayer" assumption.  
#' 
#' @param ps Purchase string.
#' @return The numeric value for T, which is the position of the last 1 in the purchase string
#' @export ps_to_T_strict_stayer

#Strict stayer assumes that any inactivity in the customer relationship is a pause.  Does not end the customer relationship.

ps_to_T_strict_stayer <- function(ps) {
  #print(ps)
  
  if(typeof(ps) != "character") {
    return(1)
  }
  
  a <- strsplit(ps, split = '')
  a <- unlist(a)
  a <- as.numeric(a)
  
  if(sum(a) > 0 & is.na(sum(a)) == FALSE) {
    T <- max(which(a == 1))
  } else {
    T <- 0
  }
  
  
  return(T)
}

