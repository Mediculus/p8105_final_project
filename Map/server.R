library(shiny)
library(shinyjs)
library(leaflet)

## this is only a test ###

test = test %>% mutate(study_type = ifelse(study_type == "Interventional", "Clinical Trial","Observational Study")) %>%
  select(state_lng,state_lat,study_type,agency_class)
df = test
df1 = test %>% filter( agency_class == "U.S. Fed")
df2 = test %>% filter( agency_class == "NIH")
df3 = test %>% filter( agency_class == "Industry")
df4 = test %>% filter( agency_class == "Other")




################
# This is only for US clinical trials
## 1. merge latitude and longtitude ok
## 2. recode the study type 
## 3. create a ineraction map grouped by study type and agency class
  



shinyServer(function(input, output){
  ### MAPS ###
  output$mymap <- renderLeaflet({
    
    if (input$choice == "All") {
      leaflet() %>% 
        addTiles() %>%
        addMarkers(data = df, lng = ~ state_lng, lat = ~ state_lat, group = "Clinical Trial", clusterOptions = markerClusterOptions()) %>%
        addMarkers(data = df, lng = ~ state_lng, lat = ~ state_lat, group = "Observational Study", clusterOptions = markerClusterOptions()) %>%
        addLayersControl(
          baseGroups = c("Clinical Trial", "Observational Study"),
          options = layersControlOptions(collapsed = FALSE),
          position = c("topleft") 
        ) 
    } 
    
    else if (input$choice == "US Fed") {
      leaflet() %>%
        addTiles() %>%
        addMarkers(data = df1, lng = ~ state_lng, lat = ~ state_lat, group = "Clinical Trial", clusterOptions = markerClusterOptions()) %>%
        addMarkers(data = df1, lng = ~ state_lng, lat = ~ state_lat, group = "Observational Study", clusterOptions = markerClusterOptions()) %>%
        addLayersControl(
          baseGroups = c("Clinical Trial", "Observational Study"),
          options = layersControlOptions(collapsed = FALSE),
          position = c("topleft")
        )        
      
    } else if (input$choice == "NIH") {
      leaflet() %>%
        addTiles() %>%
        addMarkers(data = df2, lng = ~ state_lng, lat = ~ state_lat, group = "Clinical Trial", clusterOptions = markerClusterOptions()) %>%
        addMarkers(data = df2, lng = ~ state_lng, lat = ~ state_lat, group = "Observational Study", clusterOptions = markerClusterOptions()) %>%
        addLayersControl(
          baseGroups = c("Clinical Trial", "Observational Study"),
          options = layersControlOptions(collapsed = FALSE),
          position = c("topleft")
        )
      
    } else if (input$choice == "Industry") {
      leaflet() %>%
        addTiles() %>%
        addMarkers(data = df3, lng = ~ state_lng, lat = ~ state_lat, group = "Clinical Trial", clusterOptions = markerClusterOptions()) %>%
        addMarkers(data = df3, lng = ~ state_lng, lat = ~ state_lat, group = "Observational Study", clusterOptions = markerClusterOptions()) %>%
        addLayersControl(
          baseGroups = c("Clinical Trial", "Observational Study"),
          options = layersControlOptions(collapsed = FALSE),
          position = c("topleft")
        )        
      
    } else {
      leaflet() %>%
        addTiles() %>%
        addMarkers(data = df4, lng = ~ state_lng, lat = ~ state_lat, group = "Clinical Trial", clusterOptions = markerClusterOptions()) %>%
        addMarkers(data = df4,lng = ~ state_lng, lat = ~ state_lat, group = "Observational Study", clusterOptions = markerClusterOptions()) %>%
        addLayersControl(
          baseGroups = c("Clinical Trial", "Observational Study"),
          options = layersControlOptions(collapsed = FALSE),
          position = c("topleft")
        )
    }
    
  })  
  
})
