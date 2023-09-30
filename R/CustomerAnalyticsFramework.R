library(R6)







single_customer_to_CADF <- function(x) {
  return (Customer$new(x))
}





runCompleteFile <- function(transactionFile,  timing = "month") {
  ids <- unique(transactionFile[1][[1]])
  t <- lapply(ids[1:300], runProfileforID, transactionFile)
  return(t)
}





t_to_logisticreg <- function(T) {
  
}

ca_to_logisticreg_df <- function(t) {
  ld <- lapply(t, function(x) x$monthly$logistic_modeling_matrix)
  ld <- do.call(rbind, ld)
  ld <- data.frame(ld)
  colnames(ld) <- c("T", "cancel")
  return(ld)
}



rhat <- function(t, intercept) {
  return(1 - (1/(1 + (exp(-1 * (intercept + t))))))
}








printCustomer<- function(self){
  
  n <- "\n --------------------------------------------------------------- \n"
  s <- "\n"
  

                                   writeLines("--- Customer Analyic Profile ---")
                                   cat("Project Name", self$global$study_name, " Mode:", self$global$mode)
                                     
                                   cat(n)
                                   
                              
                                   
                             
                                   
                                   cat(c("ID: ", self$global$id))
                                   cat(s)
                                   cat(c("Repeat Customer", self$global$repeat_customer))
                                   cat(s)
                                   cat(c("Total Transactions: ", self$monthly$purchase_count))
                                   cat(s)
                                   
                                      cat(c("First Transaction Date:", paste0(self$global$first_purchase_date),
                                        "    |    ",
                                            "Last Transaction Date:", paste0(self$global$last_purchase_date)))
                                  cat(s)
                                   cat(c("Transaction Dates: ", paste0(self$global$transaction_dates)))
                                   cat(n)
                                   
                                  
                                   
                                   cat("The customer can skip ", self$monthly$grace_period, " months and still be considered a customer.  \n")
                                  
                                   cat("Purchase string with grace period: ")
                                  
                                   cat(self$monthly$transaction_string)
                                   cat(s)
                                   
                                
                                   cat("Logistic Regression Modeling Matrix")
                                   cat(n)
                                   
                                   print(self$monthly$logistic_modeling_matrix)
                                   
                                   
                                   invisible(self)
                                 }
                               

