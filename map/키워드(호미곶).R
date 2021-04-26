library(ggmap)

register_google(key="AIzaSyBvv52spaVNjke4h7C7YJD06zPoes9JZNE")

gc = geocode(enc2utf8("호미곶")) #지역명에 대한 경도 위도 생성
gc

lonlat = c(gc$lon, gc$lat)

map = get_googlemap(center=lonlat, marker = gc) #마커 : 핀 

ggmap(map)
