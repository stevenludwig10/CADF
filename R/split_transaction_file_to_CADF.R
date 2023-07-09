
#' @export split.transaction.file_to_CADF
split.transaction.file_to_CADF <- function(data, today.study.cutoff) {
  a <- lapply(data, id_to_CADF, today.study.cutoff)
  return (a)
}