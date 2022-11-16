#' @export
LL_opt <- function(grid2) {
  #browser()

  print(c("LL", grid2))
  bars <- ("##############################")


  data_analysis6$LL = apply(data_analysis6[,c('minRecency','id_count', 'targetdonate')], 1, LL, grid2=grid2)
  print(head(data_analysis6, 15))
  print(sum(data_analysis6$LL) * -1)

  print(bars)

  return(sum(data_analysis6$LL) * -1)

  }
#(g0 + g2 * Exp(-1 * g1 * f)) * k ^ r
frequencyPred <- function(x) {
  f_ = x
  g0 <- grid2[2]
  g1 <- grid2[3]
  g2 <- grid2[4]

  return(g0 + g2 * exp(-1 * g1 * f_))
}
