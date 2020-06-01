run_analysis <- function(){
  
  ## Read in train txt files (X_train, Y_train, and subject_train)

train <- read.table("./train/X_train.txt", header = FALSE)
trainy <- read.table("./train/Y_train.txt", header = FALSE)
trainsub <- read.table("./train/subject_train.txt", header = FALSE)

  ## Read in test txt files (X_test, Y_test, and subject_test)

test <- read.table("./test/X_test.txt", header = FALSE)
testy <- read.table("./test/Y_test.txt", header = FALSE)
testsub <- read.table("./test/subject_test.txt", header = FALSE)

  ## Read in feature txt files

feature <- read.table("./features.txt", header = FALSE)

  ## Combine test and training tables (x files) 
  ## Add Feature table as column names for alldata table

alldata <- rbind(test, train)
colnames(alldata) <- feature[,2]

  ## Extract columns with mean or std using grepl()

colneeded <- grepl(pattern = "mean|std",colnames(alldata))
alldata <- alldata[,colneeded]

  ## Use gsub to rename columns for clarity and tolower to make lowercase

colnames(alldata) <- gsub("Acc", " acceleration ", colnames(alldata))
colnames(alldata) <- gsub("^t", " time ", colnames(alldata))
colnames(alldata) <- gsub("^f", " frequency ", colnames(alldata))
colnames(alldata) <- tolower(colnames(alldata))

  ##  Add Column Names for test activity and subject table for
  ## both test and training tables

colnames(testy) <- c("activity_levels")
colnames(testsub) <- c("subject_no")
colnames(trainy) <- c("activity_levels")
colnames(trainsub) <- c("subject_no")

  ## Combine Subject No., Activity Levels tables together 
  ## for each group.  Then combine the groups tother

metadatatest <- cbind(testy, testsub)
metadatatrain <- cbind(trainy, trainsub)
allmetadata <- rbind(metadatatest, metadatatrain)

  ## Combine metadata with data table

fulltable <- cbind(allmetadata, alldata)

  ## Change activity-level colummns to a  descriptor by subsetting 

fulltable$activity_levels[fulltable$activity_levels == 1] <- "WALKING"
fulltable$activity_levels[fulltable$activity_levels == 2] <- "WALKING_UPSTAIRS"
fulltable$activity_levels[fulltable$activity_levels == 3] <- "WALKING_DOWNSTAIRS"
fulltable$activity_levels[fulltable$activity_levels == 4] <- "SITTING"
fulltable$activity_levels[fulltable$activity_levels == 5] <- "STANDING"
fulltable$activity_levels[fulltable$activity_levels == 6] <- "LAYING"

  ## Changing Activity_levels and subject_no into factors

fulltable$activity_levels <- as.factor(fulltable$activity_levels)
fulltable$subject_no <- as.factor(fulltable$subject_no)


  ##  Tidy data set for column means by activity level and subject no.
  ## using aggregate function to group and return the mean for each column

tidyDF <- aggregate(fulltable[, 3:81], 
                    list(fulltable$activity_levels,fulltable$subject_no), 
                    mean)

write.table(tidyDF, file = "TidyData.txt")
 
}