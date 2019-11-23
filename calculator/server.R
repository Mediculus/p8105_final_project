library(devtools)
install_github('kippjohnson/fragilityindex')
library(fragilityindex)
library(tidyverse)
library(shinyjs)



shinyServer(
  function(input, output) {
    #create a plot

    observeEvent(input$calculate, 
                 {
                   output$result <- renderText("The fragility index of this study is:")
                   output$value <- renderText(as.character(fragility.index(input$a,input$c,
                                                                           input$a + input$b,
                                                                           input$c + input$d)))
                   
                   output$table <- renderTable({
                     matrix = matrix(c(input$a,input$c,input$b,input$d), 2, 2)
                     rownames(matrix) = c("E+", "E-")
                     colnames(matrix) = c("D+", "D-")
                     matrix
                   })
                 }
      )
 
  }
)



# test 

