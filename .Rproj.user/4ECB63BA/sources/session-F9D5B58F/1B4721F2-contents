data(transactions)
a <- split(transactions, transactions$ID)
a <- Filter(function(x) nrow(x) > 2, a)
b <- sample(1:length(a), 1)
 a[[b]]
cust <- Customer$new(a[[b]])
cust$data
cust$first_purchase_date
cust$last_purchase_date
cust$transaction_months
cust$purchase_string



### create logistic modeling matrix
data(transactions)
a <- split(transactions, transactions$ID)
a <- Filter(function(x) nrow(x) > 1, a) #repeat-purchaser
cadf.data <- lapply(a, function(x) CADF::Customer$new(x))
logistic.data <- CADF::CADF_to_logistic_regression(cadf.data)


#retention rate

CADF::ca_SRM(logistic.data)


#pick random entry and data check
s <- cadf.data[[sample(1:length(cadf.data),1)]]
s$data
s$logistic_modeling_matrix
logistic.data <- CADF_to_logistic_regression(s)






