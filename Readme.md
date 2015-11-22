---
Clean and Tidy Data Project
title: "Readme"
author: "monalims"
date: "November 22, 2015"

---

This file describes the run_analysis.R script that I wrote for the project

The training and test data files are first loaded into data frames train_data (7352 rows and 561 cols) and test_data(2947 rows and 561 cols). A merged data set train_test_data is created using these two datasets. The new dataset (train_test_data) has 10299 rows and 561 cols. 

I then attempted Q4 in which I used the feature names from the features.txt as the column names

I then found out the column means and standard deviation for each feature.

On doing so, I realized that some features: fBodyAcc-bandsEnergy() were repeated thrice. There was no explanation as to why there were three columns of the same feature. This does not fit in the clean and tidy data theory where column represents a different feature. So, I replaced the first column of these features with the mean of the three columns. For e.g., columns 303,317, and 331 were fBodyAcc-bandsEnergy()1,8. So, I replaced column 303 with the mean of columns 303, 317, and 331 and then dropped columns 317 and 331. The resulting table had 10299 rows and 533 variables. 
I computed the column means and standard deviation for this new dataset

I then read the training and test data labels and replaced the number with its descriptive activity. For e.g., 1: "Walking",2: "Walking_upstairs",etc.

I read the subject information and created a data frame of the test and training data subjects. 

I then created a new dataset (modified_train_test_data) by adding the activty labels and subjects to the train_test_data. I then created a subset (new_dataset) which has the mean values of the features for each subject and activity. This new dataset is written into a text file (clean&tidyData_subset.txt). The codebook of the new column names is available in codebook.txt

