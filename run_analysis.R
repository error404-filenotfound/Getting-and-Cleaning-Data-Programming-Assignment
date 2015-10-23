library(reshape2)



#setting the working directory
setwd("C:\\Users\\nonu\\Desktop\\Coursera\\(3) Getting & cleaning data")



#checking if the data file exists and unzip it
if(!file.exists("getdata-projectfiles-UCI HAR Dataset.zip"))
{
  fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileurl,destfile = "./getdata-projectfiles-UCI HAR Dataset.zip")
}

if(!file.exists("UCI HAR Dataset"))
{
  unzip("getdata-projectfiles-UCI HAR Dataset.zip")
}



#Setting the working directory down one level
setwd("./UCI HAR Dataset")



#reading the data
features <- read.table("./features.txt")
activity_labels <- read.table("./activity_labels.txt")

x_test <- read.table("./test/X_test.txt")
y_test <- read.table("./test/y_test.txt")
subject_test <- read.table("./test/subject_test.txt")

x_train <- read.table("./train/X_train.txt")
y_train <- read.table("./train/y_train.txt")
subject_train <- read.table("./train/subject_train.txt")



#preparing y variables
y_test[,2] = activity_labels[y_test[,1],2]

y_train[,2] = activity_labels[y_train[,1],2]



#naming the data(part 3 & 4)
names(x_test) <- features[,2]
names(y_test) = c("Activity_ID", "Activity_Label")
names(subject_test) <- "Subject_no"

names(x_train) <- features[,2]
names(y_train) = c("Activity_ID", "Activity_Label")
names(subject_train) <- "Subject_no"



#binding the test and train data
test_data <- cbind(subject_test,y_test,x_test)

train_data <- cbind(subject_train,y_train,x_train)



#merging the data (part 1)
merged_data <- rbind(test_data, train_data)



#extracting mean and sd (part 2)
data_extract <- merged_data[, grepl("mean|std",names(merged_data),ignore.case=TRUE)]
data <- cbind(merged_data[,1:3],data_extract)



#melting, dcast and writing tidy data (part 5)
molten_data <- melt(data, id = c("Subject_no", "Activity_Label", "Activity_ID"))
tidy_data <- dcast(molten_data, Subject_no + Activity_Label ~ variable, mean)
write.table(tidy_data, file = "./tidy_data.txt", row.name = FALSE)
