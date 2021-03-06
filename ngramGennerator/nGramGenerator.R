## NGran generator 
## get the data form ./data/short (or other specified path) and buld the Ngram files/models


require(tm)
require(dplyr)
require(RWeka)
require(SnowballC)


language_id <- c("de_DE","en_US","fi_FI","ru_RU")
languages <-  c("German","English","Finnish","Russian")

UnigramTokenizer <- function(x) NGramTokenizer(x, Weka_control(min = 1, max = 1))
BigramTokenizer <- function(x) NGramTokenizer(x, Weka_control(min = 2, max = 2))
TrigramTokenizer <- function(x) NGramTokenizer(x, Weka_control(min = 3, max = 3))

writeToFile <- function(dtm, outPath,id,c) {
  message("writeToFile ",outPath,id,c)
  message("language_id[i]", language_id[c])
  write.table(x = as.data.frame(m<-inspect(dtm), stringsAsFactors = FALSE),
              file = paste0(outPath,id,i,language_id[c],".csv"),
              fileEncoding = "UTF-8") 
}

cleanDataFrame<-function(dt){
  dt <- as.data.frame(cbind(rownames(dt), dt[, 1]))
  colnames(dt) <- c('ngrams', 'Freq')
  dt <- dt[order(dt$Freq, decreasing = TRUE), ]
  print(head(dt))
  return(dt)
}


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
    
    message("cleanning done ! - Generating BiGrams")

    dtm <- TermDocumentMatrix(corpus, 
                             control =  list(tokenize = BigramTokenizer,
                                              language=languages[i]
                            ))
    
    dtm<-removeSparseTerms(dtm, 0.28)
    
    save(dtm,file = paste0(outPath,"Dtm_bigram_",i,"_",language_id[i],".RData"))
    
    dt <- as.data.frame(apply(dtm,1,sum))
    dt<- cleanDataFrame(dt)
    write.table(x =dt ,
                file = paste0(outPath,"bigram_",i,"_",language_id[i],".csv"),
                fileEncoding = "UTF-8") 
  
    
    message(" Generating TriGrams")
    
    dtm <- TermDocumentMatrix(corpus, 
                              control =  list(tokenize = TrigramTokenizer,
                                              language=languages[i]
                              ))
    
    dtm<- removeSparseTerms(dtm, 0.38)
    
    save(dtm,file = paste0(outPath,"Dtm_triigram_",i,"_",language_id[i],".RData"))
    
    
    write.table(x = cleanDataFrame( as.data.frame(apply(dtm,1,sum))),
                file = paste0(outPath,"trigram_",i,"_",language_id[i],".csv"),
                fileEncoding = "UTF-8") 
    
    
    message("cleanning done ! - Generating UniGrams")
    
    dtm <- TermDocumentMatrix(corpus, 
                              control =  list(tokenize = UnigramTokenizer,
                                              language=languages[i]
                              ))
    
    dtm <- removeSparseTerms(dtm, 0.38)
    
    save(dtm,file = paste0(outPath,"Dtm_unigram_",i,"_",language_id[i],".RData"))
    
    write.table(x = cleanDataFrame( as.data.frame(apply(dtm,1,sum))),
                file = paste0(outPath,"unigram_",i,"_",language_id[i],".csv"),
                fileEncoding = "UTF-8") 
  

  }
}


simpleProcess(paste0(dataPath,.Platform$file.sep,"short"),paste0(dataPath,.Platform$file.sep,"ngrams",.Platform$file.sep))
##tables must be loaded with read.table not with read.cvs !!!