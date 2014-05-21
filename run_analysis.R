uci.dataset.dir <- "UCI HAR Dataset/"

features <- read.table(file.path(uci.dataset.dir, "features.txt"),
                           col.names=c("index", "features"))

mean.std.features <- features[grepl("(mean|std)", features[, 2]), 1]

Xtrain <- read.table(file.path(uci.dataset.dir, "train", "X_train.txt"),
                     col.names=features$features)
Xtrain <- Xtrain[, mean.std.features]

Xtest <- read.table(file.path(uci.dataset.dir, "test", "X_test.txt"),
                     col.names=features$features)
Xtest <- Xtest[, mean.std.features]

tidy.dataset <- rbind(Xtrain, Xtest)