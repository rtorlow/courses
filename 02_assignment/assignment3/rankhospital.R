


# Finding the best 
rankhospital <- function(state, outcome, num = "best") {
  
  ## Read outcome data
  out <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  suppressWarnings(
  out[, 11] <- as.numeric(out[, 11]))
  suppressWarnings(out[, 17] <- as.numeric(out[, 17]))
  suppressWarnings(out[, 23] <- as.numeric(out[, 23]))
  sick <- c("heart attack", "heart failure", "pneumonia")
  states <- unique(out$State)
  
  ## Check that state and outcome are valid
  if(!state %in% states) {
    stop ("invalid state")
  } else if (!outcome %in% sick){
    stop ("invalid outcome")
    } else if (outcome == sick[1]) {
    out <- out[, c(2, 7, 11)]
      }
      else if(outcome == sick[2]) {
        out <- out[, c(2, 7, 17)]
        }
          else if(outcome == sick[3]){
          out <- out[, c(2, 7, 23)]
  }
  ## Return hospital name in that state with the given rank
  ## 30-day death rate
  nam <- names(out)[length(names(out))]
  s <- na.omit(out[out$State==state, ])
  s <- dplyr::arrange_(s, nam,"Hospital.Name") 
  s$Rank <- c(1:nrow(s))
  ## Return hospital name in that state with lowest 30-day death rate
  if (num == "best") {
    s[1, 1]
  }
  else if (num == "worst"){
    s[nrow(s), 1]
  }
  else {
    s[num, 1]
  }
}


