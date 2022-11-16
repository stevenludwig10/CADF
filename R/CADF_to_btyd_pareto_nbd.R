#' @export CADF_to_btyd_pareto_nbd
CADF_to_btyd_pareto_nbd <- function(cadf.data) {
  #repeat purchase only
  dta <- lapply(cadf.data, function(x) tail(x$data, 1))
  dta <- do.call(rbind, dta)
  dta <- dta[c("x", "t.x", "T.cal")]
  rownames(dta) <- NULL
  dta
}