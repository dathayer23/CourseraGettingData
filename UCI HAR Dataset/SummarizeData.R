


createDataFrame <- function(path, category){
require(stringr)  

readDataFile <- function(filename, category)  {
  
  write(str_c("Filename = ", filename), "")
  write(str_c("Category = ", category), "")
  name <- str_c(filename, category)
  con <- file(name, open = "r")
  data <- readLines(con)
  
  sapply(data, function (l) { 
    res <- sapply((str_split(l, "\\s+")), as.numeric)
    res[!is.na(res)]
    } )
  
  close(con)
  data
}
  
df <- data.frame (
            readDataFile( str_c(path,"body_acc_x_"),  category),
            readDataFile( str_c(path,"body_acc_y_"),  category),
            readDataFile( str_c(path,"body_acc_z_"),  category),
            readDataFile( str_c(path,"body_gyro_x_"), category),
            readDataFile( str_c(path,"body_gyro_y_"), category),
            readDataFile( str_c(path,"body_gyro_z_"), category),
            readDataFile( str_c(path,"total_acc_x_"), category),
            readDataFile( str_c(path,"total_acc_y_"), category),
            readDataFile( str_c(path,"total_acc_z_"), category),
            stringsAsFactors = FALSE
          )
names(df) <- c("BodyAccelerometerX", "BodyAccelerometerY","BodyAccelerometerZ", 
               "BodyGyroX", "BodyGyroY", "BodyGyroZ", "TotalAccelerometerX",
               "TotalAccelerometerY", "TotalAccelerometerZ")
df
}

testData <- createDataFrame(".\\test\\Inertial Signals\\","test.txt")
trainData <- createDataFrame(".\\train\\Inertial Signals\\","train.txt")



