data(transactions)
a <- split(transactions, transactions$ID)
a <- Filter(function(x) nrow(x) > 1, a) #repeat-purchaser
cadf.data <- lapply(a, function(x) CADF::Customer$new(x, today=max(transactions$PURCHASE_DATA)))
                                                                   
                                                                   
