annualhalfingmodel <- function(x, grid2) {
  dta <- lapply(cadf.data, function(x) tail(x$data, 1))
  dta <- do.call(rbind, dta)
  
  
  rec = x["minRecency"]
  freq = as.numeric(x["id_count"])
  targetBuy = as.numeric(x["targetdonate"])
  
  print("LL")
  
  
  print(grid2)
  
  k <- grid2[1]
  y0 <- grid2[2]
  y1 <- grid2[3]
  y2 <- grid2[4]
  
  LLalt = targetBuy * log((y0 + y2 * exp(-1 * y1 * freq)) * k ^ rec) + (1 - targetBuy) * log(1 - (y0 + y2 * exp(-1 * y1 * freq)) * k ^ rec)
  LLalt = as.numeric(LLalt)
  return(LLalt)
  
}