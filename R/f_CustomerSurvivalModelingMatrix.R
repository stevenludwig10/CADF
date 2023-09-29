#' For each customer, return a survival modeling matrix that is utilized for survival analysis
#'
#' `f_CustomerSurvivalModelingMatrix` inputs are T.
#'
#' Description here
#' @examples
#' f_CustomerSurvivalModelingMatrix(10)
#' @export f_CustomerSurvivalModelingMatrix
#' @field T = cancellation time
f_CustomerSurvivalModelingMatrix = function(T) {
  
  # T is the time that the last transaction occurs
  
  t_ELT = T+1 #time_effective_last_transaction.  Period after last known transaction time.
  t_EC = T # time periods of purchase (or censoring)
  
  d <- matrix(data = NA, nrow = t_ELT, ncol=2)
  
  #Time column of matrix
  d[,1] = 1:nrow(d)
  
  #Activity indicator 0 = customer; 1 = cancelled
  d[,2][1:t_ELT] = 1
  d[,2][1:t_EC] = 0
  return(d)
  
}