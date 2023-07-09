#' @export adecon.budgetcurve
adecon.budgetcurve <- function(productsVector, costsVector, amountsVector, totalBudget) {

  #### 2 choice case
  
  productsVector <- c("pizza", "yogurt")  #quantities
  costsVector <- c(3,1.5)
  
  total_budget <- 45
  price_x <- 3
  price_y <- 1.5
  
  for(i in 1:length(productsVector)) {
    eq[i] <-  paste("(" , costsVector[i], "*" ,productsVector[i], ")", sep="")
  }
  

  
  eq <- paste(eq, collapse="+")
  
  #complete budget constraint
  cbc <- paste(total_budget , "==", eq)
  
  #good 1
  cbc_solve <- paste("Solve(", cbc, "," , productsVector[1], ")")
  eq.solved <- yac_str(cbc_solve)
  eq.solved <- gsub("}", "" ,eq.solved)
  eq.solved <- gsub("[{]", "" ,eq.solved)

  test <- yac_str("(45-1.5*yogurt)/3")
  eq.expr <- yac_expr(test)
  
  eval(eq.expr, envir=list(pizza=0:200, yogurt=200:0))
  

  
  
  
  ####
  
  return(1)
  
}