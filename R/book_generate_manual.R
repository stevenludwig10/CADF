#' generates the PDF manual for the R CADF package
#'
#' `book_generate_manual` inputs are search term
#'
#' Description here
#'@export book_generate_manual
#'@returns PDF documentation

book_generate_manual <- function() {
  setwd("/home/sludwig/Documents/CA22")
  library(devtools)
  library(R6)
  devtools::document()
  devtools::build_manual()
}