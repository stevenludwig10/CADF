#' For each customer, return a modeling matrix that is utilized for logistic regression
#'
#' `f_CustomerModelingMatrix` inputs are T.
#'
#' Description here
#' @examples
#' f_CustomerModelingMatrix(10)
#' @export f_CustomerModelingMatrix
#' @field T = cancellation time
f_CustomerModelingMatrix = function(T) {
  
  t_ELT = T-1 #time_effective_last_transaction
  t_EA = T #time_of_attrition.  This may be estimated based on XYZ setting.
  
  d <- matrix(data = NA, nrow = t_EA, ncol=2)
  
  d[,1] = 1:nrow(d)
  
  d[,2][1:t_ELT] = 0
  d[,2][t_EA] = 1
  return(d)
  
}