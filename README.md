# Getting-and-Cleaning-Data-Course-Project

##Overall Objectives of the assignment are as follows:

###1. Merges the training and the test sets to create one data set.
###2. Extracts only the measurements on the mean and standard deviation for each measurement.
###3. Uses descriptive activity names to name the activities in the data set
###4. Appropriately labels the data set with descriptive variable names.
###5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


## About the R script
### The data analysis is done using the script run_analysis.R
### You may need to point to the location of the datafiles by modifying the 'in_dir' variable.
###rbind function is used to append the test and train data together. 
###colbind function is then used to add the activity information and subject information as 2 extra columns to the appended dataframe.
###next grep function is used to identify which measurements within the complete dataframe represents the mean and standard deviation.
###A subset of the merged dataframe is then created.
###Finally a new dataset is created which comprises of the average of all the measurements across combination of subject and activity