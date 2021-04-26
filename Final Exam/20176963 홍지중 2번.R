library(dplyr)
library(MASS)
library(ggplot2)

dt = cats
dt1 = dt %>% group_by(Sex) %>% select(Bwt)
ggplot(data = dt1, aes(x = Sex, y = Bwt)) + geom_boxplot() + ylab("생쥐의 몸무게")
