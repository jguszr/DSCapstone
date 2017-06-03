#
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel(h1("Coursera Capstone Next Word Project",align = "center")),
  br(),
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      textInput("toBeCompleted", "Your Phrase", " "),
      actionButton("go",label = "fetch !"),
      br(),
      p("By jguszr for Coursera Data Science Capstone Project"),
      img(src="http://img.picturequotes.com/2/63/62335/patience-is-a-virtue-quote-1.jpg",height = 200, width=200,align="center")
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      strong("Text input predicted:"),
      p(textOutput("phrase")),
      strong("Prediction:"),
      p(span(textOutput("word"),style="color:blue")),
      br()
      
    )
  )
))
