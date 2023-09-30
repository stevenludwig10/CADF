

#' accepts a psmatrix
#' converts 1/0 purchase strings to recency at timeof
#' @export 

psmatrix_to_recency_attimeof_matrix <- function(psmatrix) {
  
  rec_ato_matrix <- matrix(nrow = nrow(psmatrix), ncol = ncol(psmatrix))
  
  for (i in 1:nrow(psmatrix)) {
    for (j in 1:ncol(psmatrix)) {
      rec_ato_matrix[i,j] <- recency_from_rle(rle(psmatrix[i, i:j]))
    }
  }

  return(rec_ato_matrix)
    
  
}