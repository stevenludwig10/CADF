
#' @export split.transaction.file_to_CADF
split.transaction.file_to_CADF <- function(data, timing = "month") {
  a <- lapply(data, id_to_CADF)
  return (a)
}