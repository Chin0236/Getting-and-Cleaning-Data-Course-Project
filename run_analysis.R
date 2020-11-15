#Q1
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url)
unzip(zipfile = "dataFiles.zip")

#Read in label files
activity <- read.table('UCI HAR Dataset/activity_labels.txt', 
                     col.names = c('activityLabels', 'activityName'), quote = "")
#Link the class labels with the activity name
features <- read.table('UCI HAR Dataset/features.txt', 
                       col.names = c('featureLabels', 'featureName'), quote = "")
#List of features

#Read in test data
subjectest <- read.table('UCI HAR Dataset/test/subject_test.txt', col.names = c('subjectId'))
#Each row identifies the subject who performed the activity for each window sample. 
#Its range is from 1 to 30.
xtest <- read.table('UCI HAR Dataset/test/X_test.txt')
#Measurements for the test data (features)
ytest <- read.table('UCI HAR Dataset/test/y_test.txt')
#Result for the test data (outcomes)

#Combine all test data and give column names
colnames(xtest) <- features$featureName
colnames(ytest) <- c('activityLabels')
testdata <- cbind(subjectest, xtest, ytest)

#Read in training data
subjectrain <- read.table('UCI HAR Dataset/train/subject_train.txt', col.names = c('subjectId'))
xtrain <- read.table('UCI HAR Dataset/train/X_train.txt')
ytrain <- read.table('UCI HAR Dataset/train/y_train.txt')

#Combine all training data and give column names
colnames(xtrain) <- features$featureName
colnames(ytrain) <- c('activityLabels')
traindata <- cbind(subjectrain, xtrain, ytrain)

#Combine test and training data
data <- rbind(traindata, testdata)

#Q2
mean_sd <- data[, c(1, grep(pattern = "mean\\(\\)|std\\(\\)", 
                                  x = names(data)), 563)]

#Q3
mean_sd$subjectId <- as.factor(mean_sd$subjectId)
mean_sd$activity <- factor(mean_sd$activityLabels,
                              levels = activity$activityLabels,
                              labels = activity$activityName)

#Q4
colnames(mean_sd) <- gsub(pattern = '\\(\\)', replacement = "", x = names(mean_sd))
#remove the () for the mean and std in the measurements
mean_sd <- mean_sd[, c(1, 68, 2:67)]
#move the activity column to the second column
write.table(mean_sd, file = 'tidyData.txt', row.names = F, quote = F, sep = "\t")

#Q5
install.packages("dplyr")
library(dplyr)
second <- group_by(mean_sd, subjectId, activity) %>% summarise_all(funs(mean))
write.table(second, file = 'tidyDataMean.txt', row.names = F, quote = F, sep = "\t")

