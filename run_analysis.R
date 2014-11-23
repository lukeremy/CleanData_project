## setwd("~/R/Coursera/GetCleanData/assignment/data/UCI\ Har\ Dataset/")

## read in subject data, assign "subject" as variable name
tst_sub <- read.table("./UCI\ Har\ Dataset/test/subject_test.txt")
colnames(tst_sub) <- "subject"
trn_sub <- read.table("./UCI\ Har\ Dataset/train/subject_train.txt")
colnames(trn_sub) <- "subject"

## read in activity data, assign "activity" as variable name
tst_labels <- read.table("./UCI\ Har\ Dataset/test/y_test.txt")
colnames(tst_labels) <- "activity"
trn_labels <- read.table("./UCI\ Har\ Dataset/train/y_train.txt")
colnames(trn_labels) <- "activity"

## read in features file
features <- read.table("./UCI\ Har\ Dataset/features.txt")

## read in activity labels
act <- read.table("./UCI\ Har\ Dataset/activity_labels.txt")

## read in test and train data
test_data <- read.table("./UCI\ Har\ Dataset/test/X_test.txt")
train_data <- read.table("./UCI\ Har\ Dataset/train/X_train.txt")

## merge datasets 
data <- rbind(test_data,train_data)
## rename data columns using features file
data_names <- as.vector(features$V2)
colnames(data) <- data_names

## use grep() function to subset only mean and std columns
data2 <- data[,grep("mean\\(\\)|std\\(\\)",colnames(data))]

## merge subject and label info to data
sub <- rbind(tst_sub,trn_sub)
labels <- rbind(tst_labels,trn_labels)
all <- cbind(sub,labels,data2)

## replace activity code with activity name
names(act) <- c("activity","act_name")
all2 <- merge(act,all,by="activity",all=TRUE)

## create tidy dataset
all_names <- colnames(all2)[4:69]
library(reshape2)
all3 <- melt(all2, id=c("activity","act_name","subject"),measure.vars=all_names)
all3 <- all3[,-1]

all4 <- dcast(all3, act_name+subject ~ variable, mean)

write.table(all4, file="tidy.txt",row.name=FALSE)

