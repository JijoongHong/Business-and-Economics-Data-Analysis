library(dplyr)
library(ggplot2)
mpg = as.data.frame(ggplot2::mpg)

ggplot(data = mpg, aes(x = displ, y = hwy)) + geom_point() + xlim(3,6) +ylim(10,30)

#배기량과 고속도로 연비 