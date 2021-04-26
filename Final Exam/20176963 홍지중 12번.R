df = read.csv("/Users/jijoonghong/Desktop/수업/경데분/kbo2015.csv", fileEncoding = "CP949", encoding = "UTF-8")
df1 = df %>% select(AB, H)
df1 = ifelse(df1$AB==0, NA, df1$AB)
df1 = ifelse(df1$H==0, NA, df1$H)
