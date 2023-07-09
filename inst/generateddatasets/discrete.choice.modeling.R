#generated discrete choice data
#error term distributed normally
N <- 100
a <- 2
b <- -3
u <- rnorm(N)
x <- runif(N)
y_star <- a + b*x +u
y <- y_star > 0

data(discretechoice)

#look to recover parameters 2 and -3, linear model
model <- glm(y ~ x, data=discretechoice)

#look to recover parameters 2 and -3, probit model, using R method
model <- glm(y ~ x, data=discretechoice, family = binomial(link="probit"))


#McFadden

N <- 10000
X_PRODUCT_A <- cbind(1, matrix(runif(2*N), nrow=N))
X_PRODUCT_B <- cbind(1, matrix(runif(2*N), nrow=N))
u_A <- rnorm(N)
beta <- c(1,-2,3)
y <- X_PRODUCT_A%*%beta - X_PRODUCT_B%*%beta + u_A > 0

model <- glm(y ~ I(X_PRODUCT_A - X_PRODUCT_B),  family = binomial(link="probit"))

#multinominal 3+ choice
set.seed(123456789)
N <- 1000
mu <- c(0,0)
rho <- 0.1
Sigma <- cbind(c(1,rho), c(rho,1))
u <- rmvnorm(N, mean=mu, sigma=Sigma)
x1 <- matrix(runif(N*2), nrow=N)
x2 <- matrix(runif(N*2), nrow=N)
a <- -1
b <- -3
c <- 4
U <- a + b*x1 + c*x2 + u
y <- matrix(0, N, 2)
y[,1] <- U[,1] > 0 & U[,1] > U[,2]
y[,2] <- U[,2] > 0 & U[,2] > U[,1]
W1 <- cbind(x1[,1], x2[,1])
W2 <- cbind(x1[,2], x2[,2])
