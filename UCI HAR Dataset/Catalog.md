** Analysis Steps to read data **
1. Read in Feature Names text files.
2. Select names that contain the string mean or stdev.
3. Transform raw names to more readable format removing all symbols that are illegal as a R column name.
4. Read training and test data files using read.table function
4. Row bind test data to end to training data
5. Select the columns that correspond to the transformed variable names
6. Column bind Subject and Activity labels to data frame
7. Set column names for data frame to transformed feature names

** Analysis steps to create data summary **
1. Create columns for Subject and activity pairs
2. select each variable column from first feature to last feature
3. for each column feature vector get the mean for each set of values grouped by subject and activity
4. Add new column of means to columns for Subject and activity pair.
5. Write created summary table to file.

** To Run Analysis **
1. create directory for data set
2. cd to data dir
3. run script file


** Variable Definitions **
Variable Name                                     Variable Meaning

Subject                                          - Subject Id for data
Activity                                         - Activity type for data
meanTimeDomainBodyAccelerometerForX              - Mean Time Domain Body Accelerometer Readings in X Direction
meanTimeDomainBodyAccelerometerForY              - Mean Time Domain Body Accelerometer Readings in Y Direction
meanTimeDomainBodyAccelerometerForZ              - Mean Time Domain Body Accelerometer Readings in Z Direction
stdTimeDomainBodyAccelerometerForX               - Std Deviation Time Domain Body Accelerometer Readings in X Direction
stdTimeDomainBodyAccelerometerForY               - Std Deviation Time Domain Body Accelerometer Readings in X Direction
stdTimeDomainBodyAccelerometerForZ               - Std Deviation Time Domain Body Accelerometer Readings in X Direction
meanTimeDomainGravityAccelerometerForX           - Mean Time Domain Gravity Accelerometer Readings in X Direction
meanTimeDomainGravityAccelerometerForY           - Mean Time Domain Gravity Accelerometer Readings in Y Direction
meanTimeDomainGravityAccelerometerForZ           - Mean Time Domain Gravity Accelerometer Readings in Z Direction
stdTimeDomainGravityAccelerometerForX            - Std Deviation Time Domain Gravity Accelerometer Readings in X Direction
stdTimeDomainGravityAccelerometerForY            - Std Deviation Time Domain Gravity Accelerometer Readings in Y Direction
stdTimeDomainGravityAccelerometerForZZ           - Std Deviation Time Domain Gravity Accelerometer Readings in Z Direction
meanTimeDomainBodyAccelerometerJerkForX          - Mean Time Domain Body Accelerometer Jerk Readings in X Direction
meanTimeDomainBodyAccelerometerJerkForY          - Mean Time Domain Body Accelerometer Jerk Readings in Y Direction
meanTimeDomainBodyAccelerometerJerkForZ          - Mean Time Domain Body Accelerometer Jerk Readings in Z Direction
stdTimeDomainBodyAccelerometerJerkForX           - Std Deviation Time Domain Body Accelerometer Jerk Readings in X Direction
stdTimeDomainBodyAccelerometerJerkForY           - Std Deviation Time Domain Body Accelerometer Jerk Readings in Y Direction
stdTimeDomainBodyAccelerometerJerkForZ           - Std Deviation Time Domain Body Accelerometer Jerk Readings in Z Direction
meanTimeDomainBodyGyroForX                       - Mean Time Domain Body Gyroscope Readings in X Direction
meanTimeDomainBodyGyroForY                       - Mean Time Domain Body Gyroscope Readings in Y Direction
meanTimeDomainBodyGyroForZ                       - Mean Time Domain Body Gyroscope Readings in Z Direction
stdTimeDomainBodyGyroForX                        - Std Deviation Time Domain Body Gyroscope Readings in X Direction
stdTimeDomainBodyGyroForY                        - Std Deviation Time Domain Body Gyroscope Readings in Y Direction
stdTimeDomainBodyGyroForZ                        - Std Deviation Time Domain Body Gyroscope Readings in Z Direction
meanTimeDomainBodyGyroJerkForX                   - Mean Time Domain Body Gyroscope Jerk Readings in X Direction
meanTimeDomainBodyGyroJerkForY                   - Mean Time Domain Body Gyroscope Jerk Readings in Y Direction
meanTimeDomainBodyGyroJerkForZ                   - Mean Time Domain Body Gyroscope Jerk Readings in Z Direction
stdTimeDomainBodyGyroJerkForX                    - Std Deviation Time Domain Body Gyroscope Jerk Readings in X Direction
stdTimeDomainBodyGyroJerkForY                    - Std Deviation Time Domain Body Gyroscope Jerk Readings in Y Direction
stdTimeDomainBodyGyroJerkForZ                    - Std Deviation Time Domain Body Gyroscope Jerk Readings in Z Direction
meanTimeDomainBodyAccelerometerMagnitude         - Mean Time Domain Body Accelerometer Magnitude
stdDevTimeDomainBodyAccelerometerMagnitude       - Std Deviation Time Domain Body Accelerometer Magnitude
meanTimeDomainGravityAccelerometerMagnitude      - Mean Time Domain Gravity Accelerometer Magnitude
stdDevTimeDomainGravityAccelerometerMagnitude    - Std Deviation Time Domain Gravity Accelerometer Magnitude
meanTimeDomainBodyAccelerometerJerkMagnitude     - Mean Time Domain Body Accelerometer Jerk Magnitude
stdDevTimeDomainBodyAccelerometerJerkMagnitude   - Std Deviation Time Domain Body Accelerometer Jerk Magnitude
meanTimeDomainBodyGyroMagnitude                  - Mean Time Domain Body Gyroscope Magnitude
stdDevTimeDomainBodyGyroMagnitude                - Std Deviation Time Domain Body Gyroscope Magnitude
meanTimeDomainBodyGyroJerkMagnitude              - Mean Time Domain Body Gyroscope Jerk Magnitude
stdDevTimeDomainBodyGyroJerkMagnitude            - Std Deviation Time Domain Body Gyroscope Jerk Magnitude
meanFreqDomainBodyAccelerometerForX              - Mean Frequency Domain Body Accelerometer Readings in X Direction
meanFreqDomainBodyAccelerometerForY              - Mean Frequency Domain Body Accelerometer Readings in Y Direction
meanFreqDomainBodyAccelerometerForZZ             - Mean Frequency Domain Body Accelerometer Readings in Z Direction
stdFreqDomainBodyAccelerometerForX               - Std Deviation Frequency Domain Body Accelerometer Readings in X Direction
stdFreqDomainBodyAccelerometerForY               - Std Deviation Frequency Domain Body Accelerometer Readings in y Direction
stdFreqDomainBodyAccelerometerForZ               - Std Deviation Frequency Domain Body Accelerometer Readings in Z Direction
meanFreqFreqDomainBodyAccelerometerForX          - Mean Frequency of Frequency Domain Body Accelerometer in X direction
meanFreqFreqDomainBodyAccelerometerForY          - Mean Frequency of Frequency Domain Body Accelerometer in Y direction
meanFreqFreqDomainBodyAccelerometerForZ          - Mean Frequency of Frequency Domain Body Accelerometer in Z direction
meanFreqDomainBodyAccelerometerJerkForX          - Mean Frequency Domain Body Accelerometer Jerk in X Direction
meanFreqDomainBodyAccelerometerJerkForY          - Mean Frequency Domain Body Accelerometer Jerk in Y Direction
meanFreqDomainBodyAccelerometerJerkForZ          - Mean Frequency Domain Body Accelerometer Jerk in Z Direction
stdFreqDomainBodyAccelerometerJerkForX           - Std Deviation Frequency Domain Body Accelerometer Jerk in X Direction
stdFreqDomainBodyAccelerometerJerkForY           - Std Deviation Frequency Domain Body Accelerometer Jerk in Y Direction
stdFreqDomainBodyAccelerometerJerkForZ           - Std Deviation Frequency Domain Body Accelerometer Jerk in Z Direction
meanFreqFreqDomainBodyAccelerometerJerkForX      - Mean Frequency of Frequency Domain Body Accelerometer Jerk in X direction
meanFreqFreqDomainBodyAccelerometerJerkForY      - Mean Frequency of Frequency Domain Body Accelerometer Jerk in Y direction
meanFreqFreqDomainBodyAccelerometerJerkForZ      - Mean Frequency of Frequency Domain Body Accelerometer Jerk in Z direction
meanFreqDomainBodyGyroForX                       - Mean Frequency Domain Body Gyroscope Readings in X Direction
meanFreqDomainBodyGyroForY                       - Mean Frequency Domain Body Gyroscope Readings in Y Direction
meanFreqDomainBodyGyroForZ                       - Mean Frequency Domain Body Gyroscope Readings in Z Direction
stdFreqDomainBodyGyroForX                        - Std Deviation Frequency Domain Body Gyroscope Readings in X Direction
stdFreqDomainBodyGyroForY                        - Std Deviation Frequency Domain Body Gyroscope Readings in Y Direction
stdFreqDomainBodyGyroForZ                        - Std Deviation Frequency Domain Body Gyroscope Readings in Z Direction
meanFreqFreqDomainBodyGyroForX                   - Mean Frequency of Frequency Domain Body Gyroscope Readings in X direction
meanFreqFreqDomainBodyGyroForY                   - Mean Frequency of Frequency Domain Body Gyroscope Readings in Y direction
meanFreqFreqDomainBodyGyroForZ                   - Mean Frequency of Frequency Domain Body Gyroscope Readings in Z direction
meanFreqDomainBodyAccelerometerMagnitude         - Mean Frequency Domain Body Accelerometer Magnitude
stdDevFreqDomainBodyAccelerometerMagnitude       - Std Deviation Frequency Domain Body Accelerometer Magnitude
meanFreqFreqDomainBodyAccelerometerMagnitude     - Mean Frequency of Frequency Domain Body Accelerometer Magnitude
meanFreqDomainBodyAccelerometerJerkMagnitude     - Mean Frequency Domain Body Accelerometer Jerk Magnitude
stdDevFreqDomainBodyAccelerometerJerkMagnitude   - Std Deviation Frequency Domain Body Accelerometer Jerk Magnitude
meanFreqFreqDomainBodyAccelerometerJerkMagnitude - Mean Frequency of Frequency Domain Body Accelerometer Jerk Magnitude
meanFreqDomainBodyGyroMagnitude                  - Mean Frequency Domain Body Gyroscope Magnitude
stdDevFreqDomainBodyGyroMagnitude                - Std Deviation Frequency Domain Body Gyroscope Magnitude
meanFreqFreqDomainBodyGyroMagnitude              - Mean Frequency of Frequency Domain Body Gyroscope Magnitude
meanFreqDomainBodyGyroJerkMagnitude              - Mean Frequency Domain Body Gyroscope Jerk Magnitude
stdDevFreqDomainBodyGyroJerkMagnitude            - Std Deviation Frequency Domain Body Gyroscope Jerk Magnitude
meanFreqFreqDomainBodyGyroJerkMagnitude          - Mean Frequency of Frequency Domain Body Gyroscope Jerk Magnitude

