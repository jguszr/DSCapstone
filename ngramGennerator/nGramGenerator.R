## NGran generator 
## get the data form ./data/short (or other specified path) and buld the Ngram files/models


require(tm)
require(dplyr)
require(RWeka)
require(SnowballC)


language_id <- c("de_DE","en_US","fi_FI","ru_RU")
languages <-  c("German","English","Finnish","Russian")

BigramTokenizer <- function(x,mi=1,ma=1) NGramTokenizer(x, Weka_control(min = mi, max = ma))

simpleProcess <- function(path,outPath) {
  
  message("simpleProcess", path)
  for (i in 1:length(language_id)) {
    
    message("simpleProcess - ", language_id[i])
    path = paste0(dataPath,.Platform$file.sep,"short",.Platform$file.sep)
    corpus <- VCorpus(DirSource(path,pattern = paste0("^",language_id[i]),encoding = "UTF-8"),
                      readerControl = list(reader= readPlain,language=languages[i],load=TRUE))
    message("corpus done - mapping  - ", language_id[i])
    
    corpus <- tm_map(corpus,content_transformer(tolower))
    corpus <- tm_map(corpus,removeWords,stopwords(languages[i]))
    corpus <- tm_map(corpus,stripWhitespace)
    corpus <- tm_map(corpus,stemDocument)
    corpus <- tm_map(corpus,removeNumbers)
    corpus <- tm_map(corpus,removePunctuation)
    
    message("cleanning done ! - Generating nGrams")
    gc()
    for(j in 1:3) {
        message("Generating Ngran n=",  J)
        dtm <- DocumentTermMatrix(corpus, 
                              control =  list(tokenize = BigramTokenizer(corpus,mi = j,ma = j),
                                              language=language[i]
                                          ))
        m<-inspect(dtm)
        DF <- as.data.frame(m, stringsAsFactors = FALSE)
        write.table(x = DF,
                    file = paste0(outPath,j,language_id[i],".csv"),
                    fileEncoding = "UTF-8") 
    }

    rm(corpus)
    
  }
}

simpleProcess(paste0(dataPath,.Platform$file.sep,"short"),paste0(dataPath,.Platform$file.sep,"short"))
