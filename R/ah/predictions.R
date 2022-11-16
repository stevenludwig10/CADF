#' @export

predictions<- function(x, f_) {

  r = x

  k <- grid2[1]
  g0 <- grid2[2]
  g1 <- grid2[3]
  g2 <- grid2[4]

  return((g0 + g2 * exp(-1 * g1 * f_)) * k ^ r)
}
