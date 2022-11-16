
#' Builds dataset for a migration model from CADF customer profiles.
#' T is the maximum time cutoff which defaults to 3.   The output matrix will be a t by t transition matrix
#' 
#' `ds.migration.model` generates a transaction matrix for a migration model
#'
#' purchase strings are input as a 1 x 1 character matrix
#' Y represents buy; N represents no buy

#' @param T Number of timeperiods (size of matrix)
#' @param cadf_data  Data in R list format processed by CADF functions


#' @export CADF_to_migration_model
CADF_to_migration_model <- function(dta) {
  #analysis dataset
  dta <- lapply(cadf.data, function(x) tail(x$data, 1))
  dta <- do.call(rbind, dta)
  t <- table(floor(dta$recency.studyperiod.years), dta$target.buy)
  
  
  
  t <- prop.table(t, 1)
  

  
  #create the transition matrix
  n <- length(unique(floor(dta$recency.studyperiod.years)))
  
  trans.mtx <- matrix(nrow = n, ncol = n)
  
  for(i in 1:n) {
     trans.mtx[i, 1] <- t[i, 1]
    
    if(i == 1) {
      trans.mtx[i, 2] <- t[i, 2]
      trans.mtx[i, 3:n] <- 0
    }
    
    #middle rows
    if(i >  1 && i < n){
      trans.mtx[i, i+1] <- t[i, 2]
 
    }
    
    #last row
    if(i == n) {
      trans.mtx[i, n] <- t[i,2]
    }
    
   
  }
  
  trans.mtx
  
}