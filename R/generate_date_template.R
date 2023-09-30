#' 
#' @export generate_date_template

generate_date_template <- function() {
  monthsYears <- seq(as.Date("1990/1/1"), as.Date("2030/1/1"), "months")
  monthsYears <- format(lubridate::parse_date_time(monthsYears, orders = c("Y-m-d")), "%m-%Y")
}