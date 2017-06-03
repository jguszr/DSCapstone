NextWord - Data Science Captstone Project
========================================================
author: Jose Gustavo Z. Rosa
date: May/2017
autosize: true

The Project
========================================================
The Project concept is based on the needs of the SwiftKey company related to "predict" the next word in a text, To do so, a textual dataset were provided in 4 different languages (English, Deusth, Russian and Finland). The key aspect is to use Text Mining and some NLP techniques to build a *dataset* good enough for :  

- Bring some understanding about the general aspect  
- language independant Text Clean-up
- Dataset build
- Identify a good relationship between the dataset size versus the algorithm performance.

Approach
========================================================


I approach this project from a streamline point of view, in which I separete different objectives in diferent files. So at this point the project contains 4 folder structures as follows

* **data** : Contains a individual folder for each step of the process, from raw file to Ngram Files
* **Prepare** : Contains the R Scripts to download and setup the local systems *data* structure
* **Exploratory** : Contains the R Scripts That I used to learn the TM package among some preliminary studies regarding the data it self. 
* **ngramGennerator** : Contains the R Scripts used to process the short files  into TermDocumentMatrix into three new CVS files containing the frequency of the most comon Ngram in question.


The NextWorld Algorithm & Conclusion
========================================================
After investing some time researching more sofisticated algorithms and R packages I found the [Katz Backoff model](https://en.wikipedia.org/wiki/Katz%27s_back-off_model) which I believe fit's the bill properly and there are different implementations of it In R.

Due to size of data files  and performance, I had to reduce my data files in order to the Katz Model works a bit faster, to do so, I had to work reducing the text sparsity, specially for bigrans from 0.56 down to 0.28. 

The shiny app ran OK with that amout of data, and I choose not to brush too much on the UI, and rather I invest more time on trying to refine a little more the ngram generation script using not only the TM package but also the Quanteda packaga which I think ran better than TM specially for Term matrix analisys and overall clean up operations.

