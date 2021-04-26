library(ggplot2)
library(ggmap)

register_google(key="AIzaSyBvv52spaVNjke4h7C7YJD06zPoes9JZNE")

names = c("도담삼봉/석문", "구담/옥순봉", "사인암", "하선암", "중선암", "상선암")

addr = c("충청북도 단양군 매포읍 삼봉로 644-33", "충청북도 단양군 단성면 월악로 3827",
         "충청북도 단양군 대강면 사인암2길 42", "충청북도 단양군 단성면 선암계곡로 1337",
         "충청북도 단양군 단성면 선암계곡로 868-2", "충청북도 단양군 단성면 선암계곡로 790")

gc = geocode(enc2utf8(addr))

df = data.frame(name = names, lon=gc$lon, lat=gc$lat)

cen = c((max(df$lon)+min(df$lon))/2, (max(df$lat)+min(df$lat))/2)

map = get_googlemap(center = cen, maptype = "hybrid", 
                    zoom = 12, marker = gc) #지도 정보 생성

gmap = ggmap(map) #지도 출력 

gmap + geom_text(data = df, aes(x=lon, y=lat), size = 5, label = df$name) #이름 출력 
