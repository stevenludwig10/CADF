#data for holdout (0) period

action_no_action_cts <- function(holdout_ds, today){

  print("raw counts, not using model")

  #holdout date
  holdout_ds_a <- holdout_ds[,holdout_ds$targetdonate = 0]

  #num donors

  #AVG donation

  #Standard dev

  #min

  #max


 print( with(holdout_ds, table(RecencyRounded, targetdonate)))
}
