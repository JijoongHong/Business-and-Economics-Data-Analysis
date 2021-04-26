library(ggmap)
library(ggplot2)

setwd("/Users/jijoonghong/Downloads/")
register_google(key="AIzaSyBvv52spaVNjke4h7C7YJD06zPoes9JZNE")

df = read.csv("university-1.csv", fileEncoding = "euc-kr")
df
map = get_googlemap(center="seoul", zoom=11, maptype = "hybrid")
xmap = ggmap(map)

xmap = xmap + geom_point(data = df, aes(x=lon, y=lat, color = factor(학교명))
                         , size = 3)

xmap = xmap + geom_text(data=df, aes(x=lon, y=lat, label = 학교명), size=3)

xmap = xmap + scale_color_discrete(name="학교명")

xmap
