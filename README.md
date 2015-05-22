# README for the Course Project
==================================================================

For the Johns Hopkins University class "Getting and Cleaning Data" on Coursera

==================================================================

TABLE OF CONTENTS

A. Elements of the Course Project Deliverable<br>
B. Objectives of the Script<br>
C. About The Raw Source Data<br>
D. Setup - Packages and Data Source<br>
E. Required Steps of the Script<br>
F. Loading the Tidy Data Set back into R

==================================================================

A. Elements of the Course Project Deliverable

The course project deliverable includes the following files in this repository:
  run_analysis.R : The script to perform the data manipulations described below
  CodeBook.md : An explanation of the data and its variables that are produced by the script
  README.md : This file which you are currently reading

==================================================================

B. Objectives of the Script

The script is intended to produce a tidy data set with averages for combinations of variable, subject and activity, where the variables are a short list of the original variables in the raw data (specifically, those pertaining to means or standard deviations).

==================================================================

C. About The Raw Source Data

The data provided was collected from the accelerometers from the Samsung Galaxy S smartphone. See this site for a full description of the data: 
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

The data can be downloaded here:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

==================================================================

D. Setup - Packages and Data Source

Packages: The script loads and uses plyr at step 5. The package can be installed with this command:
  install.packages("plyr")

Data Source: The zipped archive must be downloaded (from the link shown above). Then, the contents of the zip archive must be extracted to your working directory, such that the "UCI HAR Dataset" directory appears in your working directory.

==================================================================

E. Required Steps of the Script

The script is required to do the following: 
1. Merge the training and the test sets to create one data set.
2. Extract only the measurements on the mean and standard deviation for each measurement. 
3. Use descriptive activity names to name the activities in the data set
4. Appropriately label the data set with descriptive variable names. 
5.From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject.

Note #1: The script does not execute the steps in the order shown above.
This is how the script executes the steps:
  1. Create one data set: Partial - Reconsolidate the train and test files
  3. Descriptive Activity Names: Complete
  2. Extract Mean and Std Dev: Two sub-steps<br>
     2.1. Identify the desired columns from the "features" file<br>
     2.2. Use the resulting subset to extract columns from the main file<br>
  4. Apply descriptive variable names: Complete
  1. Create one data set: Completion - combine the main file with the "subjects" and "activities" files
  5. Create the final tidy data set

Note #2: About the descriptive variable names at step 4:<br>
In "David's personal course project FAQ" on the class discussion boards, there is a question that asks ...<br>
Q: Should I decompose the variable names<br>
A: No ... 

A detailed explanation follows, which is omitted here. The variable names have been left as provided in the features.txt file in the source zipped archive. Instead, explanations of the variable names are provided in the code book

==================================================================

F. Loading the Tidy Data Set back into R

The outputted text file will be difficult to visually parse in a typical text editor. For better viewing and subsequent analysis, the data set can be re-loaded and viewed within R using the following commands:

    data <- read.table(file_path, header = TRUE)
    View(data)

==================================================================

