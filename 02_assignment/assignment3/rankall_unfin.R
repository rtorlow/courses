


rankall <- function(outcome, num = "best") {
  ## Read outcome data
  out <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  suppressWarnings(
    out[, 11] <- as.numeric(out[, 11]))
  suppressWarnings(out[, 17] <- as.numeric(out[, 17]))
  suppressWarnings(out[, 23] <- as.numeric(out[, 23]))
  sick <- c("heart attack", "heart failure", "pneumonia")
  states <- sort(unique(out$State))
  arr_len <- dplyr::n_distinct(out$State) 
  hospital <- rep("", arr_len)
  
  ## Check that state and outcome are valid
  if(!state %in% states) {
    stop ("invalid state")
  } else if (!outcome %in% sick){
    stop ("invalid outcome")
  } 
  else if (outcome == sick[1]) {
    out <- out[, c(2, 7, 11)]
  }
  else if(outcome == sick[2]) {
    out <- out[, c(2, 7, 17)]
  }
  else if(outcome == sick[3]){
    out <- out[, c(2, 7, 23)]
  }
  ## For each state, find the hospital of the given rank
  nam <- names(out)[length(names(out))]
  s <- na.omit(out)
  s <- dplyr::arrange_(s,"State", nam,"Hospital.Name")
  s$max <- ave(s$State, s$State, function(x) length(x))
  
  # loop for each state
  split.data <- split(s, s$State)
  split.data$max <- NA
    lapply(split.data, function(x) nrow(x))
  
  

  
  
  # create tmp file, indicating
  if (num == "best"){
  tmp <- dplyr::group_by(s, State) %>% dplyr::filter(row_number()==1)
  }
  if (num == "worst"){
    tmp <- dplyr::group_by(s, State) %>% dplyr::filter(row_number()==length(.))
  }
  else {
    tmp <- dplyr::group_by(s, State) %>% dplyr::filter(row_number()==num)
  }
  
  ## Return a data frame with the hospital names and the
  ## (abbreviated) state name
  fin <- data.frame(State=unique(s$State))
  suppressWarnings(fin <- dplyr::left_join(fin, tmp[, c(1:2)]))
  rm(tmp)
  fin <- dplyr::select(fin, hospital=Hospital.Name, state=State)
  fin
} 





