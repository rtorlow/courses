

corr <- function(directory, threshold = 0) {
  
  out1 <- complete(directory)
  out1 <- dplyr::filter(out1, nobs >= threshold)
  
  files <- list.files(directory, full.names = TRUE)[out1$id]
  tmp   <- vector(mode = "list", length = length(files))
  
  # load data as a list
  for (i in seq_along(files)) {
    tmp[[i]] <- read.csv(files[[i]])
  }
  # calculate correlations
  if (threshold > max(out1$nobs, rm.na = TRUE)) {
    vector(mode = "numeric")
  } else {
  na.omit(
    sapply(tmp,  function(x) 
            cor(x$sulfate, x$nitrate, 
                use = "pairwise.complete.obs")))
  }
} 
  