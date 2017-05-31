## quanteda
library(quanteda)
require(magrittr)
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

c1 <- tokenize(c1,
               remove_numbers = TRUE, 
               remove_symbols = TRUE, 
               remove_separators = TRUE,
               remove_twitter = TRUE,
               remove_hyphens = TRUE,
               remove_url = TRUE,
               what = "fastestword",
               ngrams = 2)

c2 <- tokenize(c2,
               remove_numbers = TRUE, 
               remove_symbols = TRUE, 
               remove_separators = TRUE,
               remove_twitter = TRUE,
               remove_hyphens = TRUE,
               remove_url = TRUE,
               what = "fastestword",
               ngrams = 2)



Mcorpus <- corpus(readLines(con=paste0(dataPath,.Platform$file.sep, f), skipNul = TRUE)) 
Bcorpus <- corpus(readLines(con=paste0(dataPath,.Platform$file.sep, f2), skipNul = TRUE))

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
            remove_punct=TRUE,
            ngrams=2
        )

tdm <- dfm(c1,remove = stopwords("english"),stem = TRUE)
tdm <- dfm_trim(x = tdm,min_count=500)
topfeatures(tdm)

set.seed(100)

textplot_wordcloud(tdm, min.freq = 100, random.order = FALSE,
                   rot.per = .25, 
                   colors = RColorBrewer::brewer.pal(8,"Dark2"))


