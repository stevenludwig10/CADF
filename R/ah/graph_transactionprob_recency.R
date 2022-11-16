

graph1 = data.frame(f_ =  seq(1, 10, by = 0.1))
graph1$probability =  sapply(graph1[,c('f_')],frequencyPred)

pdf(file="TransactionProb by Frequency.pdf")
with(graph1, plot(f_, probability,  xlab="1", ylab="2"))
title("Transaction Probability by Frequency")
dev.off()
