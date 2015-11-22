##Clean and Tidy Data Project
##Goal: Create a tidy data that can be used for analysis later
##** Please note: I changed the order in which I attempted the questions

library(plyr)
##Q1: Merge the training and test data
 featureFile=read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/features.txt")
 
 train_data=read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt")
 
 test_data=read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt")
 
 
 train_test_data<-rbind(train_data,test_data) ##merged the two datasets with training data on top and test data below it
 
 ## Q4: Renames the columns names with descriptive names
 feature_names<-featureFile[,2]
 names(train_test_data)<-feature_names ##
 
 ## Q2: Extract the mean and standard deviation for each measurement
 
 colmean_vect1<-colMeans(train_test_data) ##col means of the combined dataset
 std_vect1<- apply(train_test_data, 2, sd)
 
 ##There are some repeated column names for fBodyAcc-bandsEnergy() for different bands
 ##replacing these columns with the mean of the values
 ##e.g. columns 303, 317, and 331 are fBodyAcc-bandsEnergy()1,8 and
 ##     columns 304, 318, and 332 are fBodyAcc-bandsEnergy()9,16, etc.
 ## Replacing first column (viz. 303 and 304) with the respective means
 ##e.g. column 303 is the rowmean of columns 303,317, and 331
 ##     column 304 is the rowmean of columns 304,318, and 332
 ## Resulting data set will have 10299 rows and 533 columns
 
 repeated_cols_indices<-c(303,317,331, 304,318,332,305,319,333,306,320,334,307,321,	335,308,322,336,
                          309,323,337, 310,324,338,311,325,339,312,326,340,313,327,341,
                          314,328,342,315,329,343,316,330,344)
 repeated_cols_mat<-matrix(repeated_cols_indices, nrow=14, ncol=3)
 
 for (i in 1:14){
   num<-repeated_cols_mat[i,]
   train_test_data[,num[1]]<-rowMeans(train_test_data[num])
   
 }
 drop_cols<-c(317,331, 318,332,319,333,320,334,321,	335,322,336,
              323,337, 324,338,325,339,326,340,327,341,
              328,342,329,343,330,344)
 
 train_test_data_mod<-train_test_data[,-drop_cols] ##modified train_test_data with 533 columns
 
 ##finding the mean and standard deviation for each measurement for the modified dataset
 colmean_vect<-colMeans(train_test_data_mod)
 std_vect<- apply(train_test_data_mod, 2, sd)
 
 
##getting the labels for the datasets
train_labels<-read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/Y_train.txt")
test_labels<-read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/Y_test.txt")
train_labels<-as.data.frame(train_labels)
test_labels<-as.data.frame(test_labels)

##creating a combined data frame of the labels
train_test_labels<-rbind(train_labels, test_labels) ##list of activity labels for the merged dataset


##Q3: creating a vector with descriptive activity names
for (j in 1:10299){
  
  if(train_test_labels[j,]==1)
    train_test_labels[j,]="Walking"
  else if (train_test_labels[j,]==2)
    train_test_labels[j,]="Walking_UPSTAIRS"
  else if (train_test_labels[j,]==3)
    train_test_labels[j,]="Walking_DOWNSTAIRS"
  else if (train_test_labels[j,]==4)
    train_test_labels[j,]="SITTING"
  else if (train_test_labels[j,]==5)
    train_test_labels[j,]="STANDING"
  else if (train_test_labels[j,]==6)
    train_test_labels[j,]="LAYING"
}

train_subject<- read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt")
test_subject<- read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt")
train_test_subject<-rbind(train_subject,test_subject)

 
modified_train_test_data<-data.frame("Subject"=train_test_subject,"Activity"=train_test_labels,train_test_data_mod)

##for some reason, the second and third column did not get labeld correctly, so renaming them below:
colnames(modified_train_test_data)[1] <- "Subject"
colnames(modified_train_test_data)[2] <- "Activity"

## Q5: 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
new_dataset<-ddply(modified_train_test_data, .(Subject,Activity), numcolwise(mean))


##saving the subset from Q5 to .txt files

write.table(new_dataset, file = "clean&tidyData_subset.txt",sep = " ",row.name=FALSE)

##save the codebook
write.table(feature_names, file = "codebook.txt",sep = " ",row.name=FALSE)

