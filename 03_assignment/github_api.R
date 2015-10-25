
# ============================================================================= #
# Q1 Quiz2
# ============================================================================= #


# NOT RUN In R-STUDIO, only R Original is working!!!
.libPaths("D:/R-project/Rpackages")

library(httr)

# 1. Find OAuth settings for github:
#    http://developer.github.com/v3/oauth/
oauth_endpoints("github")

# 2. To make your own application, register at at
#    https://github.com/settings/applications. 
#    Use any URL for the homepage URL (http://github.com is fine) 
#     and  http://localhost:1410 as the callback url
#
#    Replace your key and secret below.
myapp <- oauth_app("github",
                   key = "a2f0703cb64735d0817b",
                   secret = "0ab99cdcf3764c5416744ed60b6261b89d030346")

# 3. Get OAuth credentials
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

# 4. Use API
gtoken <- config(token = github_token)
req <- GET("https://api.github.com/users/jtleek/repos", gtoken)
stop_for_status(req)
content(req)


library(jsonlite)
jsonData <- fromJSON("https://api.github.com/users/jtleek/repos")
names(jsonData)
jsonData[45]$[7]
jsonData$name[7]
jsonData
test2 <- dplyr::filter(jsonData, name=="datasharing")

# ============================================================================= #
# Q2/Q3 in quiz 2
# ============================================================================= #

require("sqldf")
setwd("D:/Coursera/DataScientist/03_assignment")

acs <- read.csv("getdata_data_ss06pid.csv")
test <- sqldf("select pwgtp1 from acs where AGEP < 50")
test2 <- dplyr::filter(acs, AGEP <50)

#Q3
unique(acs$AGEP)
sqldf("select distinct AGEP from acs")

# ============================================================================= #
# Q4 in quiz 2
# ============================================================================= #

con = url("http://biostat.jhsph.edu/~jleek/contact.html")
htmlCode = readLines(con)
close(con)
nchar(htmlCode[c(10,20,30,100)])




# ============================================================================= #
# Q5 in quiz 2
# ============================================================================= #
test <- read.fwf("getdata_wksst8110.for", widths = c(10, 5, 4,4,5,4,4,5,4,4,5,4,4),
                  skip = 4)
sum(test$V6)
#32426.7









