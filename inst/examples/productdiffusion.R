data(answeringmachines)
bass.answeringmachines
model <- adecon.bass.linearized(bass.answeringmachines$sales)
model$bass.sales_at_peak
model$bass.time_to_peak_sales
plot(model$model$sales)
lines(predict(model))

