#' @export adecon.indifferencecurvemap
adecon.indifferencecurvemap <- function(x1, k, returnmode="optimal") {
 #U(x1, x2) = (x1 * x2)^.5
  #set U to constant K and solve for x2
  #x2 is returned
  
  #optimal for this indifference curve set up is (k^2 / x1^2).
  
  if(returnmode=="optimal") {
    
    return ((k^2)/ (x1^2))
    
  }
  
  return((k^2) / x1)
}