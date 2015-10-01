
pollutantmean <- function(directory, pollutant, id = 1:332) {
  files <- list.files(directory, full.names = TRUE)[id]
  tmp   <- vector(mode = "list", length = length(files))
  
    # load data as list
    for (i in seq_along(files)) {
      tmp[[i]] <- read.csv(files[[i]])
    }
    # bind to data frame
      output <- do.call(rbind, tmp)
    # calculate mean
      mean(output[, pollutant], na.rm = TRUE)       
}
      

