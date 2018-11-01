# Load required packages
library(dplyr)

# Download the dataset
filename <- "UCI HAR Dataset.zip"
urlFile <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(urlFile, filename ,method="curl")
unzip(filename) 

# Assigning all files to data frames
features <- data.table::fread("UCI HAR Dataset/features.txt", col.names = c("n", "functions"))
activities <- data.table::fread("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "label"))
subject_test <- data.table::fread("UCI HAR Dataset/test/subject_test.txt", col.names = c("subject"))
x_test <- data.table::fread("UCI HAR Dataset/test/x_test.txt", col.names = features$functions)
y_test <- data.table::fread("UCI HAR Dataset/test/y_test.txt", col.names = "code")
subject_train <- data.table::fread("UCI HAR Dataset/train/subject_train.txt", col.names = c("subject"))
x_train <- data.table::fread("UCI HAR Dataset/train/x_train.txt", col.names = features$functions)
y_train <- data.table::fread("UCI HAR Dataset/train/y_train.txt", col.names = "code")

# 1. Merges the training and the test sets to create one data set.
x <- rbind(x_train, x_test)
y <- rbind(y_train, y_test)
subject <- rbind(subject_train, subject_test)
DT <- cbind(subject, x, y)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
newDT <- DT[, grepl("subject|code|mean|std", colnames(DT), ignore.case = TRUE ), with=FALSE]

# 3. Uses descriptive activity names to name the activities in the data set
newDT$code <- activities[newDT$code, 2]

# 4. Appropriately labels the data set with descriptive variable names.
names(newDT)[88]="activity"
names(newDT)<-gsub("^f", "Frequency", names(newDT)) #replace string begin with f
names(newDT)<-gsub("^t", "Time", names(newDT)) #replace string begin with t
names(newDT)<-gsub("BodyBody", "Body", names(newDT))
names(newDT)<-gsub("Acc", "Accelerometer", names(newDT))
names(newDT)<-gsub("Gyro", "Gyroscope", names(newDT))
names(newDT)<-gsub("Mag", "Magnitude", names(newDT))
names(newDT)<-gsub("-mean", "Mean", names(newDT),  ignore.case = TRUE)
names(newDT)<-gsub("-std", "Stdev", names(newDT), ignore.case = TRUE)
names(newDT)<-gsub("freq", "Frequency", names(newDT), ignore.case = TRUE)
names(newDT)<-gsub("angle", "Angle", names(newDT), ignore.case = TRUE)
names(newDT)<-gsub("gravity", "Gravity", names(newDT), ignore.case = TRUE)
names(newDT)<-gsub("tBody", "TimeBody", names(newDT), ignore.case = TRUE)

# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
ResultDT <- newDT %>%
    group_by(subject, activity) %>%
    summarise_all(funs(mean))
write.table(ResultDT, "ResultData.txt", row.name=FALSE)

