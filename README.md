# Coursera - Getting and Cleaning Data Course Project

This repository contains my solution for the course project.

This project needs data from the following dataset:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The script `run_analysis.R` assume the file above was downloaded and extracted into
the project directory, with the name `UCI HAR Dataset/`.


## Description of data cleanup

As we are interested only in the features related to mean and standard deviation, the
script filter the data to get only the columns that features `"mean"` or `"std"` in its name.

Also, we replace the activity number code for the respective name, loading it as a factor
in the R dataframe.

Later on, we group all this data by subject and activity, getting the average for all
filtered columns in each group.


## Project description:

You will be required to submit:

1) a tidy data set as described below,
2) a link to a Github repository with your script for performing the analysis, and
3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md.

You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected. 


You should create one R script called `run_analysis.R` that does the following:

1. Merges the training and the test sets to create one data set.

2. Extracts only the measurements on the mean and standard deviation for each measurement. 

3. Uses descriptive activity names to name the activities in the data set

4. Appropriately labels the data set with descriptive activity names. 

5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

