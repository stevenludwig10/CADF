book_generate_TOC <- function() {
  library(knitr)
  opts_chunk <- NULL
  opts_chunk$set(list(echo = FALSE, eval = FALSE))
  a <- knitr::knit("CustomerAnalyticsCH1CH2.Rmd")
  b <- knitr::knit("CustomerAnalytics3Plus.Rmd")
  x <- scan(a , what="", sep="\n")
  y <- scan(b, what="", sep="\n")
  z <- c(x,y)
  z <- z[grepl("^#.*", z)]
  return(z)
}

