### Download the dataset ###
Download dataset from url specified in script and extracted to the folder called `UCI HAR Dataset`

### Assigning all files to data frames ###
* `features <- features.txt` : 561 rows, 2 columns (n, function).
    List of all features. Will be assigned to dataframe column
* `activities <- activity_labels.txt` : 6 rows, 2 columns (code, label).
    Links the class labels with their activity name.
* `subject_test <- test/subject_test.txt` : 2947 rows, 1 column.
    contains test data of 9/30 volunteer test subjects being observed
* `x_test <- test/X_test.txt` : 2947 rows, 561 columns.
    contains recorded features test data
* `y_test <- test/y_test.txt` : 2947 rows, 1 columns.
    contains test data of activities code labels
* `subject_train <- test/subject_train.txt` : 7352 rows, 1 column.
    contains train data of 21/30 volunteer subjects being observed
* `x_train <- test/X_train.txt` : 7352 rows, 561 columns .
    contains recorded features train data
* `y_train <- test/y_train.txt` : 7352 rows, 1 columns. 
    contains train data of activities’code labels
    
### Merges the training and the test sets to create one data set ###
* `x` (10299 rows, 561 columns) is created by merging `x_train` and `x_test` using `rbind()` function
* `y` (10299 rows, 1 column) is created by merging `y_train` and `y_test` using `rbind()` function
* `subject` (10299 rows, 1 column) is created by merging `subject_train` and `subject_test` using `rbind()` function
* `DT` (10299 rows, 563 column) is created by merging `subject`, `x` and `y` using `cbind()` function


### Extracts only the measurements on the mean and standard deviation for each measurement. ###
* `newDT` (10299 rows, 88 columns) is created by subsetting datatable `DT` where contain `subject`, `code`, `mean`, and `std`

### Uses descriptive activity names to name the activities in the data set ###
* Entire numbers in `code` column of the `newDT` replaced with corresponding activity taken from second column of the `activities` variable

### Appropriately labels the data set with descriptive variable names.
* rename column `code` (88th column) to `activity`
* rename column begin with `f` into `Frequency`
* rename column begin with `t` into `Time`
* rename column `BodyBody` into `Body`
* rename column `Acc` into `Accelerometer`
* rename column `Gyro` into `Gyroscope`
* rename column `Mag` into `Magnitude`
* rename column `-mean` into `Mean`
* rename column `-std` into `Stdev`
* rename column `freq` into `Frequency`
* rename column `angle` into `Angle`
* rename column `gravity` into `Gravity`
* rename column `tBody` into `TimeBody`

### From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject ###
* `ResultDT` (180 rows, 88 columns) is created by summarizing `newDT` and calculate the means of each variable for each activity and each subject, after groupped by subject and activity.
* Write `ResultDT` into `ResultData.txt file.
