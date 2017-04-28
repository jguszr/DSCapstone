require(tm)

#get the local file Reference
source("./Prepare/prepareData.R")

allFiles <- getSourceFiles()

#getting started on reading the files to a Corpus
#VCorpus do not hang when using the Inspect command
corps_DE <- VCorpus(DirSource("./data/short/",pattern = "^de_DE"),
                   readerControl = list(reader= readPlain,language="de",load=TRUE))

#inspect example - to get the text 
inspect(corps_DE[[2]])

#to get meta information on a document 
meta(corps_DE[2])

#to get a specific information on a document
meta(corps_DE[2], "language")

#Transformations
corps_DE <- tm_map(corps_DE,content_transformer(tolower))

#removing stop words
corps_DE <- tm_map(corps_DE,removeWords,stopwords("de"))

#creating a document term matrix
dtm <- DocumentTermMatrix(corps_DE)

#finding term frequencies 
findFreqTerms(dtm, 5)
#find associated terms.
findAssocs(dtm,"kultur", 0.8)

