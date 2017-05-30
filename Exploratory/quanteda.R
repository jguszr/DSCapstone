## quanteda
library(quanteda)

dataPath <- "./data"
shortFiles <- "./data/short"
sampleSize <- 50000

getSourceFiles <-function(dp) {
  list.files(dataPath,recursive = TRUE,pattern = "*txt")
}


f <- "short/en_US.news.txt"
f2 <- "short/en_US.blogs.txt"

c1 <- readLines(con=paste0(dataPath,.Platform$file.sep, f), skipNul = TRUE)
c2 <- readLines(con=paste0(dataPath,.Platform$file.sep, f), skipNul = TRUE)

c1 <- 
Mcorpus <- corpus(c1) 
Bcorpus <- corpus(c2)

finalCorpus <- Mcorpus + Bcorpus
rm(Mcorpus)
rm(Bcorpus)

summary(finalCorpus,showmeta = TRUE)
texts(finalCorpus)[100]

#options(width = 200)
#kwic(finalCorpus, "terror")


tdm <-  dfm(finalCorpus,
            verbose = TRUE, 
            remove = stopwords("english"), 
            stem = TRUE, 
            removePunct=TRUE
        )

