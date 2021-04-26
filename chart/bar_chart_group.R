dept = c("t1", "t2", "t3", "t4")
sales01 = c(4,12,5,8)
sales02 = c(12,8,8,4)
sales  = rbind(sales01, sales02)

legend_lbl = c("Q1", "Q2")

barplot(sales, names.arg = dept, main = "sales in 1st, 2nd quarter",
        col = c("green", "orange"), ylab = "dept", xlab = "sales",
        xlim = c(0,17), ylim = c(0,16), legend.text = legend_lbl, 
        args.legend = list(x = "top", ncol=2), beside = TRUE)

#beside : 나란히 배치


