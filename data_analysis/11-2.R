setwd("Users/JijoongHong/Desktop/R/data_analysis")
df = read.csv("/Users/jijoonghong/Desktop/R/data_analysis/12-1.studentslist.csv", 
              na = "-", fileEncoding = "CP949", encoding = "UTF-8")

attach(df) #변수지정

#평균
mean(height, na.rm = T)

#중앙값
median(height, na.rm = T)
max(height, na.rm = T) #최댓값
min(height, na.rm = T) 
range(height, na.rm = T)
quantile(height, na.rm = T)
IQR(height, na.rm = T)
summary(height, na.rm = T)
boxplot(height)

#상관계수 두 변수의 관계를 숫자로 표현
cor(height, weight)
cor.test(height, weight)
cor(df[,c(3,7,8)], use="complete.obs") 

df2 = df
df2[2,7] = NA
df2[4,8] = NA
df2
detach(df)
attach(df2)
cor(height, weight, use="complete.obs")#행날리기
cor(height, weight, use="pairwise.complete.obs")#변수만 날리기
cor(height, weight, use="everything")#결측치 포함
cor(height, weight, use="all.obs")#결측치 있으면 계산 안함

#분산
var(height, na.rm = T)

var(height, weight, na.rm = T) #공분산
cov(height, weight, use="complete.obs") 
var(df2[,c(3,7,8)], na.rm = T)
var(df2[,c(3,7,8)],use="complete.obs") 

#표준편차
sd(height, na.rm = T)

#표준화 
scale(height)
(height-mean(height))/sd(height)

#변동계수 
sd(height)/mean(height) #평균을 기준으로 4%변동
sd(weight)/mean(weight) #평균을 기준으로 19%변동
stripchart(height)
stripchart(weight)



