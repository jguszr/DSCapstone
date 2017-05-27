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



# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
  observeEvent(input$go, {
    output$word <- renderText(
       
      katz_model(input$toBeCompleted)
    )
    output$phrase <- renderText(
      input$toBeCompleted
    )
  }

  )
  
})
