CleanData_project
=================

Course project for Goursera Getting and Cleaning Data course

Notes for run_analysis.R script:

First, the subject data are read in from the test and the train folders, and rename the variable to "subject"
____________________________________________________________
tst_sub <- read.table("./UCI\ Har\ Dataset/test/subject_test.txt")
colnames(tst_sub) <- "subject"
trn_sub <- read.table("./UCI\ Har\ Dataset/train/subject_train.txt")
colnames(trn_sub) <- "subject"
____________________________________________________________

Next, read in the activity labels data from the test and the train folders, rename variables to "activity"
________________________________________________________________
tst_labels <- read.table("./UCI\ Har\ Dataset/test/y_test.txt")
colnames(tst_labels) <- "activity"
trn_labels <- read.table("./UCI\ Har\ Dataset/train/y_train.txt")
colnames(trn_labels) <- "activity"
________________________________________________________________

Next, read in features file and activity labels, and test and train data
_______________________________________________________________
features <- read.table("./UCI\ Har\ Dataset/features.txt")
act <- read.table("./UCI\ Har\ Dataset/activity_labels.txt")
test_data <- read.table("./UCI\ Har\ Dataset/test/X_test.txt")
train_data <- read.table("./UCI\ Har\ Dataset/train/X_train.txt")
_______________________________________________________________

Merge test and train datasets, rename data table columns/variables to match variable names found in features table
______________________________________________________________
data <- rbind(test_data,train_data)
data_names <- as.vector(features$V2)
colnames(data) <- data_names
______________________________________________________________

Extract just the mean and standard deviation variable data from the dataset, merge these data with subject and activity label info.
_____________________________________________________________
data2 <- data[,grep("mean\\(\\)|std\\(\\)",colnames(data))]
sub <- rbind(tst_sub,trn_sub)
labels <- rbind(tst_labels,trn_labels)
all <- cbind(sub,labels,data2)
_____________________________________________________________

Replace activity code with activity name, create tidy dataset, write table to local disc
____________________________________________________________
all_names <- colnames(all2)[4:69]
library(reshape2)
all3 <- melt(all2, id=c("activity","act_name","subject"),measure.vars=all_names)
all3 <- all3[,-1]
all4 <- dcast(all3, act_name+subject ~ variable, mean)
write.table(all4, file="tidy.txt",row.name=FALSE)
____________________________________________________________

