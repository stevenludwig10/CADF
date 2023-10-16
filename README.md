Using CADF to Prepare Customer Analytic Datasets
================

``` r
library(CADF)
#> 
#> Attaching package: 'CADF'
#> The following object is masked _by_ '.GlobalEnv':
#> 
#>     f_CustomerSurvivalModelingMatrix
library(survival)
```

# Introduction

Why we need standardized processes for customer analytic data
preparation. Data quality stats from Forrester [^1]

- 37% of marketers waste spend due to poor data quality
- 35% suffer from inaccurate targeting
- 30% have lost customers due to bad data

This package accompanies my customer analytics R book. The book is still
in draft form and a table of contents preview is available
[here](https://1drv.ms/b/s!AsKU-g_cimuplJs-7pC9L92zLG5H-w?e=eKJM3c).

Most recent developments for the CADF R packages can be found here:
<a href="#0" class="uri">https://github.com/stevenludwig10/CADF</a>

## Process

CADF stands for **C**ustomer **A**nalytics **D**ata **F**ormat. Here is
how it works.

1.) Prepare your transaction data to account for purchases, returns and
the correct transaction data inclusion. This may require working with
source system teams like SAP or your accounting teams. It may require
implementing or working with a customer data platform.

2.) Define segments of customers that you wish to process analytic
datasets for.

3.) Run CADF for each segment. This packages is still in beta. Once
finished it will automatically create an series of analytic datasets for
each segment.

## How it Works

CADF works by utilizing a split-apply-combine approach to data mining.^
<https://www.jstatsoft.org/article/download/v040i01/468>. I do not
follow Hadley’s approach exactly but more out of principle.

1.) Split data by customer id into thousands of R lists.

2.) Use R6 class to process data for each customer id. (This is called
putting the data in CADF format.)

3.) Recombine the data into analytic datasets.

Prepare transactional data -\> Split data by customer id -\> Run CADF on
each customer -\> Reassemble customer level data into cohort level data
for modeling.

# (1) Split Transactional Data by Customer ID

Here are the steps to translate transactional data to CADF.

- Load transaction data
- Pick only customer id and purchase date
- Check data types (should be date and string or int)

``` r

data(transactions)
transactions.filtered <- transactions[, c("ID", "PURCHASE_DATE")]
str(transactions.filtered)                             
#> 'data.frame':    69659 obs. of  2 variables:
#>  $ ID           : int  1 2 2 3 3 3 3 3 3 4 ...
#>  $ PURCHASE_DATE: Date, format: "1997-01-01" "1997-01-12" "1997-01-12" "1997-03-02" ...
```

- Split the data by customer id
- Look at customer 400 as example

``` r

transactions.splitted <- split(transactions.filtered, transactions.filtered$ID)
```

\#(2) Apply - process the data

Run the CADF process. Split.transaction.file_to_CADF processes each
customer. The second arguement can be used if your data contains
training and test instances. This example assumes 0 testing data.

``` r

cadf <- split.transaction.file_to_CADF(transactions.splitted, max(transactions$PURCHASE_DATE))
```

Here is the CADF profile (R6 class) for customer 400. The R6 class
contains all the different data points that can be used for customer
analytic modeling.

``` r

cadf["400"]
#> $`400`
#> <Customer>
#>   Public:
#>     clone: function (deep = FALSE) 
#>     data: data.frame
#>     first_purchase_date: 1997-01-02
#>     Freq: 
#>     id: 400
#>     initialize: function (df_customer = NA, today = NA) 
#>     last_purchase_date: 1998-03-07
#>     logistic_modeling_matrix: 1 2 3 0 0 1
#>     logistic_modeling_matrix_custom: 1 2 3 4 5 6 7 0 0 0 0 0 0 1
#>     logistic_modeling_matrix_ss: 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 0 0 0 0 0 0 0 0 0 0  ...
#>     output: list
#>     payload: [{}]
#>     purchase_count: 8
#>     purchase_string: 111010100001101
#>     purchase_string_as_matrix: 1 1 1 0 1 0 1 0 0 0 0 1 1 0 1
#>     repeat_customer: Y
#>     repeat_customer_by_day: Y
#>     study_begin_date: NULL
#>     study_name: Customer Study
#>     survival_modeling_matrix: 1 2 3 4 0 0 0 1
#>     survival_modeling_matrix_custom: 1 2 3 4 5 6 7 8 0 0 0 0 0 0 0 1
#>     survival_modeling_matrix_ss: 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 0 0 0 0 0 0 0 0 0 ...
#>     T: 3
#>     T_custom: 7
#>     T_ss: 15
#>     timing: NULL
#>     transaction_dates: 1997_01 1997_02 1997_03 1997_05 1997_07 1997_12 1997_12  ...
#>     transaction_months: 1997-01 1997-02 1997-03 1997-05 1997-07 1997-12 1998-01  ...
#>     transaction_range_complete: 15
```

\#(3A) Recombine the data for Interesting Statistical Analysis

## Getting Customers’ nth Purchase

Returns a numeric vector. Each entry is the time, in weeks, for each
customers nth purchase. The function is ran for 3rd purchase.

``` r

nth.purchase <- CADF_to_nth_purchase(cadf, 3)
```

A more comprehensive dataset may be returned. The following command
returns the Customer ID, purchase_date (of xth purchase) and various
calculations. Note that only one row per customer is returned. Each
customer row returned represents the nth purchase.

``` r

nth.purchase.more <- CADF_to_nth_purchase_allrows(cadf,3)
head(nth.purchase.more)
#>   ID PURCHASE_DATE Tdays month_yr Tmonths yr_week    Tweeks      today     diff.years target.buy
#> 3  3    1997-05-25    84  1997-05       3 1997_21 12.000000 1998-07-01 1.1006160 days          0
#> 4  4    1997-08-18   229  1997-08       8 1997_34 32.714286 1998-07-01 0.8678987 days          0
#> 5  5    1997-02-14    44  1997-02       2 1997_07  6.285714 1998-07-01 1.3744011 days          0
#> 7  7    1998-01-22   317  1998-01      11 1998_04 45.285714 1998-07-01 0.4380561 days          0
#> 8  8    1997-06-13   132  1997-06       5 1997_24 18.857143 1998-07-01 1.0485969 days          0
#> 9  9    1998-01-08   252  1998-01       9 1998_02 36.000000 1998-07-01 0.4763860 days          0
#>   Frequency.baseperiod Frequency.holdout  x           t.x    T.cal recency.studyperiod.years purchase.num
#> 3                    6                 0  6 33.50000 days 69.42857            0.4216290 days            3
#> 4                    4                 0  4 26.41667 days 78.00000            0.5776865 days            3
#> 5                   11                 0 11 41.83333 days 78.00000            0.4900753 days            3
#> 7                    3                 0  3 13.33333 days 68.14286            0.4380561 days            3
#> 8                    8                 0  8 31.91667 days 73.57143            0.4188912 days            3
#> 9                    3                 0  3 14.50000 days 60.85714            0.4763860 days            3
```

## Purchase Strings

View purchase string for one consumer as a string of 1’s and 0’s. 1 is
purchase. 0 is no purchase.

``` r

cadf$`400`$purchase_string
#> [1] "111010100001101"
```

View purchase string for one consumer as a matrix.

``` r

cadf$`400`$purchase_string_as_matrix
#>       [,1]
#>  [1,]    1
#>  [2,]    1
#>  [3,]    1
#>  [4,]    0
#>  [5,]    1
#>  [6,]    0
#>  [7,]    1
#>  [8,]    0
#>  [9,]    0
#> [10,]    0
#> [11,]    0
#> [12,]    1
#> [13,]    1
#> [14,]    0
#> [15,]    1
```

View purchase string for one consumer as R data frame. Time always
starts at 1 and is relative to first purchase date.

``` r

t <- 1: length(cadf$`400`$purchase_string_as_matrix)
cadf$`400`$purchase_string_as_matrix
#>       [,1]
#>  [1,]    1
#>  [2,]    1
#>  [3,]    1
#>  [4,]    0
#>  [5,]    1
#>  [6,]    0
#>  [7,]    1
#>  [8,]    0
#>  [9,]    0
#> [10,]    0
#> [11,]    0
#> [12,]    1
#> [13,]    1
#> [14,]    0
#> [15,]    1
data.frame(t,cadf$`400`$purchase_string_as_matrix )
#>     t cadf..400..purchase_string_as_matrix
#> 1   1                                    1
#> 2   2                                    1
#> 3   3                                    1
#> 4   4                                    0
#> 5   5                                    1
#> 6   6                                    0
#> 7   7                                    1
#> 8   8                                    0
#> 9   9                                    0
#> 10 10                                    0
#> 11 11                                    0
#> 12 12                                    1
#> 13 13                                    1
#> 14 14                                    0
#> 15 15                                    1
```

Create a R list of all purchase strings.

``` r

pslist <- lapply(cadf, function(x) x$purchase_string)
```

# (3B)Creating Analytic Datasets for Situations Where Cancellation is Clear

## Simple Retention Model - Example from SAS book

### Estimating Retention Rate

Each row contains weighted data for each combination of T and “cancel” T
\| cancel \| count

``` r
head(srm_summaries)
#>   bigT cancel count
#> 1    2      1     4
#> 2   10      1    13
#> 3    7      0    49
#> 4    3      1    16
#> 5   11      1    10
#> 6    8      0    63
```

Expanded datasets work best with CADF because that is how the data will
most likely be returned from your reporting teams.

Sum of cancel flag = number of cancellations Row count = opportunities
to cancel

Divide the two to get the simple retention rate

``` r
head(srm_data)
#>   bigT cancel
#> 1    1      0
#> 2    2      1
#> 3    1      0
#> 4    2      1
#> 5    1      0
#> 6    2      1

sum(srm_data$cancel) # num of cancellations
#> [1] 245

nrow(srm_data) # flips/attempts/opportunities to cancel
#> [1] 5828

1 - (sum(srm_data$cancel)/ nrow(srm_data)) # simple retention rate
#> [1] 0.9579616
```

### Estimating Retention using Survival Analysis

``` r
surv.obj <- Surv(srm_data$bigT, srm_data$cancel)
summary(survfit(surv.obj ~ 1))
#> Call: survfit(formula = surv.obj ~ 1)
#> 
#>  time n.risk n.event survival  std.err lower 95% CI upper 95% CI
#>     2   5157       4    0.999 0.000388        0.998        1.000
#>     3   4489      16    0.996 0.000969        0.994        0.998
#>     4   3825      20    0.990 0.001509        0.988        0.993
#>     5   3179      37    0.979 0.002403        0.974        0.984
#>     6   2554      28    0.968 0.003117        0.962        0.974
#>     7   1973      61    0.938 0.004833        0.929        0.948
#>     8   1453      24    0.923 0.005695        0.912        0.934
#>     9   1043      19    0.906 0.006773        0.893        0.919
#>    10    720      13    0.890 0.008027        0.874        0.905
#>    11    446      10    0.870 0.010024        0.850        0.890
#>    12    201      13    0.813 0.017763        0.779        0.849
```

### Logistic Regression: Discrete Time Survival Model

\[Needs adjusted for data\]

``` r

logistic.srm = glm(cancel ~ 1 , family = binomial, data = srm_data )
```

## Simple Retention Model Using CADF

``` r

###
```

Estimate the retention rate

``` r

#1 - (sum(lr$cancel) / nrow(lr))
```

## Create dataset for annual halfing model

``` r

#ah <- CADF::CADF_to_annualhalfing_data(cadf) 
```

# (3C) Creating Analytic Datasets for Situations Where Cancellation is Not Clear

## Create dataset for migration model

``` r

#migrationmodel <- CADF::CADF_to_migration_model(cadf)
```

# License and Usage

CADF - Customer Data Preparation in R Copyright (C) 2023 Steve Ludwig

This program is free software: you can redistribute it and/or modify it
under the terms of the GNU General Public License as published by the
Free Software Foundation, either version 3 of the License, or (at your
option) any later version.

This program is distributed in the hope that it will be useful, but
WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General
Public License for more details.

You should have received a copy of the GNU General Public License along
with this program. If not, see <https://www.gnu.org/licenses/>.

[^1]: <https://www.truthset.io/copy-of-data-collective-2>
