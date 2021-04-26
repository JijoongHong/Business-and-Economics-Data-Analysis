#데이터 수정
library("ggplot2")
library("dplyr")
mpg
dt = mpg
dt = rename(dt, city = cty, highway = hwy)
dt

#파생변수 (mpg 통합 연비 변수)
dt = mpg
dt$total = (mpg$cty + mpg$hwy) / 2
dt$total
dt

summary(dt$total)
hist(dt$total)

dt$test = ifelse(dt$total >= 20, "pass", "fail")
dt$test

#시각화 
table(dt$test)
ggplot(dt, aes(test)) + geom_bar()
qplot(dt$test)

x = data.frame(table(dt$test))$Var1
y = data.frame(table(dt$test))$Freq
x = as.character(x)
barplot(y, names.arg = x)

#조건문 중첩 파생변수
dt$grade = ifelse(dt$total >= 30, "A", ifelse(dt$total >= 20, "B", "C"))
dt$grade
table(dt$grade)
ggplot(dt, aes(grade)) + geom_bar()
qplot(dt$grade)

x = data.frame(table(dt$grade))$Var1
y = data.frame(table(dt$grade))$Freq
x = as.character(x)
barplot(y, names.arg = x)

#데이터 전처리
dt1 = dt %>% filter(displ<=4)
dt2 = dt %>% filter(displ>=5)
mean(dt1$highway)
mean(dt2$highway)

#########
dt_audi = dt%>%filter(manufacturer =="audi")
dt_toyota = dt%>%filter(manufacturer =="toyota")
mean(dt_audi$city)
mean(dt_toyota$city)

dt0 = dt %>% group_by(manufacturer) %>% summarise(mean_cty = mean(city))
dt0

dt0 = dt %>% group_by(manufacturer) %>% summarise(mean_hwy = mean(highway))

dt3 = dt %>% filter(manufacturer %in% c("chevrolet", "ford", "honda"))
mean(dt3$highway)

########일부 변수만 추출
dt4 = dt %>% select(class, city)
dt4

dt_5 = dt %>% group_by(class) %>% summarise(mean_cty = mean(city))

dt_suv = dt %>% filter(class == "suv")
dt_compact = dt %>% filter(class == "compact")
mean(dt_suv$city)
mean(dt_compact$city)

####### 정렬
dt5 = dt%>% filter(manufacturer=="audi") %>%
  arrange(desc(highway))%>%head(5)
dt5


###### 변수 추가
dt6 = dt %>% mutate(total = city + highway)
dt6 = dt6 %>% mutate(avg = total/2)
dt6 %>% arrange(desc(avg))%>%head(3)

dt %>% mutate(total = city + highway, avg=total/2) %>%
  arrange(desc(avg))%>%head(3)

#####집단 별 요약
dt %>% group_by(class) %>% summarise(mean_cty = mean(city)) %>% arrange(desc(mean_cty))

dt %>% group_by(manufacturer) %>% summarise(mean_hwy = mean(highway)) %>% arrange(desc(mean_hwy))%>%head(3)

dt %>% filter(class == "compact") %>% group_by(manufacturer) %>%
  summarise(count = n()) %>% arrange(desc(count))

#### 데이터 합치기 
fuel = data.frame(fl=c("c", "d", "e", "p", "r"),
                  price_fl=c(2.35, 2.38, 2.11, 2.76, 2.22))
table(dt$fl)
fuel

dt7 = left_join(dt, fuel, by="fl")
dt7 %>% select(model, fl, price_fl) %>% head(5)

#### 11-3 데이터 정제 - 누락 데이터(결측치), 이상치 제거 
dt = data.frame(sex=c("M", "F", NA, "M", "F"), score = c(5, 4, 3, 4, NA))
dt
is.na(dt)                
table(is.na(dt$sex))

dt %>% filter(is.na(score))
dt1 = dt %>% filter(!is.na(score) & !is.na(sex))

dt3 = na.omit(dt)

mean(dt$score, na.rm = T)
sum(dt$score, na.rm = T)
dt %>% summarise(mean_score = mean(score, na.rm = T))

###결측치 평균 대체
dt1 = dt
mean(dt$score, na.rm = T)
dt1$score = ifelse(is.na(dt1$score), mean(dt$score, na.rm = T), dt1$score) #평균값
dt1$score = ifelse(is.na(dt1$score), median(dt$score, na.rm = T), dt1$score) #중앙값

### 이상치 
dt = data.frame(sex = c(1,2,1,3,2,1), score= c(5,4,3,4,2,6))
table(dt$sex)
table(dt$score)

dt$sex = ifelse(dt$sex == 3, NA, dt$sex) #결측치로 변경 
dt$score = ifelse(dt$score > 5, NA, dt$score)
dt %>% filter(!is.na(sex) & !is.na(score)) %>% group_by(sex) %>% 
  summarise(mean_score=mean(score))

### 극단값
dt = mpg
boxplot(dt$hwy)
boxplot(dt$hwy)$stats

dt$hwy = ifelse(dt$hwy<12 | dt$hwy>37, NA, dt$hwy)
table(is.na(dt$hwy))
dt %>% group_by(drv) %>% summarise(mean_hwy = mean(hwy, na.rm=T))

#IQR(2,4)
dt = mpg
boxplot(dt$hwy)
boxplot(dt$hwy)$stats
IQR(dt$hwy)

q1 = boxplot(dt$hwy)$stats[2]
q3 = boxplot(dt$hwy)$stats[4]

lb = q1 - 1.5 *IQR(dt$hwy)
ub = q3 + 1.5*IQR(dt$hwy)

dt$hwy = ifelse(dt$hwy<lb | dt$hwy>ub, NA, dt$hwy)
table(is.na(dt$hwy))
dt %>% group_by(drv) %>% summarise(mean_hwy = mean(hwy, na.rm = T))
      