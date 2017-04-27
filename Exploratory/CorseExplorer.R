require(tm)

#get the local file Reference
source("./Prepare/prepareData.R")

allFiles <- getSourceFiles()

#getting started on reading the files to a Corpus

corps_DE <- Corpus(DirSource("./data/short/",pattern = "^de_DE"),
                   readerControl = list(reader= readPlain,language="de",load=TRUE))