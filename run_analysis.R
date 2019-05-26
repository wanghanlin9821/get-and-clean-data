setwd("D:\\OneDrive\\Coursera\\get and clean data\\UCI HAR Dataset")
X_train = read.table("train\\X_train.txt")
X_test = read.table("test\\X_test.txt")
y_train = read.table("train\\y_train.txt")
y_test = read.table("test\\y_test.txt")
Subject_train = read.table("train\\subject_train.txt")
Subject_test = read.table("test\\subject_test.txt")
activity_lables = read.table("activity_labels.txt")
features = read.table("features.txt")
#merge X,y and caculate 
X_all = rbind(X_train, X_test)
y_all = rbind(y_train, y_test)
colnames(X_all) = c(as.character(features[, 2]))
Mean = grep(
            "mean()", colnames(X_all), fixed = TRUE
            )
Std = grep(
           "std()",  colnames(X_all),  fixed = TRUE
           )
Msd = X_all[, c(Mean, Std)]
activity_all = cbind(y_all, Msd)
activity_lables[, 2] = as.character(activity_lables[, 2])
colnames(activity_all)[1] = "Activity"
len = length(activity_all[, 1])
for (i in 1:len) {
    activity_all[i, 1] = activity_lables[activity_all[i, 1], 2]
}
Subject_all = rbind(Subject_train, Subject_test)
all = cbind(Subject_all, activity_all)
colnames(all)[1] = "Subject"
tidy = aggregate(
                 all[, 3] ~ Subject + Activity,  data = all,  FUN = "mean"
                 )
col = ncol(all)
for (i in 4:col) {
    tidy[, i] = aggregate(all[, i] ~ Subject + Activity, data = all, FUN = "mean")[, 3]
}
colnames(tidy)[3:ncol(tidy)] = colnames(Msd)
write.table(tidy, row.name = FALSE,file = "final.txt")