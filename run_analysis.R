library(dplyr)

#Download the data
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

if (!file.exists("dataset.zip")) {
  download.file(url, "dataset.zip", method = "curl")
}
if (!file.exists("UCI HAR Dataset")) {
  unzip("dataset.zip")
}

#Load features and names of the activities of the subjects
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("index", "feature"))
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("id", "activity"))

# Get training data
train_subject <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
train_x <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$feature)
train_y <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "activity")

# Get test data
test_subject <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
test_x <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$feature)
test_y <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "activity")

#Merge training and test datasets
subject <- rbind(train_subject, test_subject)
x <- rbind(train_x, test_x)
y <- rbind(train_y, test_y)
merged_data <- cbind(subject, y, x)

#Extract mean and standard deviation measurements
selected_features <- grep("mean\\(\\)|std\\(\\)", features$feature)
selected_data <- merged_data[, c(1, 2, selected_features + 2)]  # +2 to account for subject and activity columns

selected_data$activity <- activities[selected_data$activity, 2]

#Label the data with descriptive variable names
names(selected_data) <- gsub("^t", "Time", names(selected_data))
names(selected_data) <- gsub("^f", "Frequency", names(selected_data))
names(selected_data) <- gsub("Acc", "Accelerometer", names(selected_data))
names(selected_data) <- gsub("Gyro", "Gyroscope", names(selected_data))
names(selected_data) <- gsub("Mag", "Magnitude", names(selected_data))
names(selected_data) <- gsub("BodyBody", "Body", names(selected_data))

#Create a tidy data with averages

tidy_data <- selected_data %>%
  group_by(subject, activity) %>%
  summarise(across(everything(), mean))

# Save to a file
write.table(tidy_data, "tidy_data.txt", row.names = FALSE)
