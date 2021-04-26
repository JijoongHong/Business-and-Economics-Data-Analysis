library(animation)

ani.options(interval = 1)

while(TRUE){
  y = runif(5, 0, 1) #0, 1 사이 5개 추출
  
  barplot(y, ylim = c(0,1), col=rainbow(5))
  
  ani.pause #인터벌 만큼 대기
}

