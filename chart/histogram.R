quakes

mag = quakes$mag

hist(mag, main = "distribution of magnitude of earth quake", 
     xlab = "magnitude", ylab = "case",
     col = rainbow(10), breaks=seq(4, 6.5, by=0.5))#구간 설정


hist(mag, main = "distribution of magnitude of earth quake", 
     xlab = "magnitude", ylab = "density",
     col = rainbow(10), freq = FALSE) #freq : 확률 밀도 

#확률밀도곡선
lines(density(mag), lwd=2) #lwd : 선의 너비
