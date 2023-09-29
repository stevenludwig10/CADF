

#' @export modeling.LL.gamma_spend
modeling.LL.gamma_spend <- function (p, q, gamma , y=data) {
  #source http://www.brucehardie.com/notes/025/gamma_gamma.pdf
  
  x <- as.numeric(y[,2])
  m.x <- as.numeric(y[,1])
  
  ll1 <- q * log(gamma) + (p * x - 1) * 
    log(m.x) + (p * x) * log(x) - 
    (p * x + q) * log(gamma + m.x * x)
  
  ll2 <- (-lbeta(p * x, q) + ll1)
  
  return (-sum(ll2))
  
  
}