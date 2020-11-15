# Getting-and-Cleaning-Data-Course-Project

1) Merges the training and the test sets to create one data set
  test data: subjectest.txt, xtest.txt and ytest.txt
  training data: subjectrain.txt, X_train.txt and y_train.txt
  merge all training and test files horizontally into one training data and one testing data
  merge both data vertically into one data
  
2) Extracts only the measurements on the mean and standard deviation for each measurement
    Compute the mean and standard deviation and extract out
  
3) Uses descriptive activity names to name the activities in the data set
    Assign a number to each activity
  
4) Appropriately labels the data set with descriptive variable names
    Data cleaning so that users will be able to view an accurate and clean data 
  
5) Creates a second, independent tidy data set with the average of each variable for each activity and each subject
    using the package dplyr to group and summarize data by subject ID and activity and compute the averages 
