#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(tm)

repKatz <- repeatable(katz_model)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
  observeEvent(input$go, {
    output$word <- renderText(
       
      repKatz(input$toBeCompleted)
    )
    output$phrase <- renderText(
      input$toBeCompleted
    )
  }

  )
  
})
