library(plyr)

setwd("C:\\Users\\MAP\\Documents\\Data Science MOOC\\CleanData\\Project\\UCI HAR Dataset\\")

# Labels that applies to both sets
mesurlabels <- read.table("features.txt", sep="")
names(mesurlabels)[1:2] <- c("featureID", "featuredesc")

# get the measurement id (mean and standard deviation)
mesureid <- mesurlabels[grep("mean()|std()", mesurlabels$featuredesc),1]
mesureid <- mesureid[]+2

activitylabels <- read.table("activity_labels.txt", sep="")
names(activitylabels)[1:2] <- c("activityID", "activitydesc")

# Test mesurements, activity and subject
testmesur <- read.table("test\\X_test.txt", sep="")
testactivity <- read.table("test\\y_test.txt")
testsubject <- read.table("test\\subject_test.txt")

# Rearrange test data to get one row per subject/activity/mesurements
testdata <- data.frame(subject=testsubject[,],activity=testactivity[,],mesur=testmesur[,])
names(testdata)[3:563] <- as.character(mesurlabels[,2])

# Train mesurements, activity and subject
trainmesur <- read.table("train\\X_train.txt", sep="")
trainactivity <- read.table("train\\y_train.txt")
trainsubject <- read.table("train\\subject_train.txt")

# Rearrange train data to get one row per subject/activity/mesurements
traindata <- data.frame(subject=trainsubject[,],activity=trainactivity[,],mesur=trainmesur[,])
names(traindata)[3:563] <- as.character(mesurlabels[,2])

# Merge train and test data
mergeddata <- rbind(testdata, traindata)


# Merge with Activity label data set.
mergeddatafinal <- merge(mergeddata[,c(1,2,mesureid[])], activitylabels, by.x="activity", by.y="activityID")

# Create a second tidy data set with the average of each variable 
# for each activity and each subject.
groupeddata <- ddply(mergeddatafinal,c("subject","activitydesc"),numcolwise(mean))
groupeddata <- groupeddata[ order(groupeddata[,1], groupeddata[,3]), ]

# Export the file in a tidy data format
write.table(groupeddata, "tidydata.txt", sep="\t", row.names=FALSE)
