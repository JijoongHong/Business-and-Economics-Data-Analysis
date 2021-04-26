mag = quakes$mag
boxplot(mag, main="distribution", xlab="eq", ylab="mag", col="red")

min(mag) #지진강도의 최솟값
max(mag) #지진강도의 최댓값
median(mag) #중앙값(제2사분위수)
Q = quantile(mag) #백분위수 0 / 25 / 50 / 75 / 100
Q
Q[3]-Q[1] #사분위수 범위
IQR(mag) #사분위수 범위

fence.upper = Q[3] + 1.5 * IQR(mag) #상위기준
fence.lower = Q[1] - 1.5 * IQR(mag) #하위기준

mag[mag > fence.upper] #극단값: 상위기준 초과 데이터
max(mag[mag<=fence.upper]) #극단값 제외 최댓값
mag[mag < fence.lower] #극단값: 하위기준 초과 데이터


