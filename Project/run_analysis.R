library(data.table)
library(curl)
library(reshape2)

rm(list = ls())

########### Download and unzip the dataset.

zip_filename <- "getdata_projectfiles_UCI HAR Dataset.zip"

if (!file.exists(zip_filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, zip_filename, method="curl")
}  
if (!file.exists("UCI HAR Dataset")) { 
  unzip(zip_filename) 
}

########### Load the variable names and activity labels

## File features.txt, the variable names.
columnNames <- fread("./UCI HAR Dataset/features.txt", select = c(2), col.names = c("names"))
# Make.names, with unique = TRUE: to make sure the variable names are syntactically valid and unique.
columnNames <- make.names(columnNames$names, unique = TRUE)
# If necessary, thisfunction will coerce the vector columnNames$names to character.

## File activity_labels.txt -. the activity names and their labels..
activityLabels <- fread("./UCI HAR Dataset/activity_labels.txt", col.names = c("Activity", "ActivityName"))

########### Load the data sets

test <- fread("./UCI HAR Dataset/test/X_test.txt", col.names = columnNames, check.names = TRUE)
test <- fread("./UCI HAR Dataset/test/X_test.txt", col.names = columnNames)
testSubjects <- fread("./UCI HAR Dataset/test/subject_test.txt", col.names = "Subject")
testActivity <- fread("./UCI HAR Dataset/test/y_test.txt", col.names = "Activity")

## Merge testActivity with activityLabels becouse we descriptive activity names in the data set.
testActivity <- merge(testActivity, activityLabels)

## Add Subject and Activity to the test dataset.
test$Subject <- testSubjects$Subject
test$Activity <- testActivity$ActivityName

##

training <- fread("./UCI HAR Dataset/train/X_train.txt", col.names = columnNames, check.names = TRUE)
trainingSubjects <- fread("./UCI HAR Dataset/train/subject_train.txt", col.names = "Subject")
trainingActivity <- fread("./UCI HAR Dataset/train/y_train.txt", col.names = "Activity")

## Merge trainingActivity with activityLabels becouse we descriptive activity names in the data set.
trainingActivity<- merge(trainingActivity, activityLabels)

## Add Subject and Activity to the test dataset.
training$Subject <- trainingSubjects$Subject
training$Activity <- trainingActivity$ActivityName

########### Merges the training and the test sets to create one data set.
merged_data <- merge(training, test, all = TRUE)

########### Extracts only the measurements on the mean and standard deviation for each measurement. 
MeanStdData <- merged_data[ , grep("mean..|std..|[Ss]ubject|[Aa]ctivity", names(merged_data)) , with = FALSE]

########### Appropriately labels the data set with descriptive variable names. 

names(MeanStdData) <- gsub(".", "", names(MeanStdData), fixed = TRUE)
names(MeanStdData) <- gsub("^f","Frequency", names(MeanStdData))
names(MeanStdData) <- gsub("^t","Time", names(MeanStdData))
names(MeanStdData) <- gsub("^angle","Angle-", names(MeanStdData))
names(MeanStdData) <- gsub("[Aa]cc","Accelerator", names(MeanStdData))
names(MeanStdData) <- gsub("[Gg]yro","Gyroscope", names(MeanStdData))
names(MeanStdData) <- gsub("[Gg]ravity","Gravity", names(MeanStdData))
names(MeanStdData) <- gsub("[Mm]ag","Magnitude", names(MeanStdData))
names(MeanStdData) <- gsub("[Mm]ean","Mean", names(MeanStdData))
names(MeanStdData) <- gsub("[Ss]td","Std", names(MeanStdData))

########### Second, independent tidy data set with the average of each variable for activity and subject.
melted_data <- melt(MeanStdData, id.vars = c("Subject", "Activity"))
tidy <- dcast(melted_data, Subject + Activity ~ variable, mean)

write.table(tidy, "tidy.txt", row.names=FALSE)