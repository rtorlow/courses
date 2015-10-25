
getwd()
setwd("D:/zprivat/Coursera/DataScientist/")

if (!file.exists("course3_assign")) {
  dir.create("course3_assign")
}

setwd("./course3_assign")

if (!file.exists("./data")) {
  dir.create("./data")
}


fileUrl <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl, destfile = "./data/cameras.csv")
list.files()

dateDownloaded <- date()
dateDownloaded

# XML
library(XML)
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
doc <- xmlTreeParse(fileUrl,useInternal=TRUE)
rootNode <- xmlRoot(doc)
xmlName(rootNode)
names(rootNode)
rootNode[[1]][[1]]

xpathSApply(rootNode,c("//name", "//price"), xmlValue)

#Q1----
#Q1
getwd()
data <- read.csv("getdata_data_ss06hid.csv")
nrow(filter(data, VAL==24))

#Qu3
library(xlsx)
colIndex <- 7:15
rowIndex <- 18:23
dat <- read.xlsx("getdata_data_DATA.gov_NGAP.xlsx",sheetIndex=1,
                 colIndex=colIndex,rowIndex=rowIndex )
sum(dat$Zip*dat$Ext,na.rm=T) 

#Quiz3----
#Question1
require(data.table)
require("dplyr")

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileUrl, destfile = "./data/AmericComSurv.csv")
list.files("data/")
dat <- as.data.frame(fread("./data/AmericComSurv.csv"))
 
tmp<-   which(with(dat, ACR==3 & AGS==6))

# Question 2
require("jpeg")
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg" 
download.file(fileUrl, destfile = "./data/affe.jpg")

affe <- readJPEG("./data/affe.jpg", native = TRUE)
quantile(affe, probs = c(0.30,0.80))
plot(affe)

# Q3
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv" 
download.file(fileUrl, destfile = "./data/gdp.csv")
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv" 
download.file(fileUrl, destfile = "./data/educ.csv")

gdp <- read.csv2("./data/gdp.csv", sep = ",", header = TRUE, skip = 3,
                 stringsAsFactors = FALSE) %>%
  filter(Ranking!="" & X!="") %>%
  mutate(Ranking = as.numeric(Ranking),
         US.dollars. = as.numeric(gsub(",", "", US.dollars.))) %>%
  rename(CountryCode = X) 
  
educ <- read.csv2("./data/educ.csv", sep = ",", header = TRUE, stringsAsFactors = FALSE)
test <- inner_join(gdp, educ, by.x="iso", by.y="CountryCode") %>%
  arrange(desc(Ranking))
test[13,]

#Q4
test2 <- test %>%
  group_by(Income.Group) %>%
  summarise(mean_rank = mean(Ranking))
# Q5
test$cut <- cut(test$Ranking, 5)
table(test$cut, test$Income.Group)

