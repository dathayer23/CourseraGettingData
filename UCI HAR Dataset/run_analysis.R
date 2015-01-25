## File Run_Analysis.R
## Author David Thayer
## Date 1/24/2015

## load packages needed
require(stringr)
require(dplyr)

## Take a string of doubles representations and convert to a vector of doubles
transformLineToVector <- function (l) {
  sapply((str_split(l, "\\s+")), as.numeric)
}

## Take a string with and activity label in second token and return the token
transformLineToLabel <- function(l) {
  str_split(l, "\\s+")[[1]][2]
}


## transform the t prefix to Time and the f prefix to Freq
varBody <- function(v) {
  pc1 <- gsub("^f", "FreqDomain", v)
  pc1 <- gsub("^t", "TimeDomain", pc1)  
  pc1
}

## if cleaned string was divided into three pieces rearrange the pieces 
## to a standard more readable format
use3Pieces <- function(pcs) {
  pc0 <- pcs[2]
  pc1 <- varBody(pcs[1])
  pc2 <- pcs[3]
  paste(pc0, pc1, "For", pc2, sep = "")  
}

## if cleaned string was divided into two pieces rearrange the pieces 
## to a standard more readable format
use2Pieces <- function(pcs) {
  pc1 <- varBody(pcs[1])
  pc0 <- gsub("std","stdDev", pcs[2]) 
  paste(pc0, pc1, sep = "")
}

## take cleaned up variable name and rearrange to 
## more readable form
prettifyLabel <- function (l) {  
  pieces <- str_split(l, "_")
  ifelse(length(pieces[[1]]) == 3, use3Pieces(pieces[[1]]), use2Pieces(pieces[[1]]))
}

## take raw variable name and remove illegal chars 
## correct BodyBody error to Body
## rearrange name pieces to standard format
## expand Acc to Accelerometer and Mag to Magnitude
transformFeatureName <- function(l) {
  l1 <- gsub("^[0-9]{1,3}|[' ']", "", l)
  l2 <- gsub("\\(\\)", "", l1)
  l3 <- gsub(",|\\),", ".With.", l2)
  l4 <- gsub("\\(", ".Of.", l3)
  l5 <- gsub("\\)$", "", l4)
  l6 <- gsub("-", "_", l5)
  l7 <- gsub("BodyBody", "Body", l6)
  l8 <- prettifyLabel(l7)
  l9 <- gsub("Acc", "Accelerometer", l8)
  l10 <- gsub("Mag", "Magnitude", l9)
  l10
}

## read subject and activity files which are single columns of numbers
readDataColumn <- function(name) {
  print(str_c("Loading file ", name))
  con <- file(name, open = "r")
  data <- as.numeric(readLines(con))
  close(con)
  data
}

## read feature names remove non-pertinent variable names and 
## return transformed names and logical vector specifying 
## data columns to retain
readFeatureNames <- function(path = ".") {
  lines <- readLines(str_c(path,"\\features.txt"))
  pertinent <- grep("-mean|-std", lines)
  pertLines <- sapply(lines, function(l) { ifelse(grepl("-mean|-std", l), l, "") }) 
  ls <- sapply(pertLines, transformFeatureName)
  list(ls, pertinent)
}

## Read data files and make required transforms
readData <- function(path = ".") {
  ## Read Featue Names and transform them
  Features <- readFeatureNames(path)  
  
  print(str_c("Loading file ", "\\train\\X_Train.txt"))
  ## Read training data
  XData <- read.table(str_c(path,"\\train\\X_Train.txt"))    
  
  print(str_c("Loading file ", "\\test\\X_Test.txt"))
  ## Read testing data
  XData <- rbind(XData, read.table(str_c(path,"\\test\\X_Test.txt"))) 
  
  ## get logical vector fixing columns to collect
  cols <- Features[[2]]                                                 
  
  ## remove unneeded columns
  XData <- XData[ , cols]
  ## get the transformed names of the columns
  ColNames <- Features[[1]]
  ColNames <- ColNames[cols]
  names(ColNames) <- NULL
  
  ## save data number of columns and number of rows
  ncols <- ncol(XData)
  nrows <- nrow(XData)
  
  ## read activity definitions and transform to labels
  Activities <- sapply(readLines("activity_labels.txt"), transformLineToLabel)
  names(Activities) <- NULL
  
  ## read activity data for testing and training
  YData <- readDataColumn(".\\train\\Y_Train.txt")  
  YData <- append(YData, readDataColumn( ".\\test\\Y_Test.txt"))  
  
  ## read subject data for testing and training 
  Subject = readDataColumn(".\\train\\Subject_Train.txt")
  Subject <- append(Subject, readDataColumn(".\\test\\Subject_Test.txt"))
  
  ## add subject and activity data to data.frame
  XData <- cbind(Subject, YData, XData)
  
  ## convert activities to factors
  XData[,2] <- factor(XData[,2], labels = Activities)
  
  ## set column names for data frame
  colnames(XData) <- append(c("Subject", "Activity"), ColNames)
  
  ## return Data Frame
  XData  
}

## create column of subjects and activities sorted by subject 
## and then activity
subjectsByActivity <- function(data) {
  df <- data[,c("Subject", "Activity", colnames(data)[3])]
  colnames(df)[3] <- "Var"
  table <- aggregate(Var ~ Subject + Activity, df, mean)
  table[,1:2] 
}

## get average of each group of data for each variable grouped 
## by Subject and Activity
avgValueBySubjectAndActivity <- function(i, data) {
  varName <- colnames(data)[i]
  df <- data[,c("Subject", "Activity", varName)]
  colnames(df)[3] <- "Var"
  table <- aggregate(Var ~ Subject + Activity, df, mean)
  colnames(table) <- colnames(c("V1","V2", varName))
  table[,3]
}

## Create Summary data
createSummary <- function(data) {
  ## get subject and activity columns
  subjectActivity <- subjectsByActivity(data)
  ## get columns of means
  means <- sapply(3:ncol(data), function(i) { avgValueBySubjectAndActivity(i,data)})
  ## add subject and activity values
  summary <- cbind(subjectActivity, means)
  ## set the colnames to the data column names
  colnames(summary) <- colnames(data)
  ## return summary
  summary
}

## read and create data set
data <- readData()
## create summary of data set
summary <- createSummary(data)
## write summary data to table
write.table(summary, "SummaryData.txt", row.names = FALSE)



