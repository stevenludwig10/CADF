



########################################################################################
# Analysis Dataset ("Analysisperiod" tab)
########################################################################################


data_analysis = transactionalData[transactionalData$targetdonate == 0, ]

data_analysis2 = aggregate(data_analysis$amount, by = list(data_analysis$id), sum)
colnames(data_analysis2) = c("id" , "totalamt")

data_analysis3 = aggregate(data_analysis$recency, by=list(data_analysis$id), min)
colnames(data_analysis3) = c("id" , "minRecency")

data_analysis4 = as.data.frame(table(data_analysis$id))
colnames(data_analysis4) = c("id" , "id_count")

data_analysis5 <- aggregate(transactionalData$targetdonate, by=list(transactionalData$id), max)
colnames(data_analysis5) = c("id", "targetdonate")

data_analysis6 = Reduce(function(x, y) merge(x, y, all=TRUE), list(data_analysis2, data_analysis3, data_analysis4, data_analysis5))
data_analysis6$RecencyRounded = floor(data_analysis6$minRecency)

#create model table, =analysisperiod, holdout 0 in pivot
grid2 <<- c(0.538803, 0.928941, 0.486594, -1.067428)
data_analysis6$LL = apply(data_analysis6[,c('minRecency','id_count', 'targetdonate')], 1, LL)
sum(data_analysis6$LL)

###################################################
#Optimize model
###################################################

a <- seq(0.01, .9999, by = 0.01)
b <- seq(-5, 5, by = 0.01)
data_result <- data.frame(matrix(nrow=1, ncol = 5))

for (i in 1:20) {
   grid2 = c(sample(a,1),sample(a,1),sample(b,1),sample(b,1))
   model<- nlminb(LL_opt, start=grid2, upper=c(1,1,Inf,Inf), lower=c(0,0,-Inf,-Inf), control=list(iter.max = 200))
   data_result[i,] <- c(model$par, model$objective)
   print(grid2)

}

best_model_fit <- data_result[with(data_result, order(-X5)), ]
best_model_fit  <- best_model_fit[!is.infinite(rowSums(best_model_fit)),]
print("Best Model Fit")
print(best_model_fit)
a = 2
#a <- as.numeric(invisible(readline(prompt = "Which model result do you want to use for analysis?")))
grid2 = as.numeric(best_model_fit[a,][1:4])


###################################################
#Results Report
###################################################

#transactionalData, original source input data
data_analysis = transactionalData
a<-aggregate(data_analysis$amount, by = list(data_analysis$id, data_analysis$targetdonate), sum)
colnames(a) = c("id", "targetdonate", "amount")
b = data.frame(a$targetdonate, a$amount)

avg_transactions <- tapply(b$a.amount, b$a.targetdonate, summary) #avg transaction
donor_non_donor <- table(b$a.targetdonate) #num customers

#####################################

graph1 = data.frame(f_ =  seq(1, 10, by = 0.1))
graph1$probability =  sapply(graph1[,c('f_')],frequencyPred)

graph2 = data.frame(recency = seq(0,4, by = 0.5))
graph2$f1 =  sapply(graph2[,c('recency')],predictions, 1)
graph2$f2 =  sapply(graph2[,c('recency')],predictions, 2)
graph2$f3 = sapply(graph2[,c('recency')],predictions, 3)
graph2$f4 = sapply(graph2[,c('recency')],predictions, 4)
graph2$f5 = sapply(graph2[,c('recency')],predictions, 5)

rownames(graph2) = graph2$recency
graph2$recency = NULL

matplot(graph2, type = c("b"),pch=1,col = 1:4) #plot
 legend("topright", legend = 1:4, col=1:4, pch=1) # optional legend


#Donation activity by recency
library(formattable)
a <- with(data_analysis6, table(RecencyRounded, targetdonate))
a_pct <- percent(prop.table(a, margin=1))
pdf("donation_by_recency.pdf", height = 11, width = 8.5)
grid.table(a)
grid.table(a_pct)
dev.off()


















