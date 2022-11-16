#example using btyd package

library(BTYD)

cdnowElog <- system.file("data/cdnowElog.csv", package = "BTYD")
  elog <- BTYD::dc.ReadLines(cdnowElog, cust.idx = 2,
                             date.idx = 3, sales.idx = 5)
  elog$date <- as.Date(elog$date, "%Y%m%d");
  elog[1:3,]
  elog <- BTYD::dc.MergeTransactionsOnSameDate(elog);
  end.of.cal.period <- as.Date("1997-09-30")
  elog.cal <- elog[which(elog$date <= end.of.cal.period), ]
  split.data <- dc.SplitUpElogForRepeatTrans(elog.cal);
  clean.elog <- split.data$repeat.trans.elog;
  freq.cbt <- BTYD::dc.CreateFreqCBT(clean.elog);
  freq.cbt[1:3,1:5]
  tot.cbt <- BTYD::dc.CreateFreqCBT(elog)
  cal.cbt <- BTYD::dc.MergeCustomers(tot.cbt, freq.cbt)
  birth.periods <- split.data$cust.data$birth.per
  last.dates <- split.data$cust.data$last.date
  cal.cbs.dates <- data.frame(birth.periods, last.dates,
                              end.of.cal.period)
  
  
  cal.cbs <- BTYD::dc.BuildCBSFromCBTAndDates(cal.cbt, cal.cbs.dates,
                                              per="week")
  params <- BTYD::pnbd.EstimateParameters(cal.cbs = cal.cbs,
                                          hardie = allHardie);
  round(params, digits = 3)
  

  ### btyd data -> CADF format
  
  cdnowElog <- system.file("data/cdnowElog.csv", package = "BTYD")
  elog <- BTYD::dc.ReadLines(cdnowElog, cust.idx = 2,
                             date.idx = 3, sales.idx = 5)
  elog$date <- as.Date(elog$date, "%Y%m%d")
  mid <- max(elog$date) - min(elog$date)
  today <- min(elog$date) + mid/2
  colnames(elog) <- c("ID", "PURCHASE_DATE")
  a <- split(elog, elog$ID)
  cadf.data <- lapply(a, function(x) CADF::Customer$new(x, today=today))
  
  
  modelingdata <- CADF::CADF_to_btyd_pareto_nbd(cadf.data)

