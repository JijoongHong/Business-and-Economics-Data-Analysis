library(dplyr)
library(stringr)
library(pdftools)
library(wordcloud)
library(RColorBrewer)
library(tm)
library(ggplot2)

#------------- 전처리 ------------#

setwd("/Users/JijjongHong/R/NLP/") 
#경로 지정 

three_kingdoms = pdf_text("Three_Kingdoms.pdf") 
#파일 불러오기 

tk_string = str_c(three_kingdoms, collapse = " ")
#스페이스를 구분자로 하여 모든 문단을 결합

str_locate_all(tolower(tk_string), "see also")
tk_trunc = str_trunc(tk_string, 57000, side = "right")
#see also 이하의 notes, references 등 불필요한 섹션 제거 

tk_nospace = str_replace_all(tk_trunc, "[[:space:]]{1,}"," ")
#스페이스가 한 개 이상인 모든 항목을 스페이스 하나로 변경하여 공백을 없앰

tk_eng = str_replace_all(tk_nospace, "[^[:ascii:]]+"," " )
#아스키 코드로 시작하는 영어 이외의 단어를 스페이스바로 변경 #^=시작문자 

str_extract_all(tk_eng, "[^[:ascii:]]{1,}")
#삭제 확인

tk_eng = tolower(tk_eng)
#영어를 모두 소문자로 변경 

tk_processed = str_replace_all(tk_eng, "\\[[:digit:]+\\]|\\([:digit:]+\\)", " ") %>% #주석 등을 제거
  str_replace_all("[:punct:]+", "") %>% #마침표 등 제거 
  str_replace_all("[:digit:]+", "") %>% #숫자 제거 
  str_replace_all("[:space:]{1,}", " ") %>% #전처리 과정에서 생성된 공백 제거
  str_split(" ") %>% #빈칸을 기준으로 분할 
  unlist #리스트를 벡터로 변환

tk_stop = tk_processed[!tk_processed %in% stopwords("SMART")]
#불용어 사전 내의 내용을 삭제

tk = sort(table(tk_stop), decreasing = TRUE)
#내림차순으로 빈도표 제작 


#------------- 이상 전처리 / 이하 빈도표 ------------#

tk_head = tk %>% head(20)
#상위 20개 항목 추출

df_word = as.data.frame(tk_head)
#데이터 프레임으로 변경 

df_word = rename(df_word, word = tk_stop, freq = Freq) 
#변수 이름 변경

df_word
#빈도표 출력

#------------- 이상 빈도표 / 이하 빈도 그래프 ------------#

order = arrange(df_word, freq)$word
#빈도를 내림 차순으로 지정 #빈도수에 따라서 단어를 정렬 

ggplot(data = df_word, aes(x = word, y=freq)) + ylim(0, 150) + 
  geom_col() + coord_flip() + scale_x_discrete(limit = order) + #항목 순서 
  geom_text(aes(label = freq), hjust = -0.3)
#그래프 작성 (x축을 단어, y축을 0~150 범위의 빈도로 설정하여, 내림차순인 가로 그래프를 그린다)
#hjust 겹치지 않게 글자 넣기 


#------------- 이상 빈도 그래프 / 이하 워드 클라우드 ------------#

pal = brewer.pal(10, "Spectral")
#색상 지정

set.seed(405)
#형태 고정

wordcloud(word=names(tk), #단어 #객체의 이름을 반환 
          freq=tk,#빈도
          scale=c(4, 0.1), #크기
          min_freq = 2, #최소 단어 빈도
          rot.per=0.2, #회전 비율
          random.order = F, #빈도수 높은 단어를 중앙에 배치
          random.color= T, #무작위 색상 적용
          colors=pal) #색상
#2회 이상인 단어에 대한 워드 클라우드 생성 

