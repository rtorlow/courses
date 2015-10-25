
# Read Me. This file describes how my code works.

- First, you need the "dplyr" and the "data.table" packages.

- The data needs to be in the sub folder "UCI HAR Dataset"

- data input starts with listing the files in the sub folders test and train, combine them in a list, and make a data frame of it

- the features.txt contains the variable names: to work with it is tricky, because it starts with leading number and contains some special characters which need to be removed before applying as column names

- I renamed the variable containing the person id to "ID"

- the variable label "activity_label" describes the activites (I used the original description)

- next I merge the two data sets and keep only the variables containing the character vectors "mean", "Mean", and "std".

- finally, I grouped by "ID" and "activity_label" and summarized it by creating means

- Work done!





