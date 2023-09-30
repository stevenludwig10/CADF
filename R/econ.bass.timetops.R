#' @export adecon.bass.timetops
adecon.bass.timetops <- function(bass_model) {
  
  return(
    
    as.numeric((log(bass_model$q) - log(bass_model$p))
               / (bass_model$p + bass_model$q)))
  
  
}