#회귀선 찾기
x = c(1.0, 2.2, 3.5, 4.0, 5.2, 6.4, 7.1, 8.3, 9.2, 10.0)
y = c(4.1, 4.5, 6.2, 7.5, 8.5, 9.0, 11.0, 11.5, 12.5, 14.0)

plot(x, y, xlim = c(0, 10), ylim = c(0, 15))

 
a = seq(-10, 10, by = 1) #y절편
b = seq(-15, 15, by = 1) #x계수(기울기)

cost.mtx = matrix(NA, nrow = length(b), ncol = length(a)) #비용함수(거리차이) 행렬 초기화

cost.mtx
#기울기 계산하고 절편 찾기 
for(i in 1:length(b)){ 
  for (j in 1:length(a)){
    err.sum = 0 #추정치와 실제값의 차이 
    for (k in 1:length(x)) #x값 넣기
    {
      y_hat = b[i]*x[k] + a[j] #추정치 = k번째 x값에 계수를 곱해주고, 절편 추가 
      err = (y_hat - y[k])^2 #편차의 절대값을 보장하기 위해 제곱, 제곱항의 최솟값 찾기 
      err.sum = err.sum + err #에러값 누적 
    }
    cost = err.sum / length(x)
    cost.mtx[i,j] = cost
  }
}


cost.mtx[1:5, 1:5]
#기울기와 y절편 구하기
range(cost.mtx) 
#해당 값에 해당하는 것 찾아내기 
idx = which(cost.mtx == min(cost.mtx), arr.ind = TRUE) #인덱스 반환

idx #row - 기울기 col- 절편

idx.bmin = idx[1,1] #row 넣기
idx.amin = idx[1,2] #col 넣기 

bmin = b[idx.bmin]
amin = a[idx.amin]

#Y = x + 3

abline(a=amin, b=bmin, lty=1, col = "red")

###############a(절편)에 따른 비용함수
plot(b, cost.mtx[, idx.amin], type = 'o', lwd =3)
for (j in 1:length(a)){
  lines(b, cost.mtx[,j], col=j)
  Sys.sleep(0.5) #시간간격 
}

#######b(기울기)의 변화에 따른 비용함수 
plot.new()
plot(a, cost.mtx[idx.bmin, ], type = 'o', lwd =3)
for (i in 1:length(b)){
  lines(a, cost.mtx[i,], col=i)
  Sys.sleep(0.5)
}

###############3차원 그래프
library("rgl")
persp3d(b, a, cost.mtx, col="yellow")


#주사위 2개 동시에 던질 때 같은 수가 나올 확률 
prob_real = round(1/6, 2)# 6/36씩 소숫점 두자리까지 

iteration = c(100, 1000, 10000)
prob_expt = NULL #실험을 통해 얻을 수 있는 확률 

for (i in iteration){
  sum = 0
  for (j in 1:i){
    dice = sample(1:6, 2, replace = T)
    
    if (dice[1] == dice[2]){
      sum = sum + 1
    }
  }
  prob_expt = c(i, sum / i)
  print(prob_expt)
}


#시뮬레이션과 통계적 방법의 회귀선 비교
#회귀선 찾기
x = c(1.0, 2.2, 3.5, 4.0, 5.2, 6.4, 7.1, 8.3, 9.2, 10.0)
y = c(4.1, 4.5, 6.2, 7.5, 8.5, 9.0, 11.0, 11.5, 12.5, 14.0)

plot(x, y, xlim = c(0, 10), ylim = c(0, 15))

b = seq(0.5, 1.5, by = 0.001) #y절편
a = seq(2, 3, by = 0.001) #x계수(기울기)

cost.mtx = matrix(NA, nrow = length(b), ncol=length(a))

for(i in 1:length(b)){
  for (j in 1:length(a)){
    err.sum = 0
    for (k in 1:length(x))
    {
      y_hat = b[i]*x[k] + a[j] 
      err = (y_hat - y[k])^2
      err.sum = err.sum + err
    }
    cost = err.sum / length(x)
    cost.mtx[i,j] = cost
  }

}

cost.mtx[1:5, 1:5]

range(cost.mtx)

idx = which(cost.mtx == min(cost.mtx), arr.ind = TRUE) #인덱스 반환

idx #row - 기울기 col- 절편

idx.bmin = idx[1,1]
idx.amin = idx[1,2]

bmin = b[idx.bmin]
amin = a[idx.amin]

#Y = x + 3

abline(a=amin, b=bmin, lty=1, col = "red")

lm(y~x)
amin
bmin
