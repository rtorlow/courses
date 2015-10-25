rm(list = ls())
ls()

# ============================================================================= #
# Assignment
# ============================================================================= #

.libPaths("D:/R-project/Rpackages")
# .libPaths("D:/Robert_R/Rpackages")
require("dplyr")
require("data.table")

# ============================================================================= #
# Important info to solve the assignment
  # individuals: 30, randomly partitioned 70% into training, 30% into test
  # six activities: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING
  # they captured 3-axial linear acceleration and 3-axial angular velocity
# ============================================================================= #


# ============================================================================= #
# Data input ----
# ============================================================================= #
setwd("D:/zprivat/Coursera/DataScientist/courses/03_assignment")
# setwd("D:/Coursera/DataScientist/03_assignment")
list.files("./UCI HAR Dataset")

  # [1] "activity_labels.txt" "features.txt"        "features_info.txt"  
  # [4] "README.txt"          "test"                "train"


# labels
print(activity_lab <- fread("./UCI HAR Dataset/activity_labels.txt"))
  # V1                 V2
  # 1:  1            WALKING
  # 2:  2   WALKING_UPSTAIRS
  # 3:  3 WALKING_DOWNSTAIRS
  # 4:  4            SITTING
  # 5:  5           STANDING
  # 6:  6             LAYING
names(activity_lab) <- c("activity", "activity_lab")


features <- read.csv2("./UCI HAR Dataset/features.txt", 
                          stringsAsFactors = FALSE,
                          header = FALSE)
# features = variable labels

# variable names must not start with numbers...
# remove leading numbers
features$V1[1:9] <- substring(features$V1[1:9],3,50)
features$V1[10:99] <- substring(features$V1[10:99],4,50)
features$V1[100:561] <- substring(features$V1[100:561],5,50)

# replace special characters "()", "," , "."
features$V1 <- gsub("\\.", "_", features$V1)
features$V1 <- gsub("\\()", "_", features$V1)
features$V1 <- gsub("\\-", "_", features$V1)
features$V1 <- gsub("\\,", "_", features$V1)

# import "test" data set
setwd("./UCI HAR Dataset/test")
lsTestfiles <- list.files()[2:4] # first is folder

    # load data as list
    test   <- vector(mode = "list", length = length(lsTestfiles))
    for (i in seq_along(lsTestfiles)) {
      test[[i]] <- fread(lsTestfiles[[i]])
    }
   
# check dimensions
    dim(test[[1]]) #2947    1
    dim(test[[2]]) #2947  561
    dim(test[[3]]) #2947    1
    
table( test[[1]]$V1 ) # 9 individuals with 2947 observations
table( test[[3]]$V1 ) # activity labels

# rename
names(test[[1]]) <- "ID"
names(test[[2]]) <- features$V1
names(test[[3]]) <- "activity"

test_fin        <- as.data.frame(do.call(cbind, test))

# analog "train" data set
setwd("../train")    
lsTrainfiles <- list.files()[2:4] # first is folder

    # load data as list
    train   <- vector(mode = "list", length = length(lsTrainfiles))
    for (i in seq_along(lsTrainfiles)) {
      train[[i]] <- fread(lsTrainfiles[[i]])
    }
    
table( train[[1]]$V1 ) # 21 individuals with 7352 observations
# uhm... not really 70/30... anyway... ;-)

names(train[[1]]) <- "ID"
names(train[[2]]) <- features$V1
names(train[[3]]) <- "activity"

train_fin        <- as.data.frame(do.call(cbind, train))

# 1) Merges the training and the test sets to create one data set.----
# ============================================================================= #

dat <- rbind(test_fin, train_fin) %>%
  left_join(activity_lab)

# 2) Extract only the measurements on the mean and standard deviation for 
# each measurement.
# ============================================================================= #
n_distinct(features$V1) # 477 vs 561
# contains duplicated labels ("bandsEnergy")... remove
dat2 <- dat[, c(which( !duplicated( names(dat)))) ]
# keep means and std only
dat2 <- select(dat2, ID, activity_lab, contains("mean"), 
               contains("Mean"), contains("std"))

# 3) Uses descriptive activity names to name the activities in the data set
# cf. variable activity label

# 4) Appropriately labels the data set with descriptive variable names. 
# used the original labels but removed special character 

# 5) From the data set in step 4, creates a second, independent tidy data set 
# with the average of each variable for each activity and each subject.
dat3 <- group_by(dat2, ID, activity_lab) %>%
  summarise_each(funs(mean))

write.table(dat3, "../../tidy_data.txt", row.name=FALSE)
