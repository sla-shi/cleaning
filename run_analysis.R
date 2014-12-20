setwd("~/cleaning")
library("data.table")

# Prepare data
unzip ("getdata-projectfiles-UCI HAR Dataset.zip")

# Read activities labels
act_test = read.csv ("UCI HAR Dataset/test/y_test.txt", header = F)
act_train = read.csv ("UCI HAR Dataset/train/y_train.txt", header = F)

act_labels = read.csv ("UCI HAR Dataset/activity_labels.txt", sep=" ", header = F)
act_test = data.table(as.character(act_labels$V2 [match (act_test$V1, act_labels$V1)]))
act_train = data.table(as.character (act_labels$V2 [match (act_train$V1, act_labels$V1)]))

# widths of 561 columns in a formatted source file
w=seq(16,16,length.out = 561)
w[1]=17

# Use data.table for better performance
DT_test = NULL
DT_train = NULL

# Convert formatted source file into data.table in a CSV table for the sake of performance
if (!file.exists("test.csv")) {
        test <- read.fwf ("UCI HAR Dataset/test/X_test.txt", widths = w, header = F)
        DT_test = data.table(test)
        test=NULL
        # Part 3.
        # Add descriptive activity names to name the activities in the data set
        DT_test = DT_test[,activity:=act_test]
        write.table (DT_test, "test.csv")
} else {
        DT_test = data.table(read.table ("test.csv"))
}

if (!file.exists("train.csv")) {
        train <- read.fwf ("UCI HAR Dataset/train/X_train.txt", widths = w, header = F)
        DT_train = data.table(train)
        train=NULL
        # Part 3.
        # Add descriptive activity names to name the activities in the data set
        DT_train = DT_train[,activity:=act_train]
        write.table(DT_train, "train.csv")
} else {
        DT_train = data.table(read.table("train.csv"))
}

# Part 1.
# Merge the training and test data and release temporary tables
m=merge(DT_train, DT_test, all=T, by=colnames(DT_train))
DT_train=NULL
DT_test=NULL

# Part 2.
# Extract only the measurements on the mean and standard deviation for each measurement
features = read.csv (file="UCI HAR Dataset/features.txt", sep=" ", header=F, stringsAsFactors=F)
sub_features = subset(features, grepl("mean", V2, ignore.case = T)==1 | 
                              grepl("std", V2, ignore.case = T)==1)
features=NULL

# Delete unnecesary columns but keep the activity label column
sub_features = rbind(sub_features, c(562,"activity"))
m = m[,c(as.numeric(sub_features$V1)), with=F]

# Part 4.
# Label the data set with descriptive variable names. 
setnames(m, 1:87, as.character(sub_features$V2[1:87]))

# Part 5.
# Create independent tidy data set with the average of each variable for each 
# activity and each subject.
m2 = m [,lapply(.SD, mean), by="activity"]
write.table(file="tidy.txt", x=m2, row.names=F)

#m3=read.csv("tidy.txt", sep=" ")
