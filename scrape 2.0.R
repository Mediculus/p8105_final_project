
url_10000 = read_csv("./SearchResults_10000.csv") %>%
  janitor::clean_names() %>%
  select(nct_number) %>%
  mutate(url = str_c("https://clinicaltrials.gov/ct2/show/results/", nct_number)) %>%
  select(-nct_number) 

url_10000 = url_10000$url

# scraper
for (url in url_10000) {
  
  trial_html = read_html(url)
  # read html files
  # info for outcome_measure
  outcome_measure =
    trial_html %>%
    html_nodes("#EXPAND-outcome-data-1 .labelSubtle") %>%
    html_text()
  if(length(outcome_measure) == 0){next()}
  print(outcome_measure)


  if(str_detect(outcome_measure,"[pP]articipants") ){
    print("scraping")
    print(url)
    # col_names info
    col_names = trial_html %>% html_nodes("#EXPAND-outcome-data-1 tbody:nth-child(2) tr:nth-child(1) .de-outcomeLabelCell") %>%
      html_text()
    print(col_names)
    # row_nams info
    row_names = trial_html %>% html_nodes("#EXPAND-outcome-data-1 .labelSubtle , #EXPAND-outcome-data-1 tbody:nth-child(2) tr:nth-child(4) .de-outcomeLabelCell
") %>%
      html_text()
    print(row_names)
    #scrape the actual data, with variable table length
    test123 <- trial_html %>% html_nodes("#EXPAND-outcome-data-1 .de-numValue_outcomeDataCell") %>%
      html_text() %>% as.numeric() 
    print(test123)
    
    test12 <- trial_html %>% html_nodes("#EXPAND-outcome-data-1 .de-lightBorder .de-outcomeDataCell , .de-numValue_outcomeDataCell") %>%
      html_text() %>% as.numeric() 
    test12 = test12[!is.na(test12)]
    print(test12)
    
    matrix = data_to_matrix(test12, col_names, row_names)
    print(matrix)
    
    }
  else{next()}
}

# build a matrix
data_to_matrix = function(test12,col_names,row_names){
  matrix(test123, ncol=length(col_names[-1]), nrow=length(row_names), byrow=TRUE)
}
