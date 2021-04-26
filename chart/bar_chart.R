dept = c("t1", "t2", "t3", "t4")
sales01 = c(4,12,5,8)

bp = barplot(sales01, names.arg = dept, 
        main="sales in 1st quarter", col=rainbow(length(dept)), 
        xlab="dept", ylab="sales", ylim=c(0,15))
abline(h=mean(sales01), col="orange", lty=2) #선긋기 

text(x=bp, y=sales01, labels = sales01, pos=3)#pos : 위치 남쪽부터 반시계로 
