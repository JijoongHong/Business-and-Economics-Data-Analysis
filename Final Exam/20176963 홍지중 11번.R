iteration = 10000
sum = 0

for (i in iteration){
  sum = 0
  for(j in 1:i){
    dice = sample(1:6, 1, replace = T)
    sum = sum + dice    
  }
  prob_expt = c(i, sum / i)
  print(prob_expt)
}

