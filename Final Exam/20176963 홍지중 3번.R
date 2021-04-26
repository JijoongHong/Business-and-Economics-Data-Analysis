library(dplyr)
library(MASS)

dt = cats

mean_of_Bwt = dt %>% group_by(Sex) %>% summarise(mean_Bwt = mean(Bwt))
sd_of_Bwt = dt %>% group_by(Sex) %>% summarise(sd_Bwt = sd(Bwt))

mean_of_Hwt = dt %>% group_by(Sex) %>% summarise(mean_Hwt = mean(Hwt))
sd_of_Hwt = dt %>% group_by(Sex) %>% summarise(sd_Hwt = sd(Hwt))
