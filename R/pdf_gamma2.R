
#' @export pdf_gamma2

#k > 0 shape
#θ > 0 scale

#r = shape
#a = scale
pdf_gamma2 <- function(x, shape, scale) {
  k <- shape
  theta <- scale
  
  part1 <- (1 / (gamma(k)*(theta^k)))
  part2 <- x^(k-1)
  part3 <- exp(-x/theta)
  
  return(part1 * part2 * part3)
}
