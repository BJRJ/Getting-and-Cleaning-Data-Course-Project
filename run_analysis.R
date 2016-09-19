##########clear console##########################
cat("\014")  
rm(list=ls())


##########Read the test data#######################
in_dir<-'C://datascience//cleaning_data//week4//assignment//UCI HAR Dataset//test'
setwd(in_dir)
subject_test<-read.table('subject_test.txt')
X_test<-read.table('X_test.txt')
y_test<-read.table('y_test.txt')


############Read the train data####################
in_dir<-'C://datascience//cleaning_data//week4//assignment//UCI HAR Dataset//train'
setwd(in_dir)
subject_train<-read.table('subject_train.txt')
X_train<-read.table('X_train.txt')
y_train<-read.table('y_train.txt')

##########Read features info file##################
in_dir<-'C://datascience//cleaning_data//week4//assignment//UCI HAR Dataset'
setwd(in_dir)
features<-read.table('features.txt')

#######Merge the test and train data############
train_test<-rbind(X_test,X_train)

#####assign column names from the feature file#########3
colnames(train_test)<-features$V2

####merge test and train labels################
y_train_test<-rbind(y_test,y_train)

####merge test and train subject ids###########
subject_train_test<-rbind(subject_test,subject_train)

########add merged subject ids and test/train labels to the merged data frame##########
train_test<-cbind(train_test,subject_train_test)
colnames(train_test)[which(names(train_test) == "V1")] <- "subject"

train_test<-cbind(train_test,y_train_test)
colnames(train_test)[which(names(train_test) == "V1")] <- "activity"

####get the mean and std measurements columns###############3
measurement_names<-names(train_test)
mean_std_columns<-(grep("mean\\(\\)|std\\(\\)",measurement_names,value = TRUE))

##########add subject and activity columns as well to the list########33
mean_std_columns[length(mean_std_columns)+1]<-c('subject')
mean_std_columns[length(mean_std_columns)+1]<-c('activity')

#########subset the original df with mean and std columns##########
mean_std_df<-subset(train_test,select=mean_std_columns)


#####add description of activity based on the file 'activity_labels.txt'#############
activity_labels<-read.table('activity_labels.txt')

for (i in 1:(dim(activity_labels)[1]))
  {
  mean_std_df$activity_names[mean_std_df$activity==activity_labels$V1[i]]<-as.character(activity_labels$V2[i])
  
}

########Find mean for each unique combination of subject and activity###############

tidy_data<- aggregate(. ~ subject - activity -activity_names, data = mean_std_df, mean) 

#######write data to file##############################3
write.table(tidy_data, "tidy_data.txt", row.name=FALSE)


