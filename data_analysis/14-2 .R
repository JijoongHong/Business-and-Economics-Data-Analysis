#동전 던지기

iteration = 5000

plot(0, 0, xlab = "repitition", ylab = "front",
     xlim=c(0, iteration), ylim=c(0,1))

abline(a=0.5, b = 0, col = "red") #a y절편 / b기울기

sum = 0

for (x in 1:iteration){
  
  coin = sample(c("front", "rear"), 1, replace = T)
  
  if (coin == "front")
    sum = sum + 1
  
  prob = sum / x 
  
  points(x, prob)

}


#원주율 구하기 (몬테카를로)

library("plotrix")
plot.new()
iteration = 1000
n_circle = 0

plot(0, 0, xlim = c(-1,1), ylim = c(-1,1))

draw.circle(0,0,1)

for (i in 1:iteration){
  
  x = runif(1, min = -1, max = 1)
  y = runif(1, min = -1, max = 1)
  
  dist = sqrt((x-0)^2 + (y-0)^2)
  
  if (dist <= 1){
    n_circle = n_circle + 1 
    points(x,y,col="blue")
  }else points(x,y,col="red")
  
}

pi = 4 * n_circle / iteration
pi



