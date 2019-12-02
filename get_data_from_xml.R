library(XML)
library(tidyverse)
library(rvest)
library(readxl)


##### this is an xml reader for data from clinicaltrials.gov 
##### only for p8105_final project fragility index group

### step 1
### get all names of the downloaded xml files
get_file_names = function(){
  file_list = tibble(
    file_name = list.files("/Users/adobel/Desktop/Columbia/data\ science/homework/rclinicaltrials/AllPublicXML", recursive = T)
  ) #remember to change the directory while using this function!
} # xml files are too large, no need to commit to github

### step 2
### build a dataframe for future mapping

all_files = get_file_names() %>%
  separate(file_name,c("1","file_name")) %>%
  select('file_name') %>%
  .[-1,]

### step 3
### build a function that automatically reads and parses each xml file, and organizes the information into a dataframe
xml_reader = function(file_name){
  file = xmlParse(str_c("/Users/adobel/Desktop/Columbia/data\ science/homework/rclinicaltrials/AllPublicXML/",
                        str_sub(file_name,start = 1, end = 7), "xxxx/",
                        file_name,".xml"))  #directory of each file
#########
  xmltop = xmlRoot(file) # get nodes
######### get interested vaariables
  new_tbl = tibble(
    overall_status = xmlValue(xmltop[['overall_status']]),
    phase = xmlValue(xmltop[['phase']]),
    study_type = xmlValue(xmltop[['study_type']]),
    masking = xmlValue(xmltop[['study_design_info']][['masking']]),
    
    primary_outcome = xmlValue(xmltop[['primary_outcome']]),
    sponsors =  xmlValue(xmltop[['sponsors']]),
    start_date = xmlValue(xmltop[['start_date']]),
    completion_date = xmlValue(xmltop[['completion_date']]),
    primary_completion_date = xmlValue(xmltop[['primary_completion_date']]),
    observational_model = xmlValue(xmltop[['study_design_info']][['observational_model']]),
    time_perspective = xmlValue(xmltop[['study_design_info']][['time_perspective']]),
    measure = xmlValue(xmltop[['primary_outcome']][['measure']]),
    time_frame = xmlValue(xmltop[['primary_outcome']][['time_frame']]),
    enrollment = xmlValue(xmltop[['enrollment']]),
    study_pop = xmlValue(xmltop[['eligibility']][['study_pop']]),
    sampling_method = xmlValue(xmltop[['eligibility']][['sampling_method']]),
    criteria = xmlValue(xmltop[['eligibility']][['criteria']]),
    gender = xmlValue(xmltop[['eligibility']][['gender']]),
    minimum_age = xmlValue(xmltop[['eligibility']][['minimum_age']]),
    maximum_age = xmlValue(xmltop[['eligibility']][['maximum_age']]),
    healthy_volunteers = xmlValue(xmltop[['eligibility']][['healthy_volunteers']]),
    #xmlValue(xmltop[['overall_official']]) #
    #xmlValue(xmltop[['overall_official']][['affiliation']])#
    #xmlValue(xmltop[['overall_official']][['affiliation']])# 
    study_first_submitted = xmlValue(xmltop[['study_first_submitted']]),
    study_first_posted = xmlValue(xmltop[['study_first_posted']]),
    location_city = xmlValue(xmltop[['location']][['facility']][['address']][['city']]),
    location_state = xmlValue(xmltop[['location']][['facility']][['address']][['state']]),
    location_country = xmlValue(xmltop[['location']][['facility']][['address']][['country']]),
    agency_class = xmlValue(xmltop[['sponsors']][['lead_sponsor']][['agency_class']])
    )
}

# build dataset
data_from_xml = map_df(all_files$file_name,xml_reader)
data_from_xml = bind_cols(all_files,data_from_xml)


data_from_xml_cleaned = data_from_xml %>% 
  drop_na() %>%
  mutate(file_group = str_c( str_sub(file_name,start = 1, end = 7), "xxxx"))

# save files
write_csv(data_from_xml,"./data_from_xml.csv")
write_csv(data_from_xml_cleaned ,"./data_from_xml_cleaned.csv")
# csv files are too large, no need to commit





### only for US
us_only =
  data_from_xml %>%
  filter(location_country == "United States") %>%
  mutate(location_state = recode(location_state,
                                 "Missouri" = "Missouri State"))


### dont run !
us_only
geocode_us = read_csv("/Users/adobel/Desktop/Columbia/data\ science/homework/fragility\ index\ cal/final\ project/p8105_final_project/simplemaps_worldcities_basicv1.5/worldcities.csv")
geocode_us = geocode_us %>% filter(country == "United States") %>%
  mutate(location_city = city,
         location_country = country) %>%
  select(location_country, location_city, lat, lng)
### dont run !



geocode_state = read_excel("/Users/adobel/Desktop/Columbia/data\ science/homework/fragility\ index\ cal/final\ project/p8105_final_project/simplemaps_worldcities_basicv1.5/states.xlsx")
geocode_state =
  geocode_state %>%
  separate(location_state,c("location_state","country"),sep = ",") %>%
  select(-country) %>%
  rename("state_lat" = lat,
         "state_lng" = lng)

test = left_join(us_only, geocode_state) # lat\lng  is only for states!!!!

###test is dataset for plotting map
      
skimr::skim(test$state_lat) # check NAs, all lat, lng created!



                       

                       

                       