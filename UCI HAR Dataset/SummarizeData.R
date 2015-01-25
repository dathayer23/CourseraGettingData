require(stringr)
require(dplyr)


memory.limit(32692 + 16346)

transformLineToVector <- function (l) {
  sapply((str_split(l, "\\s+")), as.numeric)
}

transformLineToLabel <- function(l) {
  str_split(l, "\\s+")[[1]][2]
}



transformFeatureName <- function(l) {
     l1 <- gsub("^[0-9]{1,3}|[' ']", "", l)
     l2 <- gsub("\\(\\)", "", l1)
     l3 <- gsub(",|\\),", ".With.", l2)
     l4 <- gsub("\\(", ".Of.", l3)
     l5 <- gsub("\\)$", "", l4)
     l6 <- gsub("-", "_", l5)
     l6
}

readDataLines <- function(name) {
  print(str_c("Loading file ", name))
  con <- file(name, open = "r")
  data <- readLines(con) %>% (str_split(l, "\\s+"))
  close(con)
  data
}
readDataColumn <- function(name) {
  print(str_c("Loading file ", name))
  con <- file(name, open = "r")
  data <- as.numeric(readLines(con))
  close(con)
  data
}
  
readDataFile <- function(filename, category = NULL)  {
  name <- str_c(filename, category)
  print(str_c("Loading file ", name))
  con <- file(name, open = "r")
  data <- readLines(con)
  
  output <- sapply(data, function (l) { 
    res <- transformLineToVector(l)
    res[!is.na(res)]
  } )
  
  names(output) <- NULL
  dimnames(output) <- NULL
  close(con)
  m <- matrix(output, dim(output))
  rownames(m) <- NULL
  m
}

createXYZ <- function(mx,my,mz) {
    xyz <- function(x,y,z) { 
      c(X = x, Y = y, Z = z) 
    }
    mxyz <- mapply(xyz, t(mx), t(my), t(mz))
    dim(mxyz) <- c(nrow(mx), ncol(mx), 3)
    mxyz
}


createDataFrame <- function(path, category){
    df <- data.frame (
            BodyAccelerometer = createXYZ(readDataFile( str_c(path,"body_acc_x_"),  category),
                                          readDataFile( str_c(path,"body_acc_y_"),  category),
                                          readDataFile( str_c(path,"body_acc_z_"),  category)),            
            BodyGyro = createXYZ(readDataFile( str_c(path,"body_gyro_x_"), category),
                                 readDataFile( str_c(path,"body_gyro_y_"), category),
                                 readDataFile( str_c(path,"body_gyro_z_"), category)),            
            TotalAccelerometer = createXYZ(readDataFile( str_c(path,"total_acc_x_"), category),
                                           readDataFile( str_c(path,"total_acc_y_"), category),
                                           readDataFile( str_c(path,"total_acc_z_"), category)),   
            stringsAsFactors = FALSE
          )   
    
    
    list(df, XData,YData,Subject)
}

##testData <- createDataFrame(".\\test\\Inertial Signals\\","test.txt")
##trainData <- createDataFrame(".\\train\\Inertial Signals\\","train.txt")
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
  table <- aggregate(Var ~ Subject + Activity, df1, mean)
  table[,1:2] 
}

avgValueBySubjectAndActivity <- function(i, data) {
  varName <- colnames(data)[i]
  df <- data[,c("Subject", "Activity", varName)]
  colnames(df)[3] <- "Var"
  table <- aggregate(Var ~ Subject + Activity, df1, mean)
  colnames(table) <- colnames(c("V1","V2", varName))
  table[,3]
}

createSummary <- function(data) {
  subjectActivity <- subjectsByActivity(data)
  means <- sapply(3:ncol(data), function(i) { avgValueBySubjectAndActivity(i,data)})
  summary <- cbind(subjectActivity, means)
  colnames(summary) <- colnames(data)
}
