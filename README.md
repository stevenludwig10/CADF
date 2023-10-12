---
title: "Using CADF to Prepare Customer Analytic Datasets"
vignette: >
  %\VignetteIndexEntry{CADF}
  %\VignetteEncoding{UTF-8}
  %\VignetteEngine{knitr::rmarkdown}
output: 
  pdf_document: 
    keep_tex: yes
---

```{r, include = FALSE}
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)
```

```{r setup}
library(CADF)
library(survival)
```

# Introduction

Why we need standardized processes for customer analytic data preparation.
Data quality stats from Forrester ^[https://www.truthset.io/copy-of-data-collective-2]

 * 37% of marketers waste spend due to poor data quality
 * 35% suffer from inaccurate targeting
 * 30% have lost customers due to bad data

This package accompanies my customer analytics R book. The book is still in draft form and a table of contents preview is available [here](https://1drv.ms/b/s!AsKU-g_cimuplJs-7pC9L92zLG5H-w?e=eKJM3c).

For those interested, I may grant you access to the GitHub repo that stores the R code for this package. Please contact steveludwig6 at gmail.com if interested. <https://github.com/stevenludwig10/CADF>

### License and Usage

CADF - Customer Data Preparation in R Copyright (C) 2023 Steve Ludwig

This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.

# Process

1.) Prepare your transaction data to account for purchases, returns and the correct transaction data inclusion. This may require working with source system teams like SAP or your accounting teams. It may require implementing or working with a customer data platform.

2.) CADF is ran once for each "cohort" of customers.

METHOD 1:

Prepare transactional data -\> Split data by customer id -\> Run CADF on each customer -\> Reassemble customer level data into cohort level data for modeling.

# Creating your First CADF Dataset

-   Load transaction data
-   Pick only customer id and purchase date
-   Check data types (should be date and string or int)

```{r}

data(transactions)
transactions.filtered <- transactions[, c("ID", "PURCHASE_DATE")]
str(transactions.filtered)                             
                          
```

-   Split the data by customer id
-   Look at customer 400 as example

```{r}

transactions.splitted <- split(transactions.filtered, transactions.filtered$ID)



```

Run the CADF process. Split.transaction.file_to_CADF processes each customer. The second arguement can be used if your data contains training and test instances. This example assumes 0 testing data.

```{r}

cadf <- split.transaction.file_to_CADF(transactions.splitted, max(transactions$PURCHASE_DATE))


```

Here is the CADF profile (R6 class) for customer 400. The R6 class contains all the different data points that can be used for customer analytic modeling.

```{r}

cadf["400"]


```

# Interesting Data Setups for Customer Analytics

## Getting Customers' nth Purchase

Returns a numeric vector.  Each entry is the time, in weeks, for each customers nth purchase.  The function is ran for 3rd purchase.

```{r}

nth.purchase <- CADF_to_nth_purchase(cadf, 3)

```

A more comprehensive dataset may be returned.  The following command returns the Customer ID, purchase_date (of xth purchase) and various calculations.  Note that only one row per customer is returned.  Each customer row returned represents the nth purchase.

``` {r}

nth.purchase.more <- CADF_to_nth_purchase_allrows(cadf,3)
head(nth.purchase.more)

```


## Purchase Strings

View purchase string for one consumer as a string of 1's and 0's. 1 is purchase. 0 is no purchase.

```{r}

cadf$`400`$purchase_string


```

View purchase string for one consumer as a matrix.

```{r}

cadf$`400`$purchase_string_as_matrix

```

View purchase string for one consumer as R data frame. Time always starts at 1 and is relative to first purchase date.

```{r}

t <- 1: length(cadf$`400`$purchase_string_as_matrix)
cadf$`400`$purchase_string_as_matrix
data.frame(t,cadf$`400`$purchase_string_as_matrix )
```

Create a R list of all purchase strings.

```{r}

pslist <- lapply(cadf, function(x) x$purchase_string)

```

# Creating Analytic Datasets for Situations Where Cancellation is Clear

## Simple Retention Model - Example from SAS book

### Estimating Retention Rate

Each row contains weighted data for each combination of T and "cancel"
T | cancel | count

``` {r}
head(srm_summaries)



```


Expanded datasets work best with CADF because that is how the data will most likely be returned from your reporting teams.

Sum of cancel flag = number of cancellations
Row count = opportunities to cancel

Divide the two to get the simple retention rate

```{r}
head(srm_data)

sum(srm_data$cancel) # num of cancellations

nrow(srm_data) # flips/attempts/opportunities to cancel

1 - (sum(srm_data$cancel)/ nrow(srm_data)) # simple retention rate

```


### Estimating Retention using Survival Analysis 


``` {r}
surv.obj <- Surv(srm_data$bigT, srm_data$cancel)
summary(survfit(surv.obj ~ 1))

```


### Logistic Regression: Discrete Time Survival Model
[Needs adjusted for data]

``` {r}

logistic.srm = glm(cancel ~ 1 , family = binomial, data = srm_data )


```

## Simple Retention Model Using CADF

``` {r}

###


```



Estimate the retention rate

``` {r}

#1 - (sum(lr$cancel) / nrow(lr))


```



## Create dataset for annual halfing model

```{r}

#ah <- CADF::CADF_to_annualhalfing_data(cadf) 

```


## Creating Analytic Datasets for Situations Where Cancellation is Not Clear


## Create dataset for migration model

```{r}

#migrationmodel <- CADF::CADF_to_migration_model(cadf)

```

## Survival Analysis
