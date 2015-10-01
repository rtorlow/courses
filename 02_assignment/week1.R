

setwd("D:/Coursera/DataScientist")

getwd()
hw <- read.csv("hw1_data.csv")
names(hw)
hw[1:2,]
hw[(nrow(hw)-1):nrow(hw) ,]
hw[47, "Ozone"]
length(summary(hw$Ozone))
attach(hw)
mean(Ozone, na.rm=TRUE)

sub <- dplyr::filter(hw, Ozone>31, Temp>90)
summary(sub$Solar.R)
sub <- dplyr::filter(hw, Month==5)
summary(sub$Ozone)


