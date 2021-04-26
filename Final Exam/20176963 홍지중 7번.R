library(ggplot2)
library(dplyr)

dt = mpg
dt %>% group_by(manufacturer) %>% summarise(mean_hwy = mean(hwy)) %>% 
  arrange(desc(mean_hwy))%>%head(3)
