#non-contractual models:  Migration Model
#estimate transition rate

setwd("~/Documents/CADF/data")
sltv <- read.csv(file = "segltv.csv") #DO NOT INCLUDE IN PACKAGE
sltv$giftdate <- lubridate::mdy(sltv$giftdate)
sltv2 <- data.frame(ID = sltv$id, PURCHASE_DATE=sltv$giftdate, NUM_ITEMS = 1, TOTAL=sltv$amt)

#change/mask data
library(lubridate)
library(digest)
sltv.masked <- sltv2
sltv.masked$PURCHASE_DATE <- sltv.masked$PURCHASE_DATE  %m+% years(15)
sltv.masked$ID <- sapply(sltv.masked$ID, digest, algo = "sha1")

#CADF (ORIGINAL DATA) (DO NOT INCLUDE IN PACKAGE)
a <- split(sltv2, sltv2$ID)
today <- as.Date("8/31/2005", '%m/%d/%Y')
cadf.data <- lapply(a, function(x) CADF::Customer$new(x, today=today))
m <- CADF::CADF_to_migration_model(cadf.data)


#CADF (MASKED DATA)
a <- split(sltv.masked, sltv.masked$ID)
today <- as.Date("8/31/2005", '%m/%d/%Y') %m+% years(15)
cadf.data <- lapply(a, function(x) CADF::Customer$new(x, today=today))
m.masked <- CADF::CADF_to_migration_model(cadf.data)