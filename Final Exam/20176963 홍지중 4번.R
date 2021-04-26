cal <- function(x){
  y = 1 - 2*x - 4*x^2 + x^3
  return (y)
}

plot(cal, xlim=c(-10, 10), ylab="f(x)")
par(new=T)
abline(a=0, b=0, lty=2, col = "red")
