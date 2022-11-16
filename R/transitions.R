#' Calculate transition periods between two timeperiods


#' @export transitions
# a represents timeperiod0 and b represents timeperiod1
# Function works with CADF.  CADF labels buy as "Y" nobuy as "N" so these values are hardcoded
# works on 2 period transitions only

#' @param timeperiod0  Column representing the 'from' side of the transition probability
#' @param timeperiod1  Column representing the 'to' side of the transition probability
#' @param byvar field value that represents a buy, defaults to Y
#' @param nobuyvar field value that represents not buy, defaults to N

#' @returns 2 x 2 transaction matrix

transitions <- function(timeperiod0 , timeperiod1, buyvar = "Y", nobuyvar = "N") {
  r <- matrix(nrow = 2, ncol=2)
  
  #buy -> buy
  r[1,1] <-  sum(timeperiod0 == buyvar & timeperiod1 == buyvar, na.rm=T) / length(timeperiod0)
  
  #buy -> no buy
  r[1,2] <- sum(timeperiod0 == buyvar & timeperiod1 == nobuyvar, na.rm=T) / length(timeperiod0)
  
  #no buy -> buy (reactivated)
  r[2,1] <- sum(timeperiod0 == nobuyvar & timeperiod1 == buyvar, na.rm=T) / length(timeperiod0)
  
  #no buy -> no buy
  r[2,2] <- sum(timeperiod0 == nobuyvar & timeperiod1 == nobuyvar, na.rm=T) / length(timeperiod0)
  
  return(r)
  
}
