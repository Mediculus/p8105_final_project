## this is for visualization 

library(plotly)


test = read_csv("test.csv") %>% filter(phase == "Phase 3")
test_new =
  test %>%
  mutate(completion_year = str_sub(completion_date,start = -4))

test_new


completion_by_agency =
  test_new %>%
  group_by(agency_class,completion_year) %>%
  summarise(number_of_clinical_trials = n(),
            participants = sum(enrollment)) %>%
  drop_na() 

completion_by_agency$completion_year = as.numeric(completion_by_agency$completion_year)
  



a =
  ggplot(data = completion_by_agency, aes(x = participants, y = number_of_clinical_trials, color = agency_class)) +
  geom_point(aes(size = number_of_clinical_trials, frame = completion_year)) +
  scale_x_log10()

ggplotly(a)



###
completion_by_agency %>%
  plot_ly(
  x = ~ number_of_clinical_trials, 
  y = ~(participants), 
  size = ~(participants), 
  type = 'scatter',
  mode = 'markers',
  color = ~agency_class,
  frame = ~completion_year
) %>%
  layout(
    xaxis = list(
      type = "log"
    )
  )

#####

plot_ly(completion_by_agency,frame = ~completion_year) %>%
  add_lines(
    x = ~ as.numeric(completion_year), 
    y = ~ number_of_clinical_trials,
    type = 'scatter',
    mode = 'markers',
    split = ~ location_state
    
  )

completion_by_agency %>%
  plot_ly( x = ~ , y = ~ number_of_clinical_trials ,type = 'bar')
add_trace(x = ~ factor(agency_class), y = ~ number_of_clinical_trials ,type = 'bar')

ggplot()
