## Create plots

race_df |>
  filter(Race %in% c('Asian', 'White', 'Black', 'Hispanic')) |>
  ggplot() +
  aes( x = Academic_Year, 
       y = Count, 
       col = Race,
       group = Race) +
  geom_line()

race_df |>
  filter(Race %in% c('Asian', 'White', 'Black', 'Hispanic')) |>
  ggplot() +
  aes( x = Academic_Year, 
       y = Count, 
       fill = Race) +
  geom_col(position = 'fill')


race_df |>
  filter(Race %in% c('Asian', 'White', 'Black', 'Hispanic')) |>
  ggplot() +
  aes( x = Academic_Year, 
       y = Count, 
       fill = Race) +
  geom_col(position = 'dodge') 
