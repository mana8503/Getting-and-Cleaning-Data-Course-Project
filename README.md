# Getting-and-Cleaning-Data-Course-Project

Getting and Cleaning Data Assignment
By Amanda Hughes
29 May 2020

Data was taken from:
Human Activity Recognition Using Smartphones Dataset
Version 1.0

Details about the UCI HAR Dataset be found in README file found in the data folder.

run.analysis()

- Takes cvs files downloaded from link below and reads them into R as data frames using read.table().

 https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

- The two data frames with test and training data were pieced together using rbind() to make one data set.  The table with features data was used as the column names.

- grepl() was used to pull out only the columns with mean and std data.

- gsub was used to rename parts of the column names for clarity.

- The tables containing the metadata (activity levels and subject no) were given column names and combined with cbind.  The metadata for testing and training tables were combined using rbind() to make one table for all the metadata.  

- cbind() combined the metadata with the dataset for one complete table.

- subsetting was used to change the variable in activity levels from numeric to the more descriptive categories.

- activity levels and subject no were converted to class of factors.

- aggregate() grouped the data by activity levels and subject no before find the mean for each column.  This was put into a table called tidyDF.

- write.table() writes the tidyDF table as a txt file in the working directory.


