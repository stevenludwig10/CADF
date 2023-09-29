#' @export econ.fitmodel.translog
#marketing mix interactions
#translog model - generalization of Cobb-Douglas
#"transcendental logarithmic"


#source 1: "Design of Static Response Models, Market Response Models, pg. 115
#source 2: 
#Arne Henningsen (2010). micEcon: Microeconomic Analysis and Modelling.
#R package version 0.6-6. http://CRAN.R-project.org/package=micEcon

#translog - is a generalization of the Cobb-Douglas production function
#takes labor/capital/materials as input
#output is q
#used to model interactions
yval = c("")
xvals = c("" , "", "")  
library(micEcon)
econ.fitmodel.translog = function(data, yval, xvals) {
  library(micEcon)
  
  plot(data.frame(1:nrow(data)), data[yval])
  
  model = translogEst(yval, xvals, data)
  
  fittedData = data.frame(model$fitted)
  
  lines(fittedData$model.fitted)
  
  return(model$fitted)
  
  #estResult$coef
  #estResult$r2
}