install.packages("foreign")
library(foreign)
library(ggplot2)
library(dplyr)

raw_welfare = read.spss(file = "/Users/jijoonghong/Desktop/수업/경데분/Koweps_hpc10_2015_beta1.sav", reencode='utf-8', to.data.frame = T)
welfare = raw_welfare
View(welfare)

#변수명 바꾸기
welfare = dplyr::rename(welfare, sex = h10_g3,
                 birth = h10_g4,
                 marriage = h10_g10,
                 religion = h10_g11,
                 income = p1002_8aq1,
                 jobcode = h10_eco9,
                 region_code = h10_reg7)

#사용할 것만 고르기
welfare = welfare %>% select("sex", "birth", "marriage", "religion", "income", "jobcode", "region_code")
head(welfare)

#################성별#################

table(welfare$sex)#결측치 확인
welfare$sex = ifelse(welfare$sex==9, NA, welfare$sex) #결측치 변경
table(is.na(welfare$sex)) #na 변경 확인

welfare$sex = ifelse(welfare$sex==1, "male", "female") #내용 변경
table(welfare$sex)

qplot(welfare$sex) #빈도그래프 


#################월급#################연속형이므로 써머리

summary(welfare$income)
qplot(welfare$income) + xlim(0,1000)
welfare$income = ifelse(welfare$income %in% c(0,9999), NA, welfare$income) #0과 9999해당하는 결측치 변경
table(is.na(welfare$income)) #na 변경 확인


#######성별과 월급간의 관계########
#남과 여의 평균 
sex_income = welfare %>% filter(!is.na(income)) %>% group_by(sex) %>% summarise(mean_income=mean(income))
sex_income
ggplot(data=sex_income, aes(x=sex, y=mean_income))+geom_col()
#detach(package:Rmisc)
#detach(package:plyr)

########연령과 임금 관계######## 
summary(welfare$birth)
table(is.na(welfare$birth))
#파생변수 : 나이 변화 
welfare$age = 2015 - welfare$birth + 1
summary(welfare$age)

age_income = welfare %>% filter(!is.na(income)) %>% group_by(age) %>% summarise(mean_income=mean(income))
ggplot(data=age_income, aes(x=sex, y=mean_income))+geom_line()

welfare = welfare %>% mutate(ageg = ifelse(age<30, "young", ifelse(age<60, "middle", "old"))) #구간나누기 
table(welfare$ageg)

######직업과 임금관계#######
table(welfare$jobcode)
install.packages("readxl")
library(readxl)
list_job = read_excel("/Users/jijoonghong/Desktop/수업/경데분/Koweps_Codebook.xlsx", col_names = T, sheet = 2)

welfare = left_join(welfare, list_job, id = "jobcode")
head(welfare)

job_income = welfare %>% filter(!is.na(income)&!is.na(job)) %>%  group_by(job) %>% summarise(mean_income=mean(income))
job_income

top10 = job_income %>% arrange(desc(mean_income)) %>% head(10)
ggplot(data=top10, aes(x=reorder(job, mean_income), y=mean_income))+geom_col()+coord_flip()

bottom10 = job_income %>% arrange(mean_income) %>% head(10)
ggplot(data=bottom10, aes(x=reorder(job, mean_income), y=mean_income))+geom_col()+coord_flip()


####직업과 성별차이#####
job_male = welfare %>%filter(!is.na(job)&sex=="male") %>% group_by(job) %>% summarise(n=n()) %>% arrange(desc(n)) %>% head(10)
job_male

job_female = welfare %>%filter(!is.na(job)&sex=="female") %>% group_by(job) %>% summarise(n=n()) %>% arrange(desc(n)) %>% head(10)
job_female

ggplot(data=job_male, aes(x=reorder(job, n), y=n))+geom_col()+coord_flip()
ggplot(data=job_female, aes(x=reorder(job, n), y=n))+geom_col()+coord_flip()

#####종교와 이혼######
welfare$religion = ifelse(welfare$religion == 1, "yes", "no")
qplot(welfare$religion)

welfare$group_marriage = ifelse(welfare$marriage == 1, "marriage", ifelse(welfare$marriage == 3, "divorce", NA))
welfare$marriage

table(welfare$marriage)
qplot(welfare$marriage)


religion_marriage = welfare %>% filter(!is.na(group_marriage)) %>% group_by(religion, group_marriage) %>%  summarise(n=n()) %>% 
  mutate(tot_group=sum(n)) %>% mutate(pct=round(n/tot_group*100, 1))

religion_marriage                                

divorce = religion_marriage %>% filter(group_marriage=="devorce") %>% select(religion, pct)
ggplot(data = divorce, aes(x=religion, y=pct)) + geom_col()

#######지역과 연령대#######
list_region = data.frame(region_code = c(1:7), region=c("서울", "수도권(인천/경기)", "부산/경남/울산", "대구/경북", "대전/충남", "강원/충북","광주/전남/전북/제주도"))
welfare = left_join(welfare, list_region, id = "region_code")
head(welfare)

region_ageg = welfare %>% group_by(region, ageg) %>% summarise(n=n()) %>% mutate(tot_group=sum(n)) %>% mutate(pct=round(n/tot_group*100, 2))
region_ageg

ggplot(data=region_ageg, aes(x=region, y=pct, fill=ageg))+geom_col()+coord_flip()

       