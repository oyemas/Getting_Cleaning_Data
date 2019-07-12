
## Getting and Cleaning Data (Coursera Course Project)
This readme file is generated to describe the R script "run_analysis.R".
This script is used to analyze data for the getting and cleaning data project,
a coursera course project in data science specialization.



## Getting, Cleaning, and Analyzing the Data
1.The script starts by downloading data from specified URL
2. Unzips the downloaded file
  * The data comes in 4 categories
  * Training Data set, Test Data set, Labels and variable names/headers
3. loads the data files using the read.table
4.Extracts a subset of the data to include mean and std of measurement
5.Reformats the headers to remove special characters
6.For each Training and Test dataset, the program merges the labels and subject fields in columns
7.The modified training and test data are now merged together as one data set
8. The variable/column names are then appended to the merged data frame


## Transforming the Data to create a new Dataframe
9. convert the subjectid and activity fields to factor variables
10. melt the entire data using the subjectid and activity variables as idenfifiers
11. Cast the melted data in 10 above using the "mean" option
12. Write the transformed data to a new dataframe file (tidydata.txt)






