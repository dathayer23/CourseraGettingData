# CourseraGettingData
Project repository for Coursera Getting and Cleaning Data online course

## Analysis Steps to read data ##

1. Read in Feature Names text files.

2. Select names that contain the string mean or stdev.

3. Transform raw names to more readable format removing all symbols that are illegal as a R column name.

4. Read training and test data files using read.table function

5. Row bind test data to end to training data

6. Select the columns that correspond to the transformed variable names

7. Column bind Subject and Activity labels to data frame

8. Set column names for data frame to transformed feature names

## Analysis steps to create data summary ##

1. Create columns for Subject and activity pairs

2. select each variable column from first feature to last feature

3. for each column feature vector get the mean for each set of values grouped by subject and activity

4. Add new column of means to columns for Subject and activity pair.

5. Write created summary table to file.

## To Run Analysis ##

1. create directory for data set

2. cd to data dir

3. run script file


