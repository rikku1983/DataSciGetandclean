#Get and Clean Data Project Readme

-Install plyr and dplyr packages first to make sure this code works
-reading all data into computer stored as data.frames.
-Subset both test and train df with only columns about mean and std measurements.
-adding subjects codes to both test and train and re-order columns
-Create factor variable indicating test or train group 
-Add activity code to each data sets
-merge the data set by using rbind()
-Add descriptive names to activities by merge activitylab data.frame
-Create another data frame required by question 5
  *splite whole data set into 180 (6 times 30) subsets with eachone contain data from one subject and one activity
  *loop through all 180 items in the list and calculate colMeans()
  *combine all 180 colmeans to single data frame and add anotations about subjects and activities
-output new data set x to tidydat.TXT file with write.table() function 

##Thanks