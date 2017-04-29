## Getting data


## Definitions

dataPath <- "./data"
shortFiles <- "./data/short"
sampleSize <- 50000

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
prepareLocalPath <- function() {
  message("prepareLocalPath()",dataPath)  
  
  if(!file.exists(dataPath)) {
    dir.create(dataPath)
  }
  
  if(!file.exists(shortFiles)) {
    dir.create(shortFiles)
  }
  
  
  
}

getSourceFiles <-function(dp) {
  list.files(dataPath,recursive = TRUE,pattern = "*txt")
}

buildShortTextFiles <- function() {
  message("buildShortTextFiles")
  for(f in getSourceFiles()) {
    print(f)
    content <- readLines(con=paste0(dataPath,.Platform$file.sep, f),n = sampleSize, skipNul = TRUE)
    writeLines(text = content,
               con = paste0(shortFiles,.Platform$file.sep,basename(f)[1]))
  }
}


#' Main entryPoint, Execute all other function in the logical sequence to get the data and 
#' referencefiles.
#' 
doItAll <- function() {
  prepareLocalPath()
  getallData(dp = dataPath,cdf = coreDataFile, srcUrl = source)
  buildShortTextFiles()
  
}
  
