# run_analysis.R
setwd("D:/")

library(dplyr)

setwd("/Coursera R/UCI HAR Dataset/train")
tr <- list.files(pattern=".*.txt")
train_Data <- do.call(cbind,lapply(tr, read.table))
setwd("/Coursera R/UCI HAR Dataset/test")
te <- list.files(pattern=".*.txt")
test_Data <- do.call(cbind,lapply(te, read.table))
dataset <- rbind(train_Data, test_Data)

apply(train_Data, 1, mean)
apply(train_Data, 1, sd)
apply(test_Data, 1, mean)
apply(test_Data, 1, sd)

dataset$V1[dataset$V1 == 1] <-"WALKING"
dataset$V1[dataset$V1 == 2] <-"WALKING UPSTAIRS"
dataset$V1[dataset$V1 == 3] <- "WALKING_DOWNSTAIRS"
dataset$V1[dataset$V1 == 4] <- "SITTING"
dataset$V1[dataset$V1 == 5] <- "STANDING"
dataset$V1[dataset$V1 == 6] <- "LAYING"

features <- read.table("/Coursera R/UCI HAR Dataset/features.txt")
feature <- rbind(features[,c(1,2)], matrix(c(562,"activity", 563, "subject"), nrow = 2, byrow = TRUE))
colnames(dataset) <- feature[,2]
act_mean <- aggregate(dataset$activity, dataset, mean)
sub_mean <- aggregate(act_mean$subject, act_mean, mean)
new_table <- sub_mean[,c(564,565)]
write.table(new_table, file = "/Coursera R/new_table.txt", row.name = F, quote = F)
