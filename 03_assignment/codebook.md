## The codebook for Assignment 3 ( Course Getting and Cleaning Data)


## Variables:

ID - Persons ID (ranging from 1-30)
activity_label: Activity of person i
  -WALKING
  -WALKING_UPSTAIRS
  -WALKING_DOWNSTAIRS
  -SITTING
  -STANDING
  -LAYING

##The signals were used to estimate mean and std.ev. of each variable of the feature vector for each pattern: '-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

"tBodyAcc_mean__X" 
"tBodyAcc_mean__Y" 
"tBodyAcc_mean__Z" 
"tGravityAcc_mean__X" 
"tGravityAcc_mean__Y" 
"tGravityAcc_mean__Z" 
"tBodyAccJerk_mean__X" 
"tBodyAccJerk_mean__Y" 
"tBodyAccJerk_mean__Z" 
"tBodyGyro_mean__X" 
"tBodyGyro_mean__Y" 
"tBodyGyro_mean__Z" 
"tBodyGyroJerk_mean__X" 
"tBodyGyroJerk_mean__Y" 
"tBodyGyroJerk_mean__Z" 
"tBodyAccMag_mean_" "tGravityAccMag_mean_" 
"tBodyAccJerkMag_mean_" 
"tBodyGyroMag_mean_" 
"tBodyGyroJerkMag_mean_" 
"fBodyAcc_mean__X" 
"fBodyAcc_mean__Y" 
"fBodyAcc_mean__Z" 
"fBodyAcc_meanFreq__X" 
"fBodyAcc_meanFreq__Y" 
"fBodyAcc_meanFreq__Z" 
"fBodyAccJerk_mean__X" 
"fBodyAccJerk_mean__Y" 
"fBodyAccJerk_mean__Z" 
"fBodyAccJerk_meanFreq__X" 
"fBodyAccJerk_meanFreq__Y" 
"fBodyAccJerk_meanFreq__Z" 
"fBodyGyro_mean__X" 
"fBodyGyro_mean__Y" 
"fBodyGyro_mean__Z" 
"fBodyGyro_meanFreq__X" 
"fBodyGyro_meanFreq__Y" 
"fBodyGyro_meanFreq__Z" 
"fBodyAccMag_mean_" 
"fBodyAccMag_meanFreq_" 
"fBodyBodyAccJerkMag_mean_" 
"fBodyBodyAccJerkMag_meanFreq_" 
"fBodyBodyGyroMag_mean_" 
"fBodyBodyGyroMag_meanFreq_" 
"fBodyBodyGyroJerkMag_mean_" 
"fBodyBodyGyroJerkMag_meanFreq_" 
"angle(tBodyAccMean_gravity)" 
"angle(tBodyAccJerkMean)_gravityMean)" 
"angle(tBodyGyroMean_gravityMean)" 
"angle(tBodyGyroJerkMean_gravityMean)" 
"angle(X_gravityMean)" 
"angle(Y_gravityMean)" 
"angle(Z_gravityMean)" 
"tBodyAcc_std__X" 
"tBodyAcc_std__Y" 
"tBodyAcc_std__Z" 
"tGravityAcc_std__X" 
"tGravityAcc_std__Y" 
"tGravityAcc_std__Z" 
"tBodyAccJerk_std__X" 
"tBodyAccJerk_std__Y" 
"tBodyAccJerk_std__Z" 
"tBodyGyro_std__X" 
"tBodyGyro_std__Y" 
"tBodyGyro_std__Z" 
"tBodyGyroJerk_std__X" 
"tBodyGyroJerk_std__Y" 
"tBodyGyroJerk_std__Z" 
"tBodyAccMag_std_"
"tGravityAccMag_std_" 
"tBodyAccJerkMag_std_" 
"tBodyGyroMag_std_" 
"tBodyGyroJerkMag_std_"
"fBodyAcc_std__X" 
"fBodyAcc_std__Y"
"fBodyAcc_std__Z" 
"fBodyAccJerk_std__X" 
"fBodyAccJerk_std__Y"
"fBodyAccJerk_std__Z"
"fBodyGyro_std__X" 
"fBodyGyro_std__Y"
"fBodyGyro_std__Z"
"fBodyAccMag_std_"
"fBodyBodyAccJerkMag_std_"
"fBodyBodyGyroMag_std_"
"fBodyBodyGyroJerkMag_std_"


##Additional vectors obtained by averaging the signals in a signal window sample. These are used  on the angle() variable:
 
gravityMean
tBodyAccMean
tBodyAccJerkMean
tBodyGyroMean
tBodyGyroJerkMean 