library(shinythemes)
library(shiny)

shinyUI(
  fluidPage( theme = shinytheme("journal"),
             h1("Input the Numbers"),
             sidebarPanel(
    # Copy the line below to make a number input box into the UI.
               numericInput("a", label = h3("Con - Number WITH primary endpoint"), value = 1, min = 0, max = 1000000000),
               numericInput("b", label = h3("Con - Number WITHOUT primary endpoint"), value = 1,min = 0, max = 1000000000),
               numericInput("c", label = h3("EXP - Number WITH primary endpoint"), value = 1,min = 0, max = 1000000000),
               numericInput("d", label = h3("EXP - Number WITHOUT primary endpoint"), value = 1, min = 0, max = 1000000000),
               actionButton("reset", "Reset", class = "btn-primary"),
               actionButton("calculate", "calculate fragility index", class = "btn-primary")),
    
    hr(),
    mainPanel(
      h1("Result"),
      h2("The fragility index of this study is:"),
      h2(textOutput("value")),
      h2(tableOutput("table"))))

             
  )