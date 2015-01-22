# run_analysis.R

#载入dplyr包
library(dplyr)

#获得train_X和train_Y并合并成train_Data#
setwd("/Users/fushanshan/Downloads/UCI HAR Dataset/train")
a <- list.files(pattern=".*.txt")
train_Data <- do.call(cbind,lapply(a, read.table))
#获得test_X和test_Y并合并成test_Data#
setwd("/Users/fushanshan/Downloads/UCI HAR Dataset/test")
b <- list.files(pattern=".*.txt")
test_Data <- do.call(cbind,lapply(b, read.table))
#将两个数据合并在一个dataset#
dataset <- rbind(train_Data, test_Data)
#返回所有列的平均值
colMeans(train_Data)
colMeans(test_Data)

#将Y的1-6修改为对应的activity
dataset$V1[dataset$V1 == 1] <-"WALKING"
dataset$V1[dataset$V1 == 2] <-"WALKING UPSTAIRS"
dataset$V1[dataset$V1 == 3] <- "WALKING_DOWNSTAIRS"
dataset$V1[dataset$V1 == 4] <- "SITTING"
dataset$V1[dataset$V1 == 5] <- "STANDING"
dataset$V1[dataset$V1 == 6] <- "LAYING"

#读取标签
features <- read.table("/Users/fushanshan/Downloads/UCI HAR Dataset/features.txt")
feature <- rbind(features[,c(1,2)], matrix(c(562,"activity", 563, "subject"), nrow = 2, byrow = TRUE))
#将标签分别赋予dataset的每一列
colnames(dataset) <- feature[,2]

#不同活动的平均值形成新的数据
act_mean <- aggregate(dataset$activity, dataset, mean)
#不同主题的平均值形成新的数据
sub_mean <- aggregate(act_mean$subject, act_mean, mean)
new_table <- sub_mean[,c(564,565)]

#读出数据
write.table(new_table, file = "/Users/fushanshan/Downloads/new_table.txt", row.name = F, quote = F)

