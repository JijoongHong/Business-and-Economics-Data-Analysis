library(ggplot2)
library(dplyr)

dt = mpg

dt %>% group_by(manufacturer) %>% filter(class == "compact") %>% summarise(n=n()) %>%
  arrange(desc(n))
