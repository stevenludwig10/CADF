#' LD functions are utilized for learning and diagnostic use.
#' @export ld_sample_customer_matrix
#' @param numCustomers number of customers to simulate
#' @param maxT number of timeperiods
#' @param purchaseAtT0 by default sets first column of matrix to 1 
ld_sample_customer_matrix <- function(numCustomers, maxT, purchaseAtT0 = TRUE){
  a <- matrix(nrow = numCustomers, ncol =maxT)
  a <- apply(a, c(1:2), function(x) sample(c(0,1),1))
  if (purchaseAtT0 == TRUE) {
    a[ , 1] <- 1 }
  a
}