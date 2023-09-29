#' @export bass_diffusion_model

bass_diffusion_model <- function(innovation, imitation, initialBase, transactions) {
  
  
  Bass.nls <- 
    nls(transactions ~ 
          M *  ( 
            
            (
              (P+Q)^2 
              / P
            )
            *
              (
                (exp(-1* (P+Q) * T) ) /
                  ((1+(Q/P)*exp(-1*(P+Q)*T))^2)
              )
          )
        , start = list(M=initialBase, P=innovation, Q=imitation))
  
  summary(Bass.nls)
  
  #extract the coefficient of innovation (p)
  coefficients = coef(Bass.nls)
  p = coefficients[2]
  m = coefficients[1]
  q = coefficients[3]
  
  print(p)
  print(m)
  print(q)
  
  bass_model = list(p = p, m = m, q = q)
  return(bass_model)
  
}