library(ggmap)
library(ggplot2)

setwd("/Users/jijoonghong/Downloads/")
register_google(key="AIzaSyBvv52spaVNjke4h7C7YJD06zPoes9JZNE")

df = read.csv("seoulElec-1.csv", fileEncoding = "euc-kr")

map = get_googlemap(center="seoul", zoom=11, maptype = "roadmap")
xmap = ggmap(map)

xmap = xmap + geom_point(data = df, aes(x=LON, y=LAT, size = X2008Y, color='Red'))
xmap = xmap + geom_text(data = df, aes(x=LON, y=LAT, label=NAME), size=2)

xmap

