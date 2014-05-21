uci.dataset.dir <- "UCI HAR Dataset/"

activity.labels <- read.table(file.path(uci.dataset.dir, "activity_labels.txt"),
                              col.names=c("levels", "labels"))

features <- read.table(file.path(uci.dataset.dir, "features.txt"),
                           col.names=c("index", "features"))
mean.std.features <- features[grepl("(mean|std)", features[, 2]), 1]

load.dataset <- function (name, col.index) {
    getFilename <- function(prefix) {
        file.path(uci.dataset.dir, name, paste(prefix, "_", name, ".txt", sep=""))
    }

    dataset <- read.table(getFilename("X"), col.names=features$features)
    dataset <- dataset[, col.index]

    subjects <- read.table(getFilename("subject"), col.names=c("subjects"))
    dataset <- cbind(dataset, subjects)

    y <- read.table(getFilename("y"), col.names=c("y"))
    y$y <- factor(y$y, activity.labels$levels, activity.labels$labels)
    dataset <- cbind(dataset, y)

    dataset
}

train.set <- load.dataset("train", mean.std.features)
test.set  <- load.dataset("test", mean.std.features)

tidy.dataset <- rbind(train.set, test.set)
