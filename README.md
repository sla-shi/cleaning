cleaning
========

Course project on the Getting and Cleaning Data 

## Introduction
This repository contains the R script to get and clean data collected from the 
accelerometers from the Samsung Galaxy S smartphone. A full description is available 
at the site where the data was obtained: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
The zipped data set is available here https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

As described in the dataset readme file: 
Dataset describes the experiments which have been carried out with a group of 30 volunteers within an age 
bracket of 19-48 years. The obtained dataset has been randomly partitioned into two sets, where 70% of the 
volunteers was selected for generating the training data and 30% the test data. Each person performed six activities 
(WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone on the waist.

## Getting the data
The script prepares the data by downloading the zip file when needed and unzips it. 

Then the activities labels are read from 'activity_labels.txt' which links the class labels with their activity name.
It also reads a 561-feature vector with time and frequency domain variables for each of the training and test records and 
accosiate each record with the activity name.

## Data processing
The training and test datasets are merged. Subset of selected columns was applied, leaving only columns with means and standard
deviation variables.

The final tidy dataset is an aggregation of the selected variables by the activity names which is written to the tidy.txt
file by the script.

