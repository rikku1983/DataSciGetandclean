#Loading packages
library(plyr)
library(dplyr)

#reading data
activitylab<-read.table("./UCI HAR Dataset/activity_labels.txt",col.names=c("act","actdes"))
features<-read.table("./UCI HAR Dataset/features.txt")
test<-read.table("./UCI HAR Dataset/test/X_test.txt")
subtest<-read.table("./UCI HAR Dataset/test/subject_test.txt")
acttest<-read.table("./UCI HAR Dataset/test/y_test.txt")
acttrain<-read.table("./UCI HAR Dataset/train/y_train.txt")
train<-read.table("./UCI HAR Dataset/train/X_train.txt")
subtrain<-read.table("./UCI HAR Dataset/train/subject_train.txt")
#add subjects (as the last col) and col names (feature description) to both test and train data.frame
names(test)<-features[,2]
names(train)<-features[,2]

#Subset both test and train df with only columns about mean and std measurements.
meanidx<-grep("mean",features[,2])
stdidx<-grep("std",features[,2])
idx<-sort(c(meanidx,stdidx))
test2<-test[,idx]
train2<-train[,idx]

#adding sub numbers to both test and train and re-order columns
test2$sub<-subtest[,1]
train2$sub<-subtrain[,1]
test2<-test2[,c(ncol(test2),1:(ncol(test2)-1))]
train2<-train2[,c(ncol(train2),1:(ncol(train2)-1))] 

#Create factor variable indicating test or train group 
test2<-mutate(test2,group="test")
train2<-mutate(train2, group="train")
#Add activity code
test2$act<-acttest[,1]
train2$act<-acttrain[,1]
#merge the data set
df<-rbind(test2,train2)
df<-df[,c(1,ncol(df),2:(ncol(df)-1))]

#Add descriptive names to activities
df2<-merge(df,activitylab)
df2<-arrange(df2,sub)

#Create another data frame required by question 5
li<-split(df2,list(df2$act,df2$sub))
x<-colMeans(li[[1]][3:81])
for(i in 2:length(li)){
  x<-rbind(x,colMeans(li[[i]][3:81]))
}
rownames(x)<-names(li)
#add annotation
x<-as.data.frame(x)
x$sub<-rep(1:30, each=6)
x$activity<-rep(activitylab[,2],30)

#output new data set x to TXT file
write.table(x,"./data/getandclean/project/tidydata.txt",row.name=FALSE)

#the end


