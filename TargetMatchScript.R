setwd("D://")
library(adagio)
library(dplyr)

#read main file
Working2020_Data <- read.csv("Projects Data/Target Match/Working 2020.csv")

#Sort POS Values
Working2020_Data$POS <- sort(Working2020_Data$POS , decreasing = F)

Working2020_Data$POS <- as.numeric(Working2020_Data$POS)

Target1 <- 6209983
Target2 <- 1890525
Target3 <- 872453

#Finding matching subsets of the given Targets

Match1 <- Working2020_Data[subsetsum(Working2020_Data$POS,Target1,method = "dynamic")$inds,]
sum(Match1$POS)

#Remove Match 1 loans from main file.

remainingLoans <- anti_join(Working2020_Data,Match1)

Match2 <- remainingLoans[subsetsum(remainingLoans$POS,Target2,method = "dynamic")$inds,]
sum(Match2$POS)

Match3 <- anti_join(remainingLoans,Match2)
sum(Match3$POS)

#Writing All 3 files to disk.
write.csv(Match1,"Projects Data/Target Match/Match_6209983.csv")
write.csv(Match2,"Projects Data/Target Match/Match_1890525.csv")
write.csv(Match3,"Projects Data/Target Match/Match_872453.csv")