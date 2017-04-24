require(tm)

#get the local file Reference
source("./Prepare/prepareData.R")

allFiles <- getSourceFiles()

#getting started on reading the files to a Corpus
corps <- Corpus(DirSource("./data/final/de_DE"),
                readerControl = list(reader= readPlain,language="de",load=TRUE))