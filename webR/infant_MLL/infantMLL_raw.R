head(read.csv(url("https://trichelab.github.io/data/MLL.csv"), row=1))
MLL <- read.csv(url("https://trichelab.github.io/data/MLL.csv"), row=1)
nonunique <- levels(factor(subset(reshape2::melt(sort(table(MLL$fusion))), value > 1)$Var1))
tbl <- with(subset(MLL, fusion %in% nonunique), table(fusion, AgeGroup == "Infant"))
infantVsNot <- names(which(apply(tbl, 1, min) > 0))
MLLivn <- subset(MLL, fusion %in% infantVsNot)
with(MLLivn, table(fusion, AgeGroup))


library(mixR) 
CD34.mix <- mixfit(MLLivn$CD34, ncomp=2) 
MECOM.mix <- mixfit(MLLivn$MECOM, ncomp=2) 

library(patchwork)
plot(MECOM.mix, title="MECOM", xlab="log(1 + transcripts)") + plot(CD34.mix, title="CD34", xlab="log(1 + transcripts)")

library(mclust)
bothFit <- Mclust(MLLivn[, c("MECOM", "CD34")])
plot(bothFit, what="uncertainty")

tbl2 <- with(MLLivn, table(classification != 2, AgeGroup == "Infant"))
sweep(tbl2, 2, colSums(tbl2), "/")

bothFit$parameters$mean

tbl3 <- with(MLLivn, table(classification != 2, AgeGroup == "Infant", fusion))
mantelhaen.test(tbl3)

tbl3[, , "KMT2A-ELL"]
tbl3[, , "KMT2A-MLLT4"]
tbl3[, , "KMT2A-MLLT3"]
tbl3[, , "KMT2A-MLLT1"]

bothFitAll <- Mclust(MLL[, c("MECOM","CD34")])
bothFitAll$parameters$mean

MLL$classification <- bothFitAll$classification[rownames(MLL)]
tbl4 <- with(MLL, table(classification != 2, AgeGroup == "Infant"))
sweep(tbl4, 2, colSums(tbl4), "/")
chisq.test(tbl4)

MLL$age <- ifelse(MLL$AgeGroup == "Infant", "Infant", "nonInfant")
MLL$CD34EVI1 <- ifelse(MLL$classification == 2, "Low", "High") 

library(survival)
library(survminer)
biFit <- survfit(Surv(OS, OSI) ~ age + CD34EVI1, data=MLL)
ggsurvplot(biFit, conf.int=TRUE, pval=TRUE, xlab="Overall survival (days)",
           tables.theme = theme_cleantable(), palette=c("red","green","darkred","darkgreen"))

bothFitAll <- Mclust(MLL[, c("MECOM","CD34")])
MLL$classification <- bothFitAll$classification[rownames(MLL)]
MLL$age <- ifelse(MLL$AgeGroup == "Infant", "Infant", "nonInfant")
MLL$CD34EVI1 <- ifelse(MLL$classification == 2, "Low", "High") 

par(mfrow=c(1,2))
with(subset(MLL, age=="Infant"), 
     surfacePlot(data=cbind(MECOM, CD34), parameters = bothFitAll$parameters, type = "image", what = "density"))
with(subset(MLL, age == "Infant"), 
     points(x=MECOM, y=CD34, col=classification))
title("Infants")

with(subset(MLL, age!="Infant"), 
     surfacePlot(data=cbind(MECOM, CD34), parameters = bothFitAll$parameters, type = "image", what = "density"))
with(subset(MLL, age != "Infant"), 
     points(x=MECOM, y=CD34, col=classification))
title("Older children") 

dev.copy2pdf(file="~/Dropbox/Alex_projects/MLL_infant_older_mixtures.pdf")
