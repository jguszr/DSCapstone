require(tm)
require(RTextTools)
require(RWeka)
require(SnowballC)
library(stylo)
#get the local file Reference
source("./Prepare/prepareData.R")

allFiles <- getSourceFiles()

#getting started on reading the files to a Corpus
#VCorpus do not hang when using the Inspect command
corps_DE <- VCorpus(DirSource("./data/short/",pattern = "^de_DE",encoding = "UTF-8"),
                   readerControl = list(reader= readPlain,language="de",load=TRUE))

#inspect example - to get the text 
inspect(corps_DE[[2]])

#to get meta information on a document 
meta(corps_DE[2])

#to get a specific information on a document
meta(corps_DE[2], "language")

#Transformations
corps_DE <- tm_map(corps_DE,content_transformer(tolower))
corps_DE <- tm_map(corps_DE,removeWords,stopwords("de"))
corps_DE <- tm_map(corps_DE,stripWhitespace)
corps_DE <- tm_map(corps_DE,stemDocument)
corps_DE <- tm_map(corps_DE,removeNumbers)
corps_DE <- tm_map(corps_DE,removePunctuation)

#creating a document term matrix 
dtm <- DocumentTermMatrix(corps_DE)

#finding term frequencies 
findFreqTerms(dtm, 5)
#find associated terms.
findAssocs(dtm,"vielen dank", 0.4)

#works but it is slow - the document term matrix didin't work
gc()
dtmRtext <- create_matrix(corps_DE,language = "de",
                          ngramLength = 3)
findFreqTerms(dtmRtext,  highfreq = 999)
findMostFreqTerms(x = dtmRtext)

#work with the new sample size
BigramTokenizer <- function(x) NGramTokenizer(x, Weka_control(min = 2, max = 2))
dtm <- DocumentTermMatrix(corps_DE, 
                          control =  list(tokenize = BigramTokenizer,
                                          language="german",
                                          removeNumbers=TRUE,
                                          stemming=TRUE,
                                          stopwords=TRUE
                                          )
                          )

removeSparseTerms(dtm, 0.4)
findFreqTerms(dtm,  highfreq = 999)
freqBigrans <- findMostFreqTerms(x = dtm)

