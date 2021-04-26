x = sleep[1:10, c(3,1)] #열개를 3열 1열 순으로 가져온다
x

mean(x[,2])#점추정

library("Rmisc")
c1 = CI(x[,2], ci=0.99)[c(3,1)] #신뢰구간, 디폴트 95
c2 = CI(x[,2], ci=0.99)[c(3,1)] #신뢰구간, 디폴트 95
rbind(c1,c2)

#상관계수 1 또는 -1에 관련될수록 상관관계가 있고, 0에 가까울수록 없음
dt = mtcars
cor(dt$mpg, dt$wt) #연비와 중량은 음의 관계ggplot(data=job_male, aes(x=reorder(job, n), y=n))+geom_col()+coord_flip()
cor.test(dt$mpg, dt$wt) #상관계수 검정, 신뢰구간

cov(dt$mpg, dt$wt)#공분산

library(corrplot)
cor(dt)
corrplot(cor(dt))#시각화


############가설 검정 예제1 - 컴팩트와 suv 도시연비에 대한 t검정
#단일 t검정 두 집단의 평균차이
library("ggplot2") #mpg 여기있음
library("dplyr")
df = mpg

df = df %>% select(class, cty) %>% filter(class %in% c("compact", "suv"))  
table(df)

dfc = df %>% filter(class=="compact")
dfs = df %>% filter(class=="suv")
hist(dfc$cty)
hist(dfs$cty) #정규분포 아님
table(df$class) #개수 : 30개 이상

shapiro.test(dfc$cty) 
shapiro.test(dfs$cty)
#정규성 검정 / 귀무가설 : 정규분포 따름 / 대립가설 : 정규분포 안따름
#p값이 0.05이상이면 귀무가설, 즉 정규분포이고 이하면 대립가설, 즉 정규분포가 아니다 

var.test(data = df, cty ~ class) 
#공분산 검정 / 귀무 : 두 변수의 분산이 같다 / 대립 : 분산이 다르다
# 0.014로 기각 데이터 정제로 정규성을 확보해야함

t.test(data = df, cty ~class, var.equal = T)
#귀무가설 : 두 집단의 평균이 같다. / 대립가설 : 두 집단의 평균이 다르다
# 0.05보다 작으므로 suv와 compact의 통계적 유의미한 차이

t.test(data = df, cty ~class, var.equal = T, conf.level = 0.99)
#신뢰수준 조절

#####가설 검정 예제2 - 일반 및 고급 휘발유의 도시연비에 대한 t검정
df = mpg
df = df %>% select(fl, cty) %>% filter(fl %in% c("r", "p"))

#개수
table(df$fl)

#정규성
dfr = df %>% filter(fl == 'r')
dfp = df %>% filter(fl == 'p')

hist(dfr$cty)
hist(dfp$cty)

shapiro.test(dfr$cty) #정규분포아님
shapiro.test(dfp$cty) #정규분포아님

#분산
var.test(data = df, cty ~ fl) #분산도 다름

# 평균 
t.test(data = df, cty ~ fl, var.equal = T) #분산이 같다고 추정하고, 평균이 통계학적으로 같다  


############상관 분석##############
df = mpg
cor.test(df$cty, df$hwy) #귀무가설 : 관계가 없다. #대립가설 : 관계가 있다 -> 매우 작으므로 관계 있음
cor(df$cty, df$hwy)



