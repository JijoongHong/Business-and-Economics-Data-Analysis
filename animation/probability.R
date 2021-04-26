library(animation)

plot.new()
count = c(0, 0, 0)

for (n in 1:500){
  coin = sample(c(0,1), 2, replace = T) #0과 1 중에서 2개 추출, replace : 참이면 복원 추출, 뽑은거 다시 집어넣음 
  
  index = sum(coin) + 1
  count[index] = count[index] + 1
  
  probability = count / n 
  
  title = paste("repitition", n, "/500") #문자로 변환 후에 벡터로 반환 
  
  barplot(probability, names.arg = c(0,1,2), 
          xlab = "front", ylab = "probability",
          col = rainbow(3), main = title)
  Sys.sleep(0.05)
}