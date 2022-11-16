#' Function called during Customer$new() (the Customer R6 class) to create purchase string for the customer.
#'
#' @param x Transactional data associated with customer id.  
#' @param id.column  Description goes here. 
#' @param date.column.  Description goes here.
#' @return purchase string in 0/1 format.  Returned as string.

#' @export create.purchase.string
create.purchase.string <- function(x, id.column, date.column, return.mode="") {
  
  x[[date.column]] <- as.Date(x[[date.column]], "%m/%d/%Y")
  
  #one time purchase
  if(nrow(x) == 1) {
    
    if (return.mode == "matrix") {
      return (as.matrix(1))
    }
    
    return ("1")
  }
  
  #repeat buyers
  
  x[["T"]] <- ceiling((as.numeric(x[[date.column]] - min(x[[date.column]])+1))/30)
  
  #multiple purchases on same (FIRST) day
  if(sum(x[["T"]]) == 0) {
    
    if (return.mode == "matrix") {
      return (as.matrix(1))
    }
    
    return ("1")
  }
  
  ps <-x[["T"]]
  ps <- ps[ps > 0]
  ps <- ifelse(ps == 0, 1, ps)
  ps <- unique(ps)
  
  if (length(ps) == 0) {
    return(NA)
  }
  
  ps.template <- min(ps) : max(ps)
  ps.template %in% ps
  
  psMatrix <- as.numeric(ps.template %in% ps)
  
  if (return.mode == "matrix") {
    return (as.matrix(psMatrix))
  }
  
  ps <- paste(psMatrix, collapse = "")
  
  return (ps)
  
}