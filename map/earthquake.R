#install.packages("openxlsx")
library(openxlsx)

register_google(key="AIzaSyBvv52spaVNjke4h7C7YJD06zPoes9JZNE")

df = read.xlsx(file.choose(), sheet=1, startRow=4)

df[,5] = gsub("N","",df[,5]) #n제거

df[,6] = gsub("E","",df[,6]) #e제거 

df2 = data.frame(lon=df[,6], lat=df[,5], mag=df[,3]) 
df2
df2[,1] = as.numeric(as.character(df2[,1])) #factor를 숫자형으로 
df2[,2] = as.numeric(as.character(df2[,2]))
df2[,3] = as.numeric(as.character(df2[,3]))

cen = c((max(df2$lon) + min(df2$lon))/2,
        (max(df2$lat) + min(df2$lat))/2)

map = get_googlemap(center=cen, zoom = 6)
gmap = ggmap(map)
gmap + geom_point(data=df2, aes(x=lon, y=lat),
                  color="red", size = df2$mag, alpha=0.5)
