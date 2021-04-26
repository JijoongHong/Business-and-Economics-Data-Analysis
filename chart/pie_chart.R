install.packages("RColorBrewer")
library(RColorBrewer)
greens = brewer.pal(7, 'Greens') #색의 수, 팔레트 유형

city = c("seoul", "busan", "daegu", "incheon", "gwangju", "daejeon", "ulsan")
pm25 = c(18,21,21,17,8,11,25)

pct = round(pm25/sum(pm25)*100.0)
city_label = paste(city, ",", pct, "%", sep="")
pie(pm25, labels=city_label, col=greens, main="pm25", init.angle = 90, 
    clockwise = T)
