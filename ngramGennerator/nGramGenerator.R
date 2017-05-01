## NGran generator 
## get the data form ./data/short (or other specified path) and buld the Ngram files/models

language_id <- c("de_DE","en_US","fi_FI","ru_RU")
languages <-  c("German","English","Finnish","Russian")

processAllShorts <- function(path) {
  
  for(i in language_id) {
    corpus <- VCorpus(DirSource(path,pattern = paste0("^",language_id[i]),encoding = "UTF-8"),
                      readerControl = list(reader= readPlain,language="de",load=TRUE))
  }
  
  
}