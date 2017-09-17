# Getting and Cleaning Data

This repository contains an R script called run_analysis.R that does the following.

* Merges the training and the test sets to create one data set.
* Extracts only the measurements on the mean and standard deviation for each measurement.
* Uses descriptive activity names to name the activities in the data set
* Appropriately labels the data set with descriptive activity names.
* Creates a second, independent tidy data set with the average of each variable for each activity and each subject. This data set is stored in a file called tidy_data.txt

## Steps to work on this course project

1. Download the data source and put into a folder on your local drive. You'll have a 'UCI HAR Dataset' folder.
2. Place the R script file 'run_analysis.R' in the parent folder of 'UCI HAR Dataset', then set it as your working directory using 'setwd()' function in RStudio.
3. Run the R script file using 'source("run_analysis.R")', which will generate a new file 'tidy_data.txt' in 'UCI HAR Dataset' directory.

## Dependencies

'data.table' package is required to run this script. 
