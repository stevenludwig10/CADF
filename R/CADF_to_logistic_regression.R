#' @export CADF_to_logistic_regression
CADF_to_logistic_regression <- function(CADF) {
  a <- lapply(CADF, function(x) x$logistic_modeling_matrix)
  logistic.data <- do.call(rbind, a)
  logistic.data <- data.frame(logistic.data)
  colnames(logistic.data) <- c("T", "cancel")
  logistic.data
}