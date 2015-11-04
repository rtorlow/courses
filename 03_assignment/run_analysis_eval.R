# Stud 1 ----

nicenames <- function(x, pattern, replacement,...){
  for(i in 1:length(pattern)){
    x <- gsub(pattern[i], replacement[i], x, ignore.case = TRUE,...)
  }
  x
}

library(dplyr)

testSet <- tbl_df(read.table("GettingNCleaning/Course Project/test/X_test.txt"))
trainSet <- tbl_df(read.table("GettingNCleaning/Course Project/train/X_train.txt"))
data  <- rbind(testSet, trainSet) ##1
featuresTable <- tbl_df(read.table("GettingNCleaning/Course Project/features.txt"))
columnsOfInterest <- featuresTable[grepl("mean", featuresTable$V2) | 
                                     grepl("std", featuresTable$V2),]
dataOfInterest <- data[,columnsOfInterest$V1] ##2

activityLabels <- tbl_df(read.table("GettingNCleaning/Course Project/activity_labels.txt"))

trainLabel <- tbl_df(read.table("GettingNCleaning/Course Project/train/y_train.txt"))
testLabel <- tbl_df(read.table("GettingNCleaning/Course Project/test/y_test.txt"))
dataLabels <- rbind(testLabel,trainLabel)

for(i in 1:length(dataLabels$V1)){
  dataLabels$V1[i] <- as.character(activityLabels$V2[as.integer(dataLabels$V1[i])])
}

dataOfInterest <- cbind(dataLabels,dataOfInterest)##3

from <- c("\\(","\\)","-","acc","std","bodybody","mag","freq","gyro")
to <- c("","","","acceleration","standarddeviation","body","magnitude","frequency","gyroscope")


columnsOfInterest$V2 <- tolower(sapply(columnsOfInterest$V2, nicenames,from,to))

columnsOfInterest <- rbind(data.frame(V1 = 562, V2= "activity"),columnsOfInterest)  ##4 Create a regular expression to adjust names
colnames(dataOfInterest) <- columnsOfInterest$V2

testSubjects <- tbl_df(read.table("GettingNCleaning/Course Project/test/subject_test.txt"))
trainSubjects <- tbl_df(read.table("GettingNCleaning/Course Project/train//subject_train.txt"))
subjectsSet <- rbind(testSubjects,trainSubjects)
colnames(subjectsSet) <- "subject"
dataOfInterest <- cbind(subjectsSet,dataOfInterest)


subjectActivityMeanSet<- dataOfInterest %>% group_by(subject,activity) %>% summarise_each(funs(mean))

write.table(subjectActivityMeanSet,"tidydata.txt", row.names = FALSE)



# Student 2 -----

# STEP 1 Merge training and test sets

library(plyr); library(dplyr)

setwd("~/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/")
features <- read.table("features.txt")
activity_labels <- read.table("activity_labels.txt")

setwd("~/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train")
X_train <- read.table("X_train.txt")
y_train <- read.table("y_train.txt")
subject_train <- read.table("subject_train.txt")

setwd("~/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test")
X_test <- read.table("X_test.txt")
y_test <- read.table("y_test.txt")
subject_test <- read.table("subject_test.txt")

datatrain <- cbind(subject = subject_train$V1, activity = y_train$V1, X_train)
datatest <- cbind(subject = subject_test$V1, activity = y_test$V1, X_test)
data1 <- rbind(datatrain, datatest)

#STEP 2 Extract mean and std of measurements
meangrep <-grep("mean()",features$V2)
meanfgrep <-grep("meanFreq()",features$V2)
meangrep <- meangrep[!meangrep %in% meanfgrep]
stdgrep <-grep("std()",features$V2)
reqfeatures <- sort(as.numeric(unique(c(meangrep, stdgrep))))
meanstd <- sort(as.numeric(unique(c(1,2, meangrep+2, stdgrep+2))))
data2 <- data1[,meanstd]

#STEP 3 Name the activities

data2[,"activity"] <- factor(x = data2[,2], labels = activity_labels$V2, levels = 1:6)


#STEP 4 Descriptive variables names
names(data2) <- c("subject","activity",as.character(features$V2[reqfeatures]))

#STEP 5 Mean of each variable for each subject and each activity
data3 <- data2 %>% group_by(subject,activity) %>% summarise_each(funs(mean))

write.table(data3, "data3.txt", row.name = FALSE)

# Student 3----
## Read Test Set
xtest <- data.table(read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt"))
## Read Test Lables
ytest <- data.table(read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/y_test.txt"))
## Read Test Subject list
testsubj <- data.table(read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt"))
## Read Train Set
xtrain <- data.table(read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt"))
## Read Train Labels
ytrain <- data.table(read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/y_train.txt"))
## Read Train Subject List
trainsubj <- data.table(read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt"))
## Read Train Subject List
actlabels <- data.table(read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt"))
## Read Activity descriptive labels
activity <- data.table(read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/activity_labels.txt"))

##Combine the labels in train and test
alllabels <- rbind(ytrain, ytest)

## Replace the activity numbers column with descriptive activity labels.
alllabels$V1 <- activity$V2[alllabels$V1]

## Combine the train and test data
alldat <- rbind (xtrain, xtest)

## Combine all the subjects in the same order as data.
allsubj <- rbind (trainsubj, testsubj)

## name all the columns in alldat using features.txt
## first read in features.txt
collabels <- data.table(read.table("./getdata-projectfiles-UCI HAR Dataset//UCI HAR Dataset/features.txt"))
## create a charachter vector containing new colnames.
newcolname <- as.character(collabels$V2)
## create a charachter vector containing old col names in alldat
oldcolname <- as.character(colnames(alldat))
## rename the columnes of alldat
setnames(alldat, oldcolname, newcolname)

## Now try to select only the columns that have mean and std dev information.
reqddat <- as.data.frame(alldat)
reqddat<-reqddat[,grep("\\bmean()\\b|std()",colnames(reqddat))]

## Combine the labels to the selected columns (reqddat)
## Activity labels become the first column and rename it to Activity.
reqddat <- cbind(alllabels, reqddat)
setnames(reqddat, "V1", "Activity")

##Combine the subject ids to alldat
## Add subject id as the first column and now activities become the second
## column
reqddat <- cbind(allsubj, reqddat)
## Rename the first column as SubjectID and the second column as Activity
setnames(reqddat, "V1", "SubjectID")

## Group the data based on SubjectID & Activity, then calculate the mean for each column
datmean <- reqddat %>%
  group_by(SubjectID, Activity) %>%
  summarise_each(funs(mean))

## Rename the column nanes of "datmean" to follow tidy data guidelines.
datmean <- rename(datmean, subjectid = SubjectID)
datmean <- rename(datmean, activity = Activity)
datmean <- rename(datmean, tbodyaccmeanx = `tBodyAcc-mean()-X`)
datmean <- rename(datmean, tbodyaccmeany = `tBodyAcc-mean()-Y`)
datmean <- rename(datmean, tbodyaccmeanz = `tBodyAcc-mean()-Z`)
datmean <- rename(datmean, tbodyaccstdx = `tBodyAcc-std()-X`)
datmean <- rename(datmean, tbodyaccstdy = `tBodyAcc-std()-Y`)
datmean <- rename(datmean, tbodyaccstdz = `tBodyAcc-std()-Z`) 
datmean <- rename(datmean, tgravityaccmeanx = `tGravityAcc-mean()-X`)
datmean <- rename(datmean, tgravityaccmeany = `tGravityAcc-mean()-Y`)
datmean <- rename(datmean, tgravityaccmeanz = `tGravityAcc-mean()-Z`)
datmean <- rename(datmean, tgravityaccstdx = `tGravityAcc-std()-X`)
datmean <- rename(datmean, tgravityaccstdy = `tGravityAcc-std()-Y`)
datmean <- rename(datmean, tgravityaccstdz = `tGravityAcc-std()-Z`)
datmean <- rename(datmean, tbodyaccjerkmeanx = `tBodyAccJerk-mean()-X`)
datmean <- rename(datmean, tbodyaccjerkmeany = `tBodyAccJerk-mean()-Y`)
datmean <- rename(datmean, tbodyaccjerkmeanz = `tBodyAccJerk-mean()-Z`)
datmean <- rename(datmean, tbodyaccjerkstdx = `tBodyAccJerk-std()-X`)
datmean <- rename(datmean, tbodyaccjerkstdy = `tBodyAccJerk-std()-Y`)
datmean <- rename(datmean, tbodyaccjerkstdz = `tBodyAccJerk-std()-Z`)
datmean <- rename(datmean, tbodygyromeanx = `tBodyGyro-mean()-X`)
datmean <- rename(datmean, tbodygyromeany = `tBodyGyro-mean()-Y`)
datmean <- rename(datmean, tbodygyromeanz = `tBodyGyro-mean()-Z`)
datmean <- rename(datmean, tbodygyrostdx = `tBodyGyro-std()-X`)
datmean <- rename(datmean, tbodygyrostdy = `tBodyGyro-std()-Y`)
datmean <- rename(datmean, tbodygyrostdz = `tBodyGyro-std()-Z`)
datmean <- rename(datmean, tbodygyrojerkmeanx = `tBodyGyroJerk-mean()-X`)
datmean <- rename(datmean, tbodygyrojerkmeany = `tBodyGyroJerk-mean()-Y`)
datmean <- rename(datmean, tbodygyrojerkmeanz = `tBodyGyroJerk-mean()-Z`)
datmean <- rename(datmean, tbodygyrojerkstdx = `tBodyGyroJerk-std()-X`)
datmean <- rename(datmean, tbodygyrojerkstdy = `tBodyGyroJerk-std()-Y`)
datmean <- rename(datmean, tbodygyrojerkstdz = `tBodyGyroJerk-std()-Z`)
datmean <- rename(datmean, tbodyaccmagmean = `tBodyAccMag-mean()`)
datmean <- rename(datmean, tbodyaccmagstd = `tBodyAccMag-std()`)
datmean <- rename(datmean, tgravityaccmagmean = `tGravityAccMag-mean()`)
datmean <- rename(datmean, tgravityaccmagstd = `tGravityAccMag-std()`)
datmean <- rename(datmean, tbodyjerkmagmean = `tBodyAccJerkMag-mean()`)
datmean <- rename(datmean, tbodyaccjerkmagstd = `tBodyAccJerkMag-std()`)
datmean <- rename(datmean, tbodygyromagmean = `tBodyGyroMag-mean()`)
datmean <- rename(datmean, tbodygyromagstd = `tBodyGyroMag-std()`)
datmean <- rename(datmean, tbodyjerkmagmean = `tBodyGyroJerkMag-mean()`)
datmean <- rename(datmean, tbodygyrojerkmagstd = `tBodyGyroJerkMag-std()`)
datmean <- rename(datmean, fbodyaccmeanx = `fBodyAcc-mean()-X`)
datmean <- rename(datmean, fbodyaccmeany = `fBodyAcc-mean()-Y`)
datmean <- rename(datmean, fbodyaccmeanz = `fBodyAcc-mean()-Z`)
datmean <- rename(datmean, fbodyaccstdx = `fBodyAcc-std()-X`)
datmean <- rename(datmean, fbodyaccstdy = `fBodyAcc-std()-Y`)
datmean <- rename(datmean, fbodyaccstdz = `fBodyAcc-std()-Z`)
datmean <- rename(datmean, fbodyaccjerkmeanx = `fBodyAccJerk-mean()-X`)
datmean <- rename(datmean, fbodyaccjerkmeany = `fBodyAccJerk-mean()-Y`)
datmean <- rename(datmean, fbodyaccjerkmeanz = `fBodyAccJerk-mean()-Z`)
datmean <- rename(datmean, fbodyaccjerkstdx = `fBodyAccJerk-std()-X`)
datmean <- rename(datmean, fbodyaccjerkstdy = `fBodyAccJerk-std()-Y`)
datmean <- rename(datmean, fbodyaccjerkstdz = `fBodyAccJerk-std()-Z`)
datmean <- rename(datmean, fbodygyromeanx = `fBodyGyro-mean()-X`)
datmean <- rename(datmean, fbodygyromeany = `fBodyGyro-mean()-Y`)
datmean <- rename(datmean, fbodygyromeanz = `fBodyGyro-mean()-Z`)
datmean <- rename(datmean, fbodygyrostdx = `fBodyGyro-std()-X`)
datmean <- rename(datmean, fbodygyrostdy = `fBodyGyro-std()-Y`)
datmean <- rename(datmean, fbodygyrostdz = `fBodyGyro-std()-Z`)
datmean <- rename(datmean, fbodyaccmagmean = `fBodyAccMag-mean()`)
datmean <- rename(datmean, fbodyaccmagstd = `fBodyAccMag-std()`)
datmean <- rename(datmean, fbodyaccjerkmagmean = `fBodyBodyAccJerkMag-mean()`)
datmean <- rename(datmean, fbodyaccjerkmagstd = `fBodyBodyAccJerkMag-std()`)
datmean <- rename(datmean, fbodybodygyromagmean = `fBodyBodyGyroMag-mean()`)
datmean <- rename(datmean, fbodygyromagstd  = `fBodyBodyGyroMag-std()`)
datmean <- rename(datmean, fbodygyrojerkmagmean = `fBodyBodyGyroJerkMag-mean()`)
datmean <- rename(datmean, fbodygyrojerkmagstd = `fBodyBodyGyroJerkMag-std()`)

# Student 4 ----

## John Kirker
## Getting and Cleaning Data Course Project
## Due 10/25/2015
## assume data used is in local workspace
## using "../UCI HAR Dataset/test"
## using "../UCI HAR Dataset/train"

##library(dplyr)
library(reshape2)
######################### LOAD TABLES ###########################
## test
xTest <- read.table("UCI HAR Dataset/test/X_test.txt")
yTest <- read.table("UCI HAR Dataset/test/y_test.txt")
subjectTest <- read.table("UCI HAR Dataset/test/subject_test.txt")
## train
xTrain <- read.table("UCI HAR Dataset/train/X_train.txt")
yTrain <- read.table("UCI HAR Dataset/train/y_train.txt")
subjectTrain <- read.table("UCI HAR Dataset/train/subject_train.txt")
## features
features <- read.table("UCI HAR Dataset/features.txt")
## activity
activityLbls <- read.table("UCI HAR Dataset/activity_labels.txt")
#################################################################
################### COMBINE TEST/TRAIN TABLES ###################
## combine X
xMerged <- rbind(xTest,xTrain)
## combine y
yMerged <- rbind(yTest,yTrain)
## combine subject
subjectMerged <- rbind(subjectTest,subjectTrain)
#################################################################
## gather only columns with "mean" and "std" in name
columnNames <- grep("-(mean|std)\\(\\)", features[, 2])
# subset xData
xMerged <- xMerged[, columnNames]
# change column names
names(xMerged) <- features[columnNames, 2]
yMerged[,1] <- activityLbls[yMerged[,1], 2]
names(yMerged) <- "Activity"
names(subjectMerged) <- "Subject"

## Combine everything
globalData <- cbind(xMerged, yMerged, subjectMerged)
#dataCol <- ncol(globalData) - 2
## Melt and cast
globalData.melted <- melt(globalData, id = c("Subject","Activity"))
globalData.mean <- dcast(globalData.melted, Subject + Activity ~ variable, mean)
## write tidy data to txt file
write.table(globalData.mean,"tidyData.txt", row.names = FALSE, quote = FALSE)

