model_results() <- function(){

  a <- c("Decay rate is:" , grid2[1])

  b <- c("Transaction probability at maximum frequency" , grid2[2])

  tab <- data.frame(a,b)
  colnames(tab) = NULL
  rownames(tab) = NULL

  pdf("ModelResults.pdf")
  print(tab)
  dev.off()

}
