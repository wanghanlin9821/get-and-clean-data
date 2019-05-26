setwd("D:\\OneDrive - zju.edu.cn\\Coursera\\get and clean data\\UCI HAR Dataset")
features = read.table("features.txt")
col_name = features[, 2]
X_train = read.table("train\\X_train.txt",col.names = col_name)
X_test = read.table("test\\X_test.txt", col.names = col_name)
y_train = read.table("train\\y_train.txt", col.names = 'activity')
y_test = read.table("test\\y_test.txt",col.names = 'activity')
Subject_train = read.table("train\\subject_train.txt",col.names = 'subject')
Subject_test = read.table("test\\subject_test.txt", col.names = 'subject')
activity_lables = read.table("activity_labels.txt")
#Merges the training and the test sets to create one data set
X_all = rbind(X_train, X_test)
y_all = rbind(y_train, y_test)
Subject_all = rbind(Subject_train, Subject_test)
# merge dataframe
df = cbind(Subject_all, y_all, X_all)
# head(df)
# find mean and std
col_mean = grep(
            "mean", colnames(df), fixed = TRUE,value = TRUE
            )
col_std = grep(
           "std", colnames(df), fixed = TRUE, value = TRUE
           )
cols = c('subject', 'activity', col_mean, col_std)
df_new = df[, cols]
#head(df_new)
final = df_new %>% group_by(subject, activity) %>% summarise_all(funs(mean))
write.table(final, "final.txt", row.name = FALSE)
