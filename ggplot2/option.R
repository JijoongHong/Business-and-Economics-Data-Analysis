library(ggplot2)
library(ggthemes)

a = ggplot(data = diamonds, aes(x = carat, y = price, color = clarity)) #shape : 점의 모양 
b = geom_point(alpha=0.5) #점의 투명도
c = theme_solarized_2() #배경 테마
d = guides(color = guide_legend(override.aes = list(alpha=1))) #범례의 투명도 조정
e = xlim(0,3)
f = ylim(0,15000)

a+b+c+d+e+f

