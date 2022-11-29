#' R6 Class representing a customer.  Otherwise known as the CADF.
#'
#' Call Customer$new() to convert transactional data to CADF format
# Common ways that this class is used.
# 1.) Load transactional data.  Make sure to format dates and only pull ID and prchase date
# If you are testing send a single customerid and data for a single customer to id_to_CADF.
# If your data contains multiple customer id's
# 2.) Split the data from 2 using the R split function
# 3.) Call -> split.transaction.file_to_CADF

#' @param ... All arguements in list
#' @export
Customer <- R6::R6Class(
  "Customer",
  public = list(
    #' @field output Stores all information in R format at the customer level.
    output = NULL ,
    
    #'@field payload Stores all computed customer information in JSON format.  This is not quite an API but designed so that customer information can be imported to other formats and systems.
    payload = NULL,
    
    #'@field data a data frame that stores purchase information for a single customer.  Input data for various calculations in intialize (df_customer)
    data = NULL,
    
    #' @field id The customer id.  This will be the same ID as provided in the input transaction file.
    id = NULL,
    
    #' @field study_name.  A name to associate with the cohort study.#The name can be whatever is easiest to associate with the set of customer id and dates included in
    #' the analysis.
    study_name = "Customer Study",
    
    #' @field study_begin_date  Begin date of the customer study.  In theory this should be min(TRANSACTION_DATE) for each customer in the dataset.
    study_begin_date = NULL,
    
    #' @field timing.
    #' Monthly timing computes T as months. Most commonly utilized and is the default.
    timing = NULL,
    
    #' @field transaction_dates.  Description goes here
    transaction_dates = NULL,
    
    #' @field transaction_months.  Description goes here
    transaction_months = NULL,
    
    #' @field first_purchase_date.  First purchase date for the customer.
    first_purchase_date = NULL,
    
    #'@field last_purchase_date.  Last purchaes date for the customer.
    last_purchase_date = NULL,
    
    
    repeat_customer_by_day  = NULL,
    
    #' #' @field repeat_customer.  Marked yes if the following conditions
    #' are true.  The customer has more than one transaction.  The second transaction
    #' date is greater than the first transaction date.
    repeat_customer = NULL ,
    
    #'  #' @field  T a measure of time between first date of activity and purchase.
    T  = NULL,
    
    T_ss = NULL,
    
    T_custom = NULL,
    
    #' @field transaction_range_complete  shows a consecutive sequence usually beginning at 1 to madf_customerimum T
    transaction_range_complete = NULL,
    
    

    
    
    
    
    #' @field purchase_count purchase count
    purchase_count = NULL,
    
    
    #' @field purchase_string
    purchase_string = NULL,
    
    #' @field purchase_string_as_matrix
    purchase_string_as_matrix = NULL,
    
    #' @field Freq
    Freq=NULL,

    
    #' @field logistic_modeling_matrix Stores customer's logistic modeling matrix.  (One row for each time period (T), 1 = purchase; 0 = no purchase)
    logistic_modeling_matrix = NULL,
    
    logistic_modeling_matrix_ss = NULL,
    
    logistic_modeling_matrix_custom = NULL,
    
    #' @description
    #' Creates a CADF profile for a given customer
    #' based on the input transactional data
  
    #' @return A new `Customer` object.  Converted transactional data to CADF format.
    #' To access cadf[[1]], etc...
    #' Represents customer data (for a particular id) in the "CADF" format
    initialize = function(df_customer = NA, today = NA) {
    
      stopifnot(CADF::qc_transactional_data(df_customer) == 2)
  
      # figure out how to handle the today arguement if it is missing
      
      #' @field df_customer$Tdays df_customer data frame column:  to compute "days from first purchase"
      df_customer$Tdays <- ceiling(as.numeric(df_customer[[2]] - min(df_customer[[2]])))
      
      #' @field df_customer$month_yr date converted to YYYY_MM format
      df_customer$month_yr <- format(as.Date(df_customer[[2]]), "%Y-%m")
      
      #' @field df_customer$Tmonths Number of months between purchase date and first purchase date.  Rounded up to nearest month
      df_customer$Tmonths <- ceiling(as.numeric(df_customer[[2]] - min(df_customer[[2]])) / 30)
      
      df_customer$purchase.num <- 1:nrow(df_customer)
      
      
      #to compute "weeks from first purchase
      df_customer$yr_week = paste(format(as.Date(df_customer[[2]]), "%Y") , "_" , format(as.Date(df_customer[[2]]), "%V"),
                                  sep ="")
      df_customer$Tweeks <- as.numeric(df_customer[[2]] - min(df_customer[[2]])) / 7
      
      #migration (non-contractual) modeling (last row fed to modeling dataset)
      df_customer$today <- today  #separate holdout and analysis dataset
      df_customer$diff.years <- (df_customer$today - df_customer$PURCHASE_DATE) / 365.25
      df_customer$target.buy <- ifelse(df_customer$diff.years < 0, 1, 0)  #1 means holdout period
      df_customer$target.buy <- factor(df_customer$target.buy, levels = c("1", "0"))
      df_customer$Frequency.baseperiod <- nrow(df_customer[df_customer$target.buy ==0,]) ## holdout frequency, ## target frequency
      df_customer$Frequency.holdout <- nrow(df_customer[df_customer$target.buy == 1,])
      
      
      #btyd modeling (weeks)
      df_customer$x <- df_customer$Frequency.baseperiod
      df_customer$t.x <- (df_customer$today - df_customer$PURCHASE_DATE) / 12
      df_customer$T.cal <- as.numeric(today - min(df_customer$PURCHASE_DATE)) / 7
      
      minpositive = function(x) min(x[x > 0])
      df_customer$recency.studyperiod.years <- minpositive(df_customer$diff.years)
     
      
      #sort for output 
      df_customer <- df_customer[order(df_customer[[2]]), ]
    
      
      #'@field id the customerid which identifies the customer in the CADF class.  
      self$id = min(df_customer[, 1])
      
      #' @field  transaction_dates All unique transaction dates for customer
      self$transaction_dates <- unique(df_customer[, 2])
      
      #' @field transaction_months  All unique YYYY_MM combinations for customer transactions.  This is used for building purchase strings.
      self$transaction_months <- unique(df_customer$month_yr)
      
      self$first_purchase_date <- min(df_customer[, 2])
      self$last_purchase_date <- max(df_customer[, 2])
      
      
      #' @field repeat_customer This can be used to filter out repeat customers from analysis.  Repeat customer based on YYYY_MM.  (Customer with only two purchases in January would not be a repeat customer)
      self$repeat_customer <-
        ifelse(length(unique(self$transaction_months)) > 1, "Y", "N")
      
      #' @field repeat_customer_by_day Same as repeat_customer however it's by day instead of YYYY_MM.
      self$repeat_customer_by_day <-
        ifelse(length(unique(self$transaction_dates)) > 1, "Y", "N")
      

      
      
      self$transaction_dates = format(self$transaction_dates, "%Y_%m")
      self$purchase_count = length(unique(self$transaction_dates))  #monthly count
      
      #' PURCHASE STRINGS
      
      #' @field purchase_string Utilizes the 'create.purchase.string' function to create a purchase string.  "1" if purchase was made during the
      #' purchase period; "0" otherwise.  No special rules are applied and the purchase string reflects true purchase history.
      #' df_customer:  data frame for single customer, id column, purchase date column
      self$purchase_string <-
        create.purchase.string(df_customer, names(df_customer[1]), names(df_customer[2]))
      self$purchase_string_as_matrix <-
        create.purchase.string(df_customer, names(df_customer[1]), names(df_customer[2]), return.mode = "matrix")

      self$Freq <- nchar(self$purchase_stringF)  #number of purchase periods

      self$transaction_range_complete <- nchar(self$purchase_string)
      #' @field T T is a cancellation time.  CADF offers different ways to estimate the cancellation time
      #' strict_quitter:  Customer leaves after first period of inactivity.  Example purchase string 11001.  T=3
      #' strict_stayer:   T is the last period of transaction in the purchase string. 11001.  T=5
      #' As T becomes longer strict_quitter will have a tendancy to underestimate retention.  Strict_stayer will have a tendancey to overestimate
      #' If you know your customers come and go at free will you can utilize a Migration model or choose T between strict quitter and strict stayer
      #' 
      self$T <- ps_to_T_strict_quitter(self$purchase_string)  
      self$T_ss <- ps_to_T_strict_stayer(self$purchase_string)
      self$T_custom <- ps_to_T_custom(self$purchase_string)
      

      
   
      
      #' @field logistic_modeling_matrix  Stores rows for the customer that contribute to a logistic modeling matrix.
      #' Assumes strict/perm cancellations.  Customer relationship starts at time 1 and ends at time N (with perm cancellation and no pauses in between)
      #' This is usually known as a contractual relationship 
      self$logistic_modeling_matrix <- f_CustomerModelingMatrix(self$T)
      
      #' @field logistic_modeling_matrix_sc Assumes strict stayer assumption
      self$logistic_modeling_matrix_ss <- f_CustomerModelingMatrix(self$T_ss)
      
      #' $field logistic_modeling_matrix_custom
      self$logistic_modeling_matrix_custom <- f_CustomerModelingMatrix(self$T_custom)
      
      
      #cleanup and data storage
      #empty working df_customer data frame and place the result in the class, name it 'data'
      self$data <- df_customer
      df_customer <- NULL
      self$output <- list(c(self$global, self$monthly))
      self$payload <- jsonlite::toJSON(self$output)
      
      
    }
    
    
  )
)