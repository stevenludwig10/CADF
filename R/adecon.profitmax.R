




adecon.profitmax <- function() {
  
  # TR = P * Q 
  # TC = FC + VC; TC = AD
  
  template.col.names <- c("product", "category", "p", "q", "FAC", "VAC")
  setNames(data.frame(matrix(ncol = length(template.col.names), nrow = 0)), template.col.names)
  
  # profit max, concave advertising function
  
  # q, depends on advertising effort
  # q = a + b√Ad
  
  # TR = p * q
  # TC = AD
  
  #Profit maximization; TR - TC = 0
  (p*b)/(2*Sqrt(A))-1        
  
  D(A)(p * (a + b*Sqrt(A) )) - A
  
  
  
  
  
}