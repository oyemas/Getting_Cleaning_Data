##--------------Required Scope--------------------------------------------
##  Review criterialess 
##  The submitted data set is tidy.
##  The Github repo contains the required scripts.
##  GitHub contains a code book that modifies and updates the available codebooks with the data to indicate all the variables and summaries calculated, along with units, and any other relevant information.
##  The README that explains the analysis files is clear and understandable.
##  The work submitted for this project is the work of the student who submitted it.


## load required function to memory (dcast from reshape2 package)
liblibrary(reshape2)
## Begin the assignment

##--------- Downolad the zip file from the website------------------------

## set download url and file destination paths
url1<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
Src_des<-"E:/DataScienceR/module_3_w4/"
fn<-paste(Src_des,"SamsungData.zip",sep = "")

## Download the file
if (!file.exists(fn)){
  print("file does not exist,downloading file")
download.file(url1,fn)

}

## if file has not been uzipped, unzip it
if (!file.exists("UCI HAR Dataset")){
  print("unzipping file")
  unzip(fn)
  
}
##---------------------Analyse Data headers and labels -------------------------------
## set data directory
Dn<-"./UCI HAR Dataset/"

## load features headers  and activity labels from file and
## assign to variable
FeaturesTxT<-read.table(paste(Dn,"features.txt",sep = ""))
ALabelsTxT<-read.table(paste(Dn,"activity_labels.txt",sep = ""))

# cast to character variables
Features<-as.character(FeaturesTxT[[2]]) 
ALabelsTxT[,2]<-as.character(ALabelsTxT[,2])

## create headers and labels for mean and std subsets
wFeaturesIdx<-grep(".*[mM]ean.*|.*[sS]td.*",Features)
wFeatures<-Features[wFeaturesIdx]
## capitalize first letter in mean and std and 
## replace all special charaters - and ()
wFeatures<-gsub("-[Mm]ean","Mean",wFeatures)
wFeatures<-gsub("-[Ss]td","Std",wFeatures)
wFeatures<-gsub("[-()]","",wFeatures)

##------------------------Load Data--------------------------------------------------
## set data file names and paths
Dn_Train_Data<-paste(Dn,"train/X_train.txt",sep = "")
Dn_Train_Label<-paste(Dn,"train/y_train.txt",sep = "")
Dn_Train_Subject<-paste(Dn,"train/subject_train.txt",sep = "")

Dn_Test_Data<-paste(Dn,"test/X_test.txt",sep = "")
Dn_Test_Label<-paste(Dn,"test/y_test.txt",sep = "")
Dn_Test_Subject<-paste(Dn,"test/subject_test.txt",sep = "")

## read file
TrainDataFull<-read.table(Dn_Train_Data)
TestDataFull<-read.table(Dn_Test_Data)
## subset to mean and std colums
TrainData<-TrainDataFull[wFeaturesIdx]
TestData<-TestDataFull[wFeaturesIdx]

TrainLabel<-read.table(Dn_Train_Label)
TestLabel<-read.table(Dn_Test_Label)

TrainSubject<-read.table(Dn_Train_Subject)
TestSubject<-read.table(Dn_Test_Subject)

## append all training dataset fragments in columns
TrainAll<-cbind(TrainSubject,TrainLabel,TrainData)
## append all validation dataset fragments in columns
TestAll<-cbind(TestSubject,TestLabel,TestData)

## The test and Training dataset have identical variables or features
## Now merge these data set to one big data by appending test data 
## to rows of the training data set

UniversalData<-rbind(TrainAll,TestAll)

##-------------- re-label data----------------------------------------------------
colLabels<-c("subjectid","activity",wFeatures)
colnames(UniversalData)<-colLabels

## set subjectid and activity label to factor variables
UniversalData$activity<-factor(UniversalData$activity,levels = ALabelsTxT[,1],labels = ALabelsTxT[,2])
UniversalData$subjectid<-as.factor(UniversalData$subjectid)


## repartition the data frame to include column averages for subjectid and activity
meltedUnivData<-reshape2::melt(UniversalData,id=c("subjectid","activity")) ## using all others as variables

# now cast the new data frame using the mean option
castedUnivData<-reshape2::dcast(meltedUnivData,subjectid+activity~variable,mean)

##------------Write out the new data frame as a txt file_____________________________

write.table(castedUnivData,"tidydata.txt",row.names = FALSE,quote = FALSE)

## ---------------------- END OF SCRIPT--------------------------------------------------

