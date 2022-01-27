## Data Source
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

## Variables in this project
* `activitylabels` - Links the class labels with their activity name
* `features` - List of all features
* `trainingsubject` , `testsubject` -  Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.
* `trainingset` , `testset` - dataset for training data and test data, respectively
* `traininglabels` , `testlabels` - labels for training data and test data, respectively
* `subject` - merges `trainingsubject` and `testsubject`
* `dataset`- merges `trainingset` and `testset`
* `labels` - merges `traininglabels` and `testlabels`
* `mergeddata` - merges all of training and test datasets together
* `tidydata` - merged data set with only mean and standard deviation related columns
* `tidydataAverages`- averages the mean of each variable for each activity and each subject from `tidydata`

## About R Script

1. Unzip and download the data
   * Data is put into a folder called "UCI HAR Dataset" in the desired destination location
2. Read each file and merge datasets
   * Use `read.table()` to import datasets into R
   * Use descriptive names to name each table and columns within them
   * Merge all the data into one set named `mergeddata`
3. Extract only the measurements on the mean and standard deviation for each measurement
   * Use grepl and the metacharacter "|" to extract only the columns with "subject", "idnumber", "[Mm]ean" or "std" in its name
   * Name new set `tidydata`
4. Use descriptive activity names to name the activities in the data set
   * Rename "idnumber" column to the labels in `activitylabels` and rename the column "activity"
5. Use appropriate labels the data set with descriptive variable names
   * Rename columns using `sub()` and metacharacters to provide more descriptive names
6. From the data set in step 5, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
   * Use binary operators, `group_by()` and `summarize` to create a table with the averages
   * Name this table `tidydataAverages` and use the `write.table` function to create a text file of the table
