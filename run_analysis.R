# Following code merges the training and the test sets to create one data set.
X <- rbind(x_train, x_test)
Y <- rbind(y_train, y_test)
Subject <- rbind(subject_train, subject_test)
Merged_Data <- cbind(Subject, Y, X)

# Following code extracts only the measurements on the mean and standard deviation for each measurement.
Data <- Merged_Data %>% select(subject, code, contains("mean"), contains("std"))

# Following code uses descriptive activity names to name the activities in the data set.
Data$code <- activities[Data$code, 2]

# Following code appropriately labels the data set with descriptive variable names.
names(Data)[2] = "activity"
names(Data) <- gsub("Acc", "Accelerometer", names(Data))
names(Data) <- gsub("Gyro", "Gyroscope", names(Data))
names(Data) <- gsub("BodyBody", "Body", names(Data))
names(Data) <- gsub("Mag", "Magnitude", names(Data))
names(Data) <- gsub("^t", "Time", names(Data))
names(Data) <- gsub("^f", "Frequency", names(Data))
names(Data) <- gsub("tBody", "TimeBody", names(Data))
names(Data) <- gsub("-mean()", "Mean", names(Data), ignore.case = TRUE)
names(Data) <- gsub("-std()", "STD", names(Data), ignore.case = TRUE)
names(Data) <- gsub("-freq()", "Frequency", names(Data), ignore.case = TRUE)
names(Data) <- gsub("angle", "Angle", names(Data))
names(Data) <- gsub("gravity", "Gravity", names(Data))

# Following code creates a second, independent tidy data set with the average of each variable for each activity and each subject from previous data.
FinalData <- Data %>%
  group_by(subject, activity) %>%
  summarise_all(funs(mean))
write.table(FinalData, "FinalData.txt", row.name=FALSE)

# Checking variable names
str(FinalData)

# Taking a look at FinalData
FinalData


