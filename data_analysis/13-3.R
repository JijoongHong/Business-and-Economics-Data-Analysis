df = mtcars

#####단일 회귀분석

plot(df$hp, df$mpg)#미리 확인
cor(df$hp, df$mpg)#미리 확인

rl = lm(data = df, mpg ~ hp) #종속변수(mpg) ~ 독립변수(hp)
#intercept : 절편 hp : 독립변수에 대한 계수 
#y = 30.09886 - 0.06823x

summary(rl)
abline(rl, col = "red")


#####다중 회귀분석

plot(df$cyl, df$mpg)
plot(df$wt, df$mpg)

rl = lm(data = df, mpg ~ cyl + wt) #종속변수(mpg) ~ 독립변수(cyl + wt)
#y = 39.686 -1.508x1 -3.191x2

rl
summary(rl) #검증결과 #p값 매우 작으므로 통계적으로 유의미하다 / rsquared 선이 83% 정도 유의미


#####추정치(예측치) 구하기
rl = lm(data=df, mpg~wt) #차체 중량(독립)에 따른 연비 결정(종속)
plot(df$wt, df$mpg)
summary(rl) #p값 매우 작고, 결정계수도 75이므로 통계적으로 유의미 

est = predict(rl) #연비예측
head(mtcars) #원본대조 

#데이터프레임에 넣어서 비교 
df = data.frame(mpg = df$mpg, fitted_mpg = est)
plot(df$mpg, df$fitted_mpg)#시각화

#따로 출력해서 합치기 
plot(df$mpg) 
par(new=T) #겹치기
plot(df$fitted_mpg, col = "red")

par(mfrow=c(2,1)) #2행 1열
plot(df$mpg)
plot(df$fitted_mpg, col = "red") #동시에

par(mfrow=c(2,2)) #2행 2열
plot(df$mpg)
plot(df$fitted_mpg, col = "red") 

par(mfcol=c(2,2))#2열 2행
plot(df$mpg)
plot(df$fitted_mpg, col = "red") 

par(mfrow = c(1,1))#초기화 

#값에 대한 정렬 
df = arrange(df, df$mpg) #mpg순으로 정렬
head(df$mpg)
plot(df$mpg)
par(new=T)
plot(df$fitted_mpg, col = "red")

df = arrange(df, df$fitted_mpg) #추정mpg순으로 정렬 
head(df$fitted_mpg)
plot(df$fitted_mpg)
par(new=T)
plot(df$mpg, col = "red")
##이상 비교하기

#추정치
df = mtcars
x = data.frame(wt = 6) #단일값넣으면 연산이 안돼서 형식 맞추기
predict(lm(data = df, mpg ~ wt), newdata=x)

