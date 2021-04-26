library(dplyr)
library(ggplot2)
mpg = as.data.frame(ggplot2::mpg)

ggplot(data = mpg, aes(x=drv, y=hwy)) + geom_boxplot()

mpg2 = mpg %>%
  filter(class == c("compact", "subcompact", "suv"))

ggplot(data = mpg2, aes(x = class, y = cty)) + geom_boxplot()

#자동차종류(class)가compact, subcompact, suv인자동차의도시연비(cty)가어떻게나타나는지비교해
#3개차종의cty를나타낸상자그래프만들기