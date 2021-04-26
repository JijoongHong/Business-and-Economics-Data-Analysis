install.packages("ggmap")
library(ggmap)

register_google(key="AIzaSyBvv52spaVNjke4h7C7YJD06zPoes9JZNE")

map = get_googlemap(center = c(126.975684, 37.572752), maptype = "hybrid", #경도 lon #위도 lat
                    zoom=17, size=c(320,320)) #zoom : 작을수록 넓은 범위, 클수록 확대 

ggmap(map, extent="device") #여백없애기


