.libPaths("D:/R-project/Rpackages")

# install.packages("RMySQL")
# require(("RMySQL"))

# HDF5 ----
source("http://bioconductor.org/biocLite.R")
biocLite("rhdf5")

library(rhdf5)
created = h5createFile("example.h5")
created # TRUE

created = h5createGroup("example.h5","foo")
created = h5createGroup("example.h5","baa")
created = h5createGroup("example.h5","foo/foobaa")
h5ls("example.h5")

# write to groups

# Webscraping
url <- "http://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en"
library(XML)
library(httr); html2 = GET(url)
content2 = content(html2,as="text")
parsedHtml = htmlParse(content2,asText=TRUE)
xpathSApply(parsedHtml, "//title", xmlValue)
xpathSApply(html, "//td[@id='col-citedby']", xmlValue)
names(parsedHtml)
