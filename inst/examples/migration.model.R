#non-contractual models:  Migration Model
#estimate transition rate

data(segltv)

#CADF
a <- split(sltv.masked, sltv.masked$ID)
today <- as.Date("8/31/2005", '%m/%d/%Y') %m+% years(15)
cadf.data <- lapply(a, function(x) CADF::Customer$new(x, today=today))
m.masked <- CADF::CADF_to_migration_model(cadf.data)