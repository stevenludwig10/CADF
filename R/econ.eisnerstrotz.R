#' Optimal control modeling.  IN DRAFT format not ready yet
#' @param alpha
#' @param beta
#' @param a
#' @param b
#' @export econ.eisnerstrotzmodel
#' 
#' This will be adapted to use an advertising cost function as follows:

econ.eisnerstrotzmodel <- function(alpha , beta, a, b, rho, k_int) {

    
  
t <- seq(0, 10, by =.5)

#for each value of t, pick a random rate
rates <- seq(0, 1, by = .001)
y <- sample(rates, length(t), replace=TRUE)
y <- c(0.2000, 0.3059, 0.3710, 0.4112, 0.4359, 0.4604, 0.4661, 0.4696, 0.4718, 0.4731, 0.4740, 0.4746, 0.4749,0.4751, 0.4752, 0.4751, 0.4751, 0.4750, 0.4749, 0.4750)
dt <- append(NA, diff(t))
dy <- append(NA, diff(y))

#functional

y <- y[2:length(y)]
dt <- dt[2:length(dt)]
dy <- dy [2:length(dy)]
t <- t[2:length(t)]

F <- (alpha * y - beta * y^2 - a * dy ^ 2 - b * dy) * exp(-1 * 0.05 * t)

library(pracma)

return(t)
  
}