require(tm)

#get the local file Reference
source("./Prepare/prepareData.R")

allFiles <- getSourceFiles()

#getting started on reading the files to a Corpus
#VCorpus do not hang when using the Inspect command
corps_DE <- VCorpus(DirSource("./data/short/",pattern = "^de_DE"),
                   readerControl = list(reader= readPlain,language="de",load=TRUE))

