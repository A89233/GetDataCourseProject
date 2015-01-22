# load required libraries
print("Load dplyr library")
library(dplyr)

# Create working directory if doesn't exist
cwd <- getwd()
print(paste("Current working directory:", cwd))
if(!file.exists("./getdataproj")) {dir.create("./getdataproj")}
setwd(paste(cwd,"getdataproj",sep="/"))
print (paste("Changed working directory:", getwd()))

# Download the data package and unzip into working directory
file_location <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
print(paste("Downloading file from location:", file_location))
download.file(file_location, destfile="Dataset.zip", method="curl", quiet=TRUE)
print("Download complete")
print("Unzipping downloaded files")
unzip(zipfile="Dataset.zip")
print("Unzip complete")

# read the activity and features files downloaded and store in data frames
features <- read.table("UCI HAR Dataset/features.txt")
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")
print("Read files and assign column names")
# read the train data and test data and merge them for x, y and subject
# x has the measurements
# y has the activity measured
# subject has the device id
print("x... data has measurements")
print("y... data has activities measured")
print("subject... data has device id")
x_data <- tbl_df(rbind(read.table("UCI HAR Dataset/train/X_train.txt"), read.table("UCI HAR Dataset/test/X_test.txt")))
y_data <- tbl_df(rbind(read.table("UCI HAR Dataset/train/y_train.txt"), read.table("UCI HAR Dataset/test/y_test.txt")))
subject_data <- tbl_df(rbind(read.table("UCI HAR Dataset/train/subject_train.txt"), read.table("UCI HAR Dataset/test/subject_test.txt")))

# assign column names for dataframes created
names(x_data) <- features[,2]
names(y_data) <- "activity"
names(subject_data) <- "subject"

# modify y_data with activity labels 
y_data <- mutate(y_data, activity=activity_labels[activity,2])


# select columns wth "mean" or "std"
print("Select columns with mean and std measurements")
x_data_sub <- x_data[, grep("mean|std", colnames(x_data))]

# combine all data column binding subject, activity and measurements
print("Combine all data into one dataframe")
all_data <- tbl_df(cbind(subject_data, y_data, x_data_sub))

# group all data by subject and activity
print("Group measurement data by subject and activity")
group_data <- group_by(all_data, subject, activity)

# create tidy data frame bby calculating average of measurements by activity by subject
print("Create a new tidy data set with averages of all measurements by activity and subject")
tidy_data <- summarise_each(group_data, funs(mean))

# write tidy data created to a file for future usage
print(paste("Writing tidy data into a file:", paste(getwd(),"UCI_HAR_tidydata.txt",sep="/")))
write.table(tidy_data,file="UCI_HAR_tidydata.txt", col.names=TRUE, row.names=FALSE)
print("Written")

# set working directory back to previous
setwd(cwd)