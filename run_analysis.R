#Get data in
#data
x_train <- read.table("./train/X_train.txt")
x_test <- read.table("./test/X_test.txt")

#data-people
subject_train <- read.table("./train/subject_train.txt")

#labels
y_train <- read.table("./train/y_train.txt")
y_test <- read.table("./test/y_test.txt")
features <- read.table("./features.txt")
activity_labels <- read.table("./activity_labels.txt")
subject_test <- read.table("./test/subject_test.txt")

colnames(x_train) <- features[,2] 
colnames(y_train) <-"Activity"
colnames(subject_train) <- "Subject"

colnames(x_test) <- features[,2] 
colnames(y_test) <- "Activity"
colnames(subject_test) <- "Subject"

colnames(activity_labels) <- c('Activity','activityType')

train_all_data <- cbind(y_train, subject_train, x_train)
test_all_data <- cbind(y_test, subject_test, x_test)
total_old_set <- rbind(train_all_data, test_all_data)

column_names <- colnames(total_old_set)
print(column_names)

new_set_ms <- (grepl("Activity" , column_names) | grepl("Subject" , column_names) | grepl("mean.." , column_names) | grepl("std.." , column_names) )

total_new_set <- total_old_set[ , new_set_ms == TRUE]

total_new_set <- merge(total_new_set, activity_labels, by='Activity', all.x=TRUE)

new_chosen_means_std <- aggregate(. ~Subject + Activity, total_new_set, mean)
new_chosen_means_std <- new_chosen_means_std[order(new_chosen_means_std$Subject, new_chosen_means_std$Activity),]

write.table(new_chosen_means_std, "getting_cleaning.txt", row.name=FALSE)
