## NGran generator 
## get the data form ./data/short (or other specified path) and buld the Ngram files/models

require(doParallel)
require (foreach)
require(tm)
cores=detectCores()
cl <- makeCluster(cores[1]-1) #not to overload your computer
registerDoParallel(cl)

language_id <- c("de_DE","en_US","fi_FI","ru_RU")
languages <-  c("German","English","Finnish","Russian")



processAllInParallelShorts <- function(path) {
  language_id <- c("de_DE","en_US","fi_FI","ru_RU")
  foreach(i = 1:length(language_id),.packages = c("tm")) %dopar% {
    
    corpus <- VCorpus(DirSource(path,pattern = paste0("^",language_id[i]),encoding = "UTF-8"),
                      readerControl = list(reader= readPlain,language="de",load=TRUE))
  }
  
  
}

processAllShorts(shortFiles)