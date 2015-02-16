ReadMe file | Getting and Cleaning Data
=========================================================


The following files are included in this project : 

- **run_analysis.R**: Contains the code thats reads & transforms the data into tidy data. The code starts by reading mesurements labels, then reads the IDs related to the means and standard deviation variables. The test and train data are then read and transformed into 2 dataframes that are merged using rbind. The final steps are to calculate the average of each variable for each activity and each subject and to export the file using write.table.
- **CodeBook.md**: Contains the variables, data and transformation.