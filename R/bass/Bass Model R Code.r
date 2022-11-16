#Bass model R code
#Source for code is
#Introductory Time Series with R
# Andrew V. Metcalfe and Paul S.P. Cowpertwait (Chapter 3 - Forecasting Strategies)
##############################################################


#used to quantify the adoption and diffusion of a new product by society
#m = the total number of people who eventually buy the product
#p = the coefficient of innovation
#q = the coefficient of imitation 


T = 1:10
Tdelt = (1:100) / 10

transactions <- c(840,1470,2110,4000, 7590, 10950, 10530, 9470, 7790, 5890)
innovation = .03
imitation = .38
initialBase = 60000

bass_diffusion_model <- function(innovation, imitation, initialBase, transactions) {


Bass.nls <- 
nls(transactions ~ 
M *  ( 

     (
	 (P+Q)^2 
	  / P
	  )
               *
					(
					(exp(-1* (P+Q) * T) ) /
					((1+(Q/P)*exp(-1*(P+Q)*T))^2)
					)
    )
, start = list(M=initialBase, P=innovation, Q=imitation))

summary(Bass.nls)

#extract the coefficient of innovation (p)
coefficients = coef(Bass.nls)
p = coefficients[2]
m = coefficients[1]
q = coefficients[3]

print(p)
print(m)
print(q)

bass_model = list(p = p, m = m, q = q)
return(bass_model)

}

time_to_peak_sales <- function(bass_model) {

 return(
 
	as.numeric((log(bass_model$q) - log(bass_model$p))
	/ (bass_model$p + bass_model$q)))


}


ngete = exp(-(p+q) * Tdelt)
T79 = 1:9
Tdelt = (1:100) / 10

yearly_Donations = c(840, 1470, 2110, 4000, 7590, 10950, 9470, 7790, 5890)
Cu_donations = cumsum(yearly_Donations)
Bass.nls <- nls(yearly_Donations ~ M * ( ((P+Q)^2 / P) * exp(-(P+Q) * T79) ) /
(1+(Q/P)*exp(-(P+Q)*T79))^2, start = list(M=60630, P=0.03, Q=0.38))
summary(Bass.nls)
#extract the coefficient of innovation (p)
coefficients = coef(Bass.nls)
p = coefficients[2]
m = coefficients[1]
q = coefficients[3]
ngete = exp(-(p+q) * Tdelt)
Bpdf =  m * ( (p+q)^2 / p ) * ngete / (1 + (q/p) * ngete)^2
plot(Tdelt, Bpdf, xlab = "Year from 1979", ylab = "Sales per year", type='l')
points(T79, yearly_Donations)
Bcdf = m * (1 - ngete)/(1 + (q/p)*ngete)
plot(Tdelt, Bcdf, xlab = "Year from 1979", ylab = "Cumulative donations", type='l')
points(T79, Cu_donations)
