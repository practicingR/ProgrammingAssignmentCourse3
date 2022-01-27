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
