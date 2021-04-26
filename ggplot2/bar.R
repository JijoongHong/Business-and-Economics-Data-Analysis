install.packages("dplyr")
library(dplyr)
library(ggplot2)
dt = as.data.frame(ggplot2::mpg)

#ggplot(data=dt, aes(x=drv)) + geom_bar()
dt1 = dt %>%
  group_by(drv) %>%
  summarise(mean_hwy = mean(hwy))

ggplot(data=dt1, aes(x=reorder(drv,mean_hwy), y=mean_hwy)) + geom_col() #평균 


#drv 변수에 대한 그룹별 hwy 평균값 구하기 

