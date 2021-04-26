library(ggmap)
library(ggplot2)
library(dplyr)

setwd("/Users/jijoonghong/Downloads/")
register_google(key="AIzaSyBvv52spaVNjke4h7C7YJD06zPoes9JZNE")

df = read.csv("subStation.csv", fileEncoding = "euc-kr")
sub4 = df %>% filter(LINE_NUM == 4)

sub3 = df %>%
  filter(LINE_NUM == 3)

sub2 = df %>%
  filter(LINE_NUM == 2)

sub1 = df %>%
  filter(LINE_NUM == 1)

map = get_googlemap(center = "seoul", zoom = 11, maptype = "roadmap")
xmap = ggmap(map)

xmap = xmap + geom_point(data = sub4, aes(x = LON, y = LAT), size = 2, color = "skyblue")
xmap = xmap + geom_text(data = sub4, aes(x = LON, y = LAT,label = STATION_NM), size = 2, vjust = -1)

xmap = xmap + geom_point(data = sub3, aes(x = LON, y = LAT), size = 2, color = "orange")
xmap = xmap + geom_text(data = sub3, aes(x = LON, y = LAT,label = STATION_NM), size = 2, vjust = -1)

xmap = xmap + geom_point(data = sub2, aes(x = LON, y = LAT), size = 2, color = "green")
xmap = xmap + geom_text(data = sub2, aes(x = LON, y = LAT,label = STATION_NM), size = 2, vjust = -1)

xmap = xmap + geom_point(data = sub1, aes(x = LON, y = LAT), size = 2, color = "blue")
xmap = xmap + geom_text(data = sub1, aes(x = LON, y = LAT,label = STATION_NM), size = 2, vjust = -1)

xmap
