dept = c("t1", "t2", "t3", "t4")
sales01 = c(4,12,5,8)
sales02 = c(12,8,8,4)
sales  = rbind(sales01, sales02)

sales
legend_lbl = c("Q1", "Q2")

barplot(sales, names.arg = dept, main = "sales in 1st, 2nd quarter",
        col = c("green", "orange"), ylab = "dept", xlab = "sales",
        xlim = c(0,7), ylim = c(0,30), legend.text = legend_lbl, 
        args.legend = list(x = "top", ncol=2)) #범례 위치, 열 개수

