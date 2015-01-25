require(stringr)
require(dplyr)

transformLineToVector <- function (l) {
  sapply((str_split(l, "\\s+")), as.numeric)
}

transformLineToLabel <- function(l) {
  str_split(l, "\\s+")[[1]][2]
}

varBody <- function(v) {
  pc1 <- gsub("^f", "FreqDomain", v)
  pc1 <- gsub("^t", "TimeDomain", pc1)  
  pc1
}

use3Pieces <- function(pcs) {
  pc0 <- pcs[2]
  pc1 <- varBody(pcs[1])
  pc2 <- pcs[3]
  paste(pc0, pc1, "For", pc2, sep = "")  
}

use2Pieces <- function(pcs) {
  pc1 <- varBody(pcs[1])
  pc0 <- gsub("std","stdDev", pcs[2]) 
  paste(pc0, pc1, sep = "")
}

prettifyLabel <- function (l) {  
  pieces <- str_split(l, "_")
  ifelse(length(pieces[[1]]) == 3, use3Pieces(pieces[[1]]), use2Pieces(pieces[[1]]))
}

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

readDataColumn <- function(name) {
  print(str_c("Loading file ", name))
  con <- file(name, open = "r")
  data <- as.numeric(readLines(con))
  close(con)
  data
}

readFeatureNames <- function(path = ".") {
  lines <- readLines(str_c(path,"\\features.txt"))
  pertinent <- grep("-mean|-std", lines)
  pertLines <- sapply(lines, function(l) { ifelse(grepl("-mean|-std", l), l, "") }) 
  ls <- sapply(pertLines, transformFeatureName)
  list(ls, pertinent)
}

readData <- function(path = ".") {
  Features <- readFeatureNames(path)
  print(str_c("Loading file ", "\\train\\X_Train.txt"))
  XData <- read.table(str_c(path,"\\train\\X_Train.txt"))
  print(str_c("Loading file ", "\\test\\X_Test.txt"))
  XData <- rbind(XData, read.table(str_c(path,"\\test\\X_Test.txt")))
  cols <- Features[[2]]
  
  XData <- XData[ , cols]
  ColNames <- Features[[1]]
  ColNames <- ColNames[cols]
  names(ColNames) <- NULL
  ncols <- ncol(XData)
  nrows <- nrow(XData)
  
  
  
  Activities <- sapply(readLines("activity_labels.txt"), transformLineToLabel)
  names(Activities) <- NULL
  
  YData <- readDataColumn(".\\train\\Y_Train.txt")
  
  YData <- append(YData, readDataColumn( ".\\test\\Y_Test.txt"))  
  
  
  
  Subject = readDataColumn(".\\train\\Subject_Train.txt")
  Subject <- append(Subject, readDataColumn(".\\test\\Subject_Test.txt"))
  XData <- cbind(Subject, YData, XData)
  XData[,2] <- factor(XData[,2], labels = Activities)
  
  ## XData <- cbind(XData, Subject)
  colnames(XData) <- append(c("Subject", "Activity"), ColNames)
  XData  
}

subjectsByActivity <- function(data) {
  df <- data[,c("Subject", "Activity", colnames(data)[3])]
  colnames(df)[3] <- "Var"
  table <- aggregate(Var ~ Subject + Activity, df, mean)
  table[,1:2] 
}

avgValueBySubjectAndActivity <- function(i, data) {
  varName <- colnames(data)[i]
  df <- data[,c("Subject", "Activity", varName)]
  colnames(df)[3] <- "Var"
  table <- aggregate(Var ~ Subject + Activity, df, mean)
  colnames(table) <- colnames(c("V1","V2", varName))
  table[,3]
}

createSummary <- function(data) {
  subjectActivity <- subjectsByActivity(data)
  means <- sapply(3:ncol(data), function(i) { avgValueBySubjectAndActivity(i,data)})
  summary <- cbind(subjectActivity, means)
  colnames(summary) <- colnames(data)
  summary
}


data <- readData()
summary <- createSummary(data)
write.table(summary, "SummaryData.txt", row.names = FALSE)

