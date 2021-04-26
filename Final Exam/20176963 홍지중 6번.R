library(ggplot2)
library(dplyr)

dt = mpg
dt %>% group_by(class) %>% summarise(mean_cty = mean(city)) %>% arrange(desc(mean_cty)) #클래스별 도시연비 평균 계산하여 높은 순 정렬 
