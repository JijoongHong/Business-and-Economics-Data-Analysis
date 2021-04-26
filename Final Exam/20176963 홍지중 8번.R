library(ggplot2)
library(dplyr)

dt = mpg
dt = dt %>% select(fl, cty) %>% filter(fl %in% c("r", "p"))
t.test(data = dt, cty ~ fl, var.equal = T) 
