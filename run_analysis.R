library(data.table)

uci.dataset.dir <- "UCI HAR Dataset/"

# get all features and filter to get only those that are mean or std,
# the result is used in the load.dataset function
features <- read.table(file.path(uci.dataset.dir, "features.txt"),
                           col.names=c("index", "features"))
mean.std.features <- features[grepl("(mean|std)", features[, 2]), 1]

# dataframe with activity labels, used in the load.dataset function
activity.labels <- read.table(file.path(uci.dataset.dir, "activity_labels.txt"),
                              col.names=c("levels", "labels"))

load.dataset <- function (name, col.index) {
    # this function loads a dataset (which may be train or test),
    # filtering the columns according to argument col.index

    getFilename <- function(prefix) {
        file.path(uci.dataset.dir, name, paste(prefix, "_", name, ".txt", sep=""))
    }

    dataset <- read.table(getFilename("X"), col.names=features$features)
    dataset <- dataset[, col.index]

    subjects <- read.table(getFilename("subject"), col.names=c("subjects"))
    dataset <- cbind(dataset, subjects)

    # get activities properly labeled:
    y <- read.table(getFilename("y"), col.names=c("activity"))
    y$activity <- factor(y$activity, activity.labels$levels, activity.labels$labels)
    dataset <- cbind(dataset, y)

    data.table(dataset)
}

# load datasets
train.set <- load.dataset("train", mean.std.features)
test.set  <- load.dataset("test", mean.std.features)

# combine the train and test datasets into one
merged.dataset <- rbind(train.set, test.set)

# fix column names, replace prefixes with readable names and remove double dots
variables <- colnames(merged.dataset)
variables <- gsub("^t", "time", variables)
variables <- gsub("^f", "freq", variables)
variables <- gsub("[.]$", "", gsub("[.][.][.]?", ".", variables))
variables <- gsub("Mag", "Magnitude", gsub("Acc", "Acceleration", variables))
setnames(merged.dataset, colnames(merged.dataset), variables)


# creating tidy dataset with the average by subject and activity
tidy.with.avg <- merged.dataset[,lapply(.SD,mean),by=list(subjects, activity)]
write.csv(tidy.with.avg, "tidy-dataset-with-averages.csv", row.names=FALSE)
