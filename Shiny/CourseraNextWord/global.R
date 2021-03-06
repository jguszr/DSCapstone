## Global.R

load(file = "Dtm_unigram_2_en_US.RData")
tdm_unigram <- dtm
rm(dtm)
load(file = "Dtm_bigram_2_en_US.RData")
tdm_bigram <- dtm
rm(dtm)
load(file = "Dtm_triigram_2_en_US.RData")
tdm_trigram <-dtm
rm(dtm)


preprocess_corpus <- function(corpus) {
  
  corpus_preprocessed <- tm_map(corpus, removePunctuation)
  corpus_preprocessed <- tm_map(corpus_preprocessed, removeNumbers)
  corpus_preprocessed <-
    tm_map(corpus_preprocessed, content_transformer(tolower))
  corpus_preprocessed <- tm_map(corpus_preprocessed, stripWhitespace)
  corpus_preprocessed <-
    tm_map(corpus_preprocessed, removeWords, stopwords("en"))
  return(corpus_preprocessed)
  
}


katz_model <- function(phrase) {
  
  if (typeof(phrase) == "character") {
    
    trigram_model <- function(tokens) {
      
      key <- function(tokens) {
        paste(
          tail(
            tokens,
            n = 2
          )[1],
          tail(
            tokens,
            n = 2
          )[2]
        )
      }
      
      # find matches and their count
      matches_count <- function(phrase) {
        sapply(
          names(
            which(
              sapply(
                Terms(tdm_trigram),
                function(terms) {
                  grepl(
                    phrase,
                    paste(
                      strsplit(
                        terms, split = " "
                      )[[1]][1],
                      strsplit(
                        terms, split = " "
                      )[[1]][2]
                    ),
                    ignore.case = TRUE
                  )
                }
              )
            )
          ),
          function(match) sum(tm_term_score(tdm_trigram, match))
        )
      }
      
      # find the last word of the most frequent match
      tail_of_most_frequent_match <- function(phrase) {
        matches <- matches_count(phrase)
        if (length(matches) > 0) {
          tail(
            strsplit(
              names(
                head(
                  which(matches == max(matches)),
                  n = 1
                )
              )
              , split = " ")[[1]],
            n = 1
          )
        } else bigram_model(tail(corpus_input, n = 1))
      }
      
      return(
        tail_of_most_frequent_match(key(tokens))
      )
      
    }
    
    bigram_model <- function(token) {
      
      # find matches and their count
      matches_count <- function(phrase) {
        sapply(
          names(
            which(
              sapply(
                Terms(tdm_bigram),
                function(terms) {
                  grepl(
                    phrase,
                    strsplit(
                      terms, split = " "
                    )[[1]][1],
                    ignore.case = TRUE
                  )
                }
              )
            )
          ),
          function(match) sum(tm_term_score(tdm_bigram, match))
        )
      }
      
      # find the last word of the most frequent match
      tail_of_most_frequent_match <- function(phrase) {
        matches <- matches_count(phrase)
        if (length(matches) > 0) {
          tail(
            strsplit(
              names(
                head(
                  which(matches == max(matches)),
                  n = 1
                )
              )
              , split = " ")[[1]],
            n = 1
          )
        } else unigram_model(tail(corpus_input, n = 1))
      }
      
      return(
        tail_of_most_frequent_match(token)
      )
      
    }
    
    unigram_model <- function(token) {
      
      associations <-
        findAssocs(tdm_unigram, token, corlimit = .99)[[1]]
      if (length(associations) > 0) {
        names(sample(which(associations == max(associations)), 1))
      } else return("will")
      
    }
    print("Bang !")
    # preprocess phrase
    corpus_input <-
      VCorpus(
        VectorSource(phrase),
        list(reader = PlainTextDocument)
      )
    corpus_input <- preprocess_corpus(corpus_input)
    corpus_input <- scan_tokenizer(corpus_input[[1]][[1]][1])
    
    return(
      if (length(corpus_input) >= 2) {
        trigram_model(corpus_input)
      } else if (length(corpus_input) == 1) {
        bigram_model(corpus_input)
      } else unigram_model(corpus_input)
    )
    
  } else {
    stop("non-character or null input")
  }
  
}


