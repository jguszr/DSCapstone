#
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel(h1("Coursera Capstone Next Word Project",align = "center")),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      textInput("toBeCompleted", "Your Phrase", " "),
      actionButton("go",label = "fetch !")
      
      
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      strong("Text input predicted:"),
      p(textOutput("phrase")),
      strong("Prediction:"),
      p(span(textOutput("word"),style="color:blue"))
    )
  )
))
