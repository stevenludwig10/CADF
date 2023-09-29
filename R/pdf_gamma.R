
#' @export pdf_gamma

#k > 0 shape
#θ > 0 scale

#r = shape
#a = scale
pdf_gamma <- function(x, r, a) {
  #formula source http://www.brucehardie.com/talks/supp_mats00.pdf
  
  f <- ((a^r) * (x^(r-1)) * exp(-a * x))/gamma(r)
  return(f)
}
