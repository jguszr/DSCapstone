## quanteda
library(quanteda)

dataPath <- "./data"
shortFiles <- "./data/short"
sampleSize <- 50000

getSourceFiles <-function(dp) {
  list.files(dataPath,recursive = TRUE,pattern = "*txt")
}


f <- "final/en_US/en_US.news.txt"
f2 <- "final/en_US/en_US.blogs.txt"

Mcorpus <- corpus(readLines(con=paste0(dataPath,.Platform$file.sep, f), skipNul = TRUE)) 
Bcorpus <- corpus(readLines(con=paste0(dataPath,.Platform$file.sep, f2), skipNul = TRUE))

finalCorpus <- Mcorpus + Bcorpus
rm(Mcorpus)
rm(Bcorpus)

summary(finalCorpus,showmeta = TRUE)
texts(finalCorpus)[100]

options(width = 200)
kwic(finalCorpus, "terror")
