women

height = women$height
weight = women$weight

plot(x=height, y=weight, xlim = c(0, max(height)), ylim=c(0,max(weight)),
     xlab = "height", ylab = "weight", 
     main ="changes of h & w",
     pch = 23, col = "blue", bg = "yellow", cex=0.5) # 기호 / 선 색 / 배경색 / 기호 크기

plot(height, weight,  xlab = "height", ylab = "weight", type = "p", lty=2, lwd=3) #선그래프 #line type #line width

