## Getting data


## Definitions

dataPath <- "./data"
coreDataFile <- file.path(dataPath,"swiftkey.zip")
source <- "https://d396qusza40orc.cloudfront.net/dsscapstone/dataset/Coursera-SwiftKey.zip"

#' Check if the data is alreadyDownloaded, if isn't it get it done !
#' @param dp the local dataPath
#' @param cdf The coreData file, a Zip file containing the texts
#' @param srcUrl The URL to download the file
getallData <- function(dp,cdf,srcUrl) {
  if(!file.exists(cdf)) {
    message("Downloading data file ", cdf, srcUrl)
    download.file(srcUrl, file.path(cdf))  
  } else {
    message("Source file already exists  ", cdf, srcUrl)
  }
  message("unziping")
  unzip(zipfile = cdf, exdir = dp, overwrite = TRUE)
  
}

#' Prepare the Local enviroment to get all the data, 
#' all folders containing data will be created here.
#' @param dp The Local dataPath
#' @return nothing
prepareLocalPath <- function(dp) {
  message("prepareLocalPath()",dp)  
  if(!file.exists(dp)) {
    dir.create(dp)
  }
}

getSourceFiles <-function(dp) {
  list.files(dataPath,recursive = TRUE,pattern = "*txt")
}

#' Main entryPoint, Execute all other function in the logical sequence to get the data and 
#' referencefiles.
#' 
doItAll <- function() {
  prepareLocalPath(dp = dataPath)
  getallData(dp = dataPath,cdf = coreDataFile, srcUrl = source)
  
}
  
