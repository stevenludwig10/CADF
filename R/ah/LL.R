

LL2 <- function(grid2, rec, freq, targetBuy) {

  


  k <- grid2[1]
  y0 <- grid2[2]
  y1 <- grid2[3]
  y2 <- grid2[4]

  LLalt = targetBuy * log((y0 + y2 * exp(-1 * y1 * freq)) * k ^ rec) + (1 - targetBuy) * log(1 - (y0 + y2 * exp(-1 * y1 * freq)) * k ^ rec)
  LLalt = as.numeric(LLalt)
  return(sum(LLalt))

}
