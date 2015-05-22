# SETUP
# Download the raw data from here:
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
# 
# Extract the contents of the UCI HAR folder in the zip file to your working directory, 
#   such that the following directories and files appear in your working directory:
#     train <DIR>
#     test <DIR>
#     activity_labels.txt
#     features.txt
#     features_info.txt
#     README.txt

# Load plyr - this will be required at the last step, to produce the average 
# values for each subject and activity
library(plyr)

# This script works on the X, y, and subject files from the train and test directories
# It will also use the activity_labels.txt and features.txt files 
# Load all these data files into R
# TRAIN FILES
x_train <- read.table("train/X_train.txt") 
y_train <- read.table("train/y_train.txt") 
subject_train <- read.table("train/subject_train.txt")

# TEST FILES
x_test <- read.table("test/X_test.txt") 
y_test <- read.table("test/y_test.txt") 
subject_test <- read.table("test/subject_test.txt") 

# COMMON FILES
features <- read.table("features.txt") 
activity_labels <- read.table("activity_labels.txt") 

# -----------------------

# STEP 1. MERGE THE TRAINING AND THE TEST SETS TO CREATE ONE DATA SET.
# This is the first part of step 1, to combine the train and test files.
# The completion of step 1 is after step 4 and before step 5, 
#   so we don't burn cpu cycles cbind'ing on the large unsubsetted x_train and x_test files.
x_data <- rbind(x_train, x_test) 
y_data <- rbind(y_train, y_test) 
subject_data <- rbind(subject_train, subject_test) 

# -----------------------

# STEP 3. USE DESCRIPTIVE ACTIVITY NAMES TO NAME THE ACTIVITIES IN THE DATA SET
# NOTE: The project instruction steps are not executed in numeric sequence
# activity_labels is applied to y_data
y_data[, 1] <- activity_labels[y_data[, 1], 2]

# -----------------------

# STEP 2. EXTRACT ONLY THE MEASUREMENTS ON THE MEAN AND STANDARD DEVIATION FOR EACH MEASUREMENT. 
# This is completed in two parts
#   2.1. Identify the columns from the "features" file,
#   2.2. Use the resulting features_subset to extract the columns from x_data

# 2.1. Identify columns to subset, within the features file
features_subset <- grep("-(mean|std)\\(\\)", features[,2])

# 2.2. Use the features_subset, to subset x_data
x_data <- x_data[,features_subset]

# -----------------------

# STEP 4. APPROPRIATELY LABEL THE DATA SET WITH DESCRIPTIVE VARIABLE NAMES. 
# NOTE: Per "David's personal course project FAQ" ...
# Q: Should I decompose the variable names
# A: No. ... <detailed explanation omitted here>
# Explanations of the variable names are provided in the code book
names(y_data) <- "Activity"
names(subject_data) <- "Subject"
names(x_data) <- features[features_subset, 2]

# -----------------------

# COMPLETION OF STEP 1.
# Combine the files into one data set
combined_data <- cbind(y_data, subject_data, x_data) 

# -----------------------

# STEP 5. FROM THE DATA SET IN STEP 4, CREATE A SECOND, INDEPENDENT TIDY DATA SET 
#    WITH THE AVERAGE OF EACH VARIABLE FOR EACH ACTIVITY AND EACH SUBJECT.
tidy_data <- ddply(combined_data, .(Subject, Activity), function(x) colMeans(x[3:68]))

# -----------------------

# WRITING THE FILE FOR SUBMISSION
# Per the submission instructions, "upload your data set as a txt file created 
#    with write.table() using row.name=FALSE"
write.table(tidy_data, "tidy_data.txt", row.name=FALSE)


