#이상치 찾기 및 제거 

df = read.csv("/Users/jijoonghong/Desktop/R/data_analysis/12-1.cancer.csv", na="기록없음",
             fileEncoding = "CP949", encoding = "UTF-8")

attach(df)
str(df)
table(is.na(df))

mean(age)
summary(age)
boxplot(age)
grid()#격자 넣기

#이상치 찾기 및 제거
iqr = IQR(age,na.rm = T)
qnt = quantile(age,na.rm = T)
#상한 : q3(75%) + 1.5*IQR
#하한 : q1(25%) - 1.5*IQR

lb = qnt[[2]] - 1.5*iqr
ub = qnt[[4]] + 1.5*iqr

outlier = subset(df, age<lb | age>ub) #이상치 데이터 추출 
outlier

