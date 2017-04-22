## Getting data


## Definitions

dataPath <- "./data"
coreDataFile <- file.path(dataPath,"swiftkey.zip")
source <- "https://d396qusza40orc.cloudfront.net/dsscapstone/dataset/Coursera-SwiftKey.zip"

getallData <- function() {
  if(!file.exists(coreDataFile)) {
    message("Downloading data file ", coreDataFile, source)
    download.file(source, file.path(coreDataFile))  
  } 
  
}

## Prepare the Local enviroment to get all the data, 
## all folders containing data will be created here.
prepareLocalPath <- function() {
  message("prepareLocalPath()",dataPath)  
  if(!file.exists(dataPath)) {
    dir.create(dataPath)
  }
}
  
