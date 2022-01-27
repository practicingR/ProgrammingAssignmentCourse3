## Unzip and download the data

        course3file <- "getdata_projectfiles_UCI HAR Dataset.zip"
  
     ### Data is put into a folder called "UCI HAR Dataset" in the desired destination location

      if (!file.exists(course3file)) {
       fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
         download.file(fileURL, destfile = "~/R/R Course/Course3-ProgrammingAssignment/Course3PeerAssignment", method="curl")
       }

       if(!file.exists("UCI HAR Dataset")){
          unzip(course3file)
        }


## Import dplyr package from library

      library(dplyr)

## Read each file and merge datasets

     ### Use `read.table()` to import datasets into R and use descriptive names to name each table and columns within them

        activitylabels <- read.table("~/R/R Course/Course3-ProgrammingAssignment/Course3PeerAssignment/UCI HAR Dataset/activity_labels.txt", quote="\"", comment.char="", col.names = c("idnumber", "activity"))

        features <- read.table("~/R/R Course/Course3-ProgrammingAssignment/Course3PeerAssignment/UCI HAR Dataset/features.txt", quote="\"", comment.char="", col.names = c("idnumber", "feature"))

        trainingsubject <- read.table("~/R/R Course/Course3-ProgrammingAssignment/Course3PeerAssignment/UCI HAR Dataset/train/subject_train.txt", quote="\"", comment.char="", col.names = "subject")

        trainingset <- read.table("~/R/R Course/Course3-ProgrammingAssignment/Course3PeerAssignment/UCI HAR Dataset/train/X_train.txt", quote="\"", comment.char="", col.names = c(features$feature))

        traininglabels <- read.table("~/R/R Course/Course3-ProgrammingAssignment/Course3PeerAssignment/UCI HAR Dataset/train/Y_train.txt", quote="\"", comment.char="", col.names = "idnumber")

        testsubject <- read.table("~/R/R Course/Course3-ProgrammingAssignment/Course3PeerAssignment/UCI HAR Dataset/test/subject_test.txt", quote="\"", comment.char="", col.names = "subject")

        testset <- read.table("~/R/R Course/Course3-ProgrammingAssignment/Course3PeerAssignment/UCI HAR Dataset/test/X_test.txt", quote="\"", comment.char="", col.names = c(features$feature))

        testlabels <- read.table("~/R/R Course/Course3-ProgrammingAssignment/Course3PeerAssignment/UCI HAR Dataset/test/Y_test.txt", quote="\"", comment.char="", col.names = "idnumber")

    ### Merge all the data into one set named `mergeddata`

        subject <- rbind(trainingsubject, testsubject)
        dataset <- rbind(trainingset, testset)
        labels <- rbind(traininglabels, testlabels)

        mergeddata <- cbind(subject, labels, dataset)


## Extract only the measurements on the mean and standard deviation for each measurement

    ### Use grepl and the metacharacter "|" to extract only the columns with "subject", "idnumber", "[Mm]ean" or "std" in its name. Name it "tidydata".

        tidydata <- mergeddata[,grepl("subject|idnumber|mean|std|Mean",names(mergeddata))]


## Use descriptive activity names to name the activities in the data set

    ### Rename "idnumber" column to the labels in "activitylabels" and rename the column "activity"

        tidydata$idnumber <- activitylabels[tidydata$idnumber,2]


## Use sub() and metacharacters to provide appropriate labels the data set with descriptive variable names
   
        names(tidydata)[2] <- "activity"
        names(tidydata) <- sub("^t","Time", names(tidydata),)
        names(tidydata) <- sub("^f","Frequency", names(tidydata),)
        names(tidydata) <- sub("Body","Body", names(tidydata),)
        names(tidydata) <- sub("tBody","TimeBody", names(tidydata),)
        names(tidydata) <- sub("BodyBody","Body", names(tidydata),)
        names(tidydata) <- sub("gravity","Gravity", names(tidydata),)
        names(tidydata) <- sub("Acc","Acceleration", names(tidydata),)
        names(tidydata) <- sub("Gyro","Gyroscope", names(tidydata),)
        names(tidydata) <- sub("Jerk","Jerk", names(tidydata),)
        names(tidydata) <- sub("Mag","Magnitude", names(tidydata),)
        names(tidydata) <- sub("mean()","Mean", names(tidydata),)
        names(tidydata) <- sub("std()","StandardDeviation", names(tidydata),)
        names(tidydata) <- sub("angle","Angle", names(tidydata),)


## Use binary operators to create a second, independent tidy data set with the average of each variable for each activity and each subject.

   ### Use binary operators, `group_by()` and `summarize` to create a table with the averages

        tidydataAverages <- tidydata %>% group_by(subject, activity) %>% summarize_all(funs(mean))

   ### Name this table `tidydataAverages` and use the `write.table` function to create a text file of the table

        write.table(tidydataAverages, "tidydataAverages.txt", row.name=FALSE)

