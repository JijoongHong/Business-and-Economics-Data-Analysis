library(dplyr)
library(ggplot2)
mpg = as.data.frame(ggplot2::mpg)

mpg
df = mpg %>%
  filter(class == "suv") %>%
  group_by(manufacturer) %>%
  summarise(mean_cty = mean(cty))%>%
  arrange(desc(mean_cty)) %>% #desc : 역순, 내림차순
  head(5)

ggplot(data = df, aes(x = reorder(manufacturer, -mean_cty), ### -는 내림차순 
                      y = mean_cty)) + geom_col()


#어떤회사에서생산한SUV 차종의도시연비가높은지확인
#SUV 차종을대상으로평균도시연비(cty)가가장높은회사다섯곳을막대그래프로표현하고, 막대는연비가높은순으로정렬

ggplot(data = mpg, aes(x = class)) + geom_bar()
#자동차중에서어떤자동차종류(class)가가장많게나타나는지확인
#자동차종류별빈도를표현한막대그래프생성

