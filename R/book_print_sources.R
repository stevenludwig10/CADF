#' print source list based on search term
#'
#' `book_print_sources` inputs are search term
#'
#' Description here
#'@export book_print_sources


book_print_sources <- function(searchterm) {
  library(bib2df)
  sources <- NULL
  sources <- bib2df::bib2df("sources.bib") 
  ret <- subset(sources, sources$LOCALFILE == searchterm)
  ret <- paste(ret$TITLE, ret$AUTHOR, ret$YEAR)
  
  ret
}