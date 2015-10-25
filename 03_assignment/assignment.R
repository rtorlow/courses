rm(list = ls())
ls()

# ============================================================================= #
# Assignment
# ============================================================================= #


.libPaths("D:/Robert_R/Rpackages")
require("dplyr")
require("data.table")

# ============================================================================= #
# Important info to solve the assignment
  # individuals: 30, randomly partitioned 70% into training, 30% into test
  # six activities: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING
  # they captured 3-axial linear acceleration and 3-axial angular velocity
  # 
# ============================================================================= #


# ============================================================================= #
# Data input ----
# ============================================================================= #

setwd("D:/Coursera/DataScientist/03_assignment")
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

dim(features <- fread("./UCI HAR Dataset/features.txt")) # 561   2
# features = variable labels

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
names(test[[1]]) <- "ID"
names(test[[2]]) <- features$V2

test2        <- as.data.frame(do.call(cbind, test))
    

# "train" data set
    
setwd("../train")    
lsTrainfiles <- list.files()[2:4] # first is folder

    # load data as list
    train   <- vector(mode = "list", length = length(lsTrainfiles))
    for (i in seq_along(lsTrainfiles)) {
      train[[i]] <- fread(lsTrainfiles[[i]])
    }
    
table( test[[1]]$V1 ) # 9 individuals with 2947 observations
table( train[[1]]$V1 ) # 21 individuals with 7352 observations
# uhm... not really 70/30... anyway... ;-)

# rename variable to IndID
IndID <- test[[1]]$V1




names(x_test) <- features$V2

features <- fread("features.txt")


y_test2 <- left_join(y_test, activity_lab) # note: rearrange order!




setwd("D:/zprivat/Coursera/DataScientist/courses/03_assignment/UCI HAR Dataset/train/Inertial Signals")




setwd("D:/zprivat/Coursera/DataScientist/courses/03_assignment/UCI HAR Dataset")

