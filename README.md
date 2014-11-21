## Getting and Cleaning Data Project
This project reads in data from the "UCI HAR" data set, available at https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

The original data measures a number of variables relating to cell phone measurements whilst the participant undertakes a number of different exercises.  In the original data, these are split into a training and a test set.

Here these two sets are combined, and only data regarding the means and standard deviations of parameters are maintained.  After running run_analysis.R, this data will be available in the object "data"

Further, each of these measurements - means and standard deviations are averaged for each participant, doing each activity.  This data is available in long format in summary after running run_analysis.R