#This file reads in UCI HAR data and summarises the means and standard deviations

require("data.table")
require("reshape2")
# first, read in the relevant data
test.subject <- read.table("UCI HAR Dataset//test//subject_test.txt")
test.X <- read.table("UCI HAR Dataset//test/X_test.txt")
test.Y <- read.table("UCI HAR Dataset//test/Y_test.txt")
train.subject <- read.table("UCI HAR Dataset//train//subject_train.txt")
train.X <- read.table("UCI HAR Dataset//train/X_train.txt")
train.Y <- read.table("UCI HAR Dataset//train/Y_train.txt")
names <- read.table("UCI HAR Dataset//features.txt")
  # second element of the names list represents the actual names
  # we also add in names for the user and the activity type
names <- c("Subject", "Activity", as.character(names[[2]]))


# now put together the separate test and data set
test <- data.table(test.subject, test.Y, test.X)
setnames(test, names)
train <- data.table(train.subject, train.Y, train.X)
setnames(train, names)
data <- data.table(rbind(test,train))

#get indices which represent the columns with means or standard deviations
#also keeping the first two columns
ind <- c(1,2,grep("mean()|std()",names))

#clean up the names and glue them back in
names <- gsub("-","_", names)
names <- gsub("\\(\\)","",names)
#names <- gsub(")","",names)
names <- gsub("BodyBody","Body",names)
setnames(data, names)

#only care about mean's and std's
data <- data[, ind, with=FALSE]

#replace the activities numbers (1-6) with their names
#also, set the subject and activity as factors
act <- data$Activity
act[act == 1] <- "Walking"
act[act == 2] <- "Walking Upstairs"
act[act == 3] <- "Walking Downstairs"
act[act == 4] <- "Sitting"
act[act == 5] <- "Standing"
act[act == 6] <- "Laying"

data$Activity <- as.factor(act)
data$Subject <- as.factor(data$Subject)
long <- melt(data, c("Subject", "Activity"))
setkey(long, Subject, Activity)
summary <- long[,mean(value), by = list(Subject, Activity, variable)]
setnames(summary, 4,"Mean")
# the table summary is the means of the means and standard deviations in long form
# the table data is the means and standard deviations in wide format

write.table(summary, "summaryData.txt", row.name=FALSE)