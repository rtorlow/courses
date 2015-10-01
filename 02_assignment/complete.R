
complete <- function(directory, id = 1:332) {
  files <- list.files(directory, full.names = TRUE)[id]
  tmp   <- vector(mode = "list", length = length(files))
  
  # load data as list
  for (i in seq_along(files)) {
    tmp[[i]] <- sum(complete.cases(read.csv(files[[i]])))
  }
  
  # bind to data frame
  output        <- as.data.frame(do.call(rbind, tmp))
  output$id     <- id
  output$nobs   <- output$V1
  output$V1     <- NULL
  output
  
}

