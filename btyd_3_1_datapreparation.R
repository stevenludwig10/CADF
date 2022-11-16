#' @export bytd_3_1_datapreparation 

btyd_3_1_datapreparation <- function() {
  cdnowElog <- system.file("data/cdnowElog.csv", package = "BTYD")
  elog <- dc.ReadLines(cdnowElog, cust.idx = 2, date.idx = 3, sales.idx = 5)
  elog$date <- as.Date(elog$date, "%Y%m%d")
  elog <- dc.MergeTransactionsOnSameDate(elog)
  end.of.cal.period <- as.Date("1997-09-30")
  elog.cal <- elog[which(elog$date <= end.of.cal.period), ]
  split.data <- dc.SplitUpElogForRepeatTrans(elog.cal)
  clean.elog <- split.data$repeat.trans.elog
  freq.cbt <- dc.CreateFreqCBT(clean.elog)
  tot.cbt <- dc.CreateFreqCBT(elog)
  cal.cbt <- dc.MergeCustomers(tot.cbt, freq.cbt)
  birth.periods <- split.data$cust.data$birth.per
  last.dates <- split.data$cust.data$last.date
  cal.cbs.dates <- data.frame(birth.periods, last.dates,
                              end.of.cal.period)
  cal.cbs <- dc.BuildCBSFromCBTAndDates(cal.cbt, cal.cbs.dates,
                                        per="week")
  
  return (cal.cbs)
}
