
#' @export print.glossary
print.glossary <- function() {
  g <- list()
  g[["ID"]] <- "The customer identifier"
  g[["Purchases"]] <- "List of purchase dates in DATE format"
  g[["first purchase date"]] <- "Customer's first purchase date"
  g[["last purchase date"]] <- "Customer's last purchase date"
  
  g["cutoff date"] <- "Separates analysis and holdout"
  g["months rounded"] <- "Months between first purchase date and transaction date
rounded up to nearest integer."
  g["weeks rounded"]  <- "test"    
  g["repeat customer"] <- "N if only purchase is on first purchase date; Y otherwise."
  g["purchase string"]  <- "String.  Y if purchase N if not.  Example:  YYNNY.  At time 5; R = 0; F = 3"
  g["consecutive transactions"] <- "test"
  g["first month lapsed"] <- "Substitutes in a purchase if the consumer lapses for one month"
  g["second month lapsed"] <- "Substitues in a purchase if the consumer lapses for a second month"
  g["third month lapsed"] <- "Substitues in a purchase if the consumer lapses for a third month"
  
  g["R"] <- "Recency, defined as last transaction date in file - last purchase date"
  g["F"] <- "Frequency, defined as a count of distinct dates in purchases"
  g["M"] <- "Total sales"
  
  
  cat("\\begin {description}")
  cat("\\begin {itemize} \n")
  
  for (i in names(g)) {
    term <- names(g[i])
    definition <- g[i][[1]]
    cat("\\item [", term, "] ", definition, "\n", sep="")
  }
  
  cat("\\end {itemize} \n")
  cat("\\end {description} \n")
  
}
