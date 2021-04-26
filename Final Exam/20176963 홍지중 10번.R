library(MASS)

dt = cats
plot(x=dt$Bwt, y=dt$Hwt, xlab = "몸무게(kg)", ylab = "심장의 무게(g)")
rl = lm(data = dt, Hwt ~ Bwt)
abline(rl, col = "red")
