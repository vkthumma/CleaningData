##Following is the requirement
##You should create one R script called run_analysis.R that does the following.
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive variable names.
## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

#Load the data.table package
library(data.table)

#Extract the activity names from the activity_labels.txt file. The labels are in the second column
activity_names <- read.table("./UCI HAR Dataset/activity_labels.txt", stringsAsFactors = FALSE)[,2]

#Extract column names for the table from features.txt.
features <- read.table("./UCI HAR Dataset/features.txt", stringsAsFactors = FALSE)[,2]

#Create a logical vector to Extract only the mean and standard deviation features we need.
extracted_features <- grepl("mean|std", features)
print("Loaded lables...")

##Test data
#Load the x_test data.
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt", stringsAsFactors = FALSE, header = FALSE)
#Set the features as the column names in the data frame
names(x_test) <- features
#Extract only the mean and standard deviation features we need. Assign the result back to x_test
x_test <- x_test[,extracted_features]

#Load the y_test data
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt", stringsAsFactors = FALSE, header = FALSE)
#Set the Activity names. Add the Activity names as a column to the y_test data frame
y_test[,2] <- activity_names[y_test[,1]]
#Set column names to the data frame
names(y_test) <- c("Activity_ID", "Activity_Name")

#Load the subject_test data
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", stringsAsFactors = FALSE, header = FALSE)
#Set the column name in the data frame
names(subject_test) <- "Subject"

#Merge all the data frames
test_data <- cbind(subject_test, y_test, x_test)
print("Processed test data...")

##Training data
#Load the x_train data.
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt", stringsAsFactors = FALSE, header = FALSE)
#Set the features as the column names in the data frame
names(x_train) <- features
#Extract only the mean and standard deviation features we need. Assign the result back to x_train
x_train <- x_train[,extracted_features]

#Load the y_train data
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt", stringsAsFactors = FALSE, header = FALSE)
#Set the Activity names. Add the Activity names as a column to the y_train data frame
y_train[,2] <- activity_names[y_train[,1]]
#Set column names to the data frame
names(y_train) <- c("Activity_ID", "Activity_Name")

#Load the subject_train data
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", stringsAsFactors = FALSE, header = FALSE)
#Set the column name in the data frame
names(subject_train) <- "Subject"

#Merge all the data frames
train_data <- cbind(subject_train, y_train, x_train)
print("Processed train data...")

#Merge test and train data frames
data <- rbind(test_data, train_data)
print("Merged test & train data...")

id_columns   <- c("Subject", "Activity_ID", "Activity_Name")
data_columns <- features[extracted_features]
melted_data  <- melt(data, id = id_columns, measure.vars = data_columns)
print("Melted the data...")

#Apply mean function on the data grouped by the Subject & Activity using dcast function
tidy_data <- dcast(melted_data, Subject + Activity_Name ~ variable, mean)
print("Tidy'ed the data...")

write.table(tidy_data, file = "./UCI HAR Dataset/tidy_data.txt", row.names = FALSE)
print("Saved the tidy data to tidy_data.txt ...")
