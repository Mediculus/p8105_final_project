library(DT)
library(shiny)
library(shinydashboard)
library(ggplot2)
library(leaflet)
library(dplyr)

choice_map = c("All","US Fed", "NIH", "Industry", "Other")
choice_study_info = c("Sponsor Type", "Condition Type", "Intervention Type", "Status", "Enrollment", "Phase (Clinical Trial)", "Duration")
choice_sponsor = c("sponsor_type", "sponsor", "sponsor_num")
choice_time = c("Studies by Start Year", "Studies by Completion Year")

shinyUI(dashboardPage(
  dashboardHeader(title = "Data for Clinical Trials"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Intro", tabName = "intro", icon = icon("flag")),
      menuItem("Studies Info", tabName = "studyinfo", icon = icon("ambulance")),
      menuItem("Annual Data", tabName = "time", icon = icon("calendar")),
      menuItem("Sponsor Data", tabName = "data", icon = icon("cog")),
      menuItem("Map", tabName = "map", icon = icon("map"))
    )
  ), #close dashboardSidebar
  
  dashboardBody(
    tags$head(
      tags$link(rel = "stylesheet", type = "text/css", href = "custom.css")
    ),
    tabItems(
      tabItem(tabName = "intro", 
              fluidRow(
                box(tags$iframe(src="https://www.youtube.com/embed/CbJzhcMkf_E", width="100%", height="400px")),
                box(tags$iframe(src="https://www.youtube.com/embed/qP4SirMJ0wQ", width="100%", height="400px"))
              )
      ),
      
      
      tabItem(tabName = "map", 
              fluidRow(box(leafletOutput("mymap", height = 700), width = 10),
                       box(
                         selectizeInput("choice",
                                        "Select category",
                                        choice_map), width = 2
                       )
              )
              
      )
      
      
      
    ) #close tabItems
    
  ) #close dashboardBody
  
) #close dashboardPage
) #close shinyUI