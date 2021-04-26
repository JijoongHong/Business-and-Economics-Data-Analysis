#예제풀이 
df = read.csv("/Users/jijoonghong/Desktop/R/data_analysis/12-1.salary.csv", 
              na = "-", fileEncoding = "CP949", encoding = "UTF-8")

str(df) #factor가 있으면 stringAsFactors=T
table(is.na(df)) #결측치확인 

colnames(df)
colnames(df) = c("age", "salary", "special", "workingtime", "numofworker", "career", "sex")

#전국 평균 월급
attach(df)
Mean = mean(salary, na.rm = T)
Median = median(salary, na.rm = T)
Range = range(salary, na.rm = T)
Quant = quantile(salary, na.rm = T)

ds = list(평균월급 = Mean, 중앙값월급 = Median, 범위 = Range, 사분위 = Quant)

w= which(salary==min(salary, na.rm = T)) #월급이 가장 적은 행찾기
df[w,] #행보기


#그룹별 평균1 
tapply(salary, sex, mean, na.rm = T)#그룹별 평균
tapply(salary, sex, median, na.rm = T)#그룹별 중앙값
tapply(salary, sex, sd, na.rm = T)#그룹별 표준편차
tapply(salary, sex, min, na.rm = T)#그룹별 최솟값
tapply(salary, sex, max, na.rm = T)#그룹별 최댓값

temp = tapply(salary, sex, mean, na.rm = T)
barplot(temp)

library(reshape2)
retemp = melt(temp)
retemp

ggplot(retemp, aes(x=Var1, y=value, fill=Var1))+geom_bar(stat="identity") #fill 색채우기 / y축에 명시한 값을 기준으로 그래프 표현 / 각각 밸류를 사용

#그룹별 평균2 
temp = tapply(salary, career, mean, na.rm = T)
temp
retemp = melt(temp) # 매칭만 되어있고 행과열이 없으니 재구성,
retemp
ggplot(retemp, aes(x=Var1, y=value, fill=Var1))+geom_bar(stat="identity")
ggplot(retemp, aes(x=Var1, y=value, group=1))+geom_line()+coord_polar()+ylim(0, max((retemp$value))) 
#하나의group지정 #coord = 방사형 #보기 안좋으니 밸류값을 기준으로 조정 


#평균값 표준화 및 그래프로 확인 
scale = scale(salary)
mean(scale, na.rm = T) #평균 0에 가깝게
sd(scale, na.rm = T) #표준편차 1에 가깝게

df = cbind(df, scale=scale) #원본 데이터 / 이름/ 넣을 데이터
df


ggplot(df, aes(x=scale, y=age)) + geom_segment(aes(yend=age), xend=0) + geom_point(size=3, aes(colour=sex, shape=career))
#end 직선의 끝 지정 #점 찍기 
