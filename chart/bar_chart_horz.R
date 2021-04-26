dept = c("t1", "t2", "t3", "t4")
sales01 = c(4,12,5,8)

barplot(sales01, names.arg = dept, main = "sales in 1st quarter",
        col = rainbow(length(dept)), ylab = "dept", xlab = "sales",
        xlim = c(0,15), horiz = TRUE)

