# read in the metadata for table 2
table2.meta <- read.csv("table2.metadata.csv", row.names=1)

# set up a matrix for the number of colonies in each culture of each experiment
table2 <- matrix(NA_integer_, 
                 nrow=max(table2.meta$Cultures), 
                 ncol=nrow(table2.meta),
                 dimnames=list(culture=seq_len(max(table2.meta$Cultures)),
                               rownames(table2.meta)))

# read in the data (yes this is gross, no I don't care)
table2.data <- read.csv("table2.data.csv")
for (m in seq_len(nrow(table2.data))) {
  dat <- table2.data[m, ]
  table2[dat$i, dat$j] <- dat$x
}

# reconstruct the results from the paper 
library(matrixStats)
Average.per.sample <- round(colMeans(table2, na.rm=TRUE), 1)
Variance.uncorrected <- colVars(table2, na.rm=TRUE)
