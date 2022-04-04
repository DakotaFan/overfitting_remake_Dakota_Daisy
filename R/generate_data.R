#generates random deviates of the uniform distribution
#is written as runif(n, min = 0, max = 1) 
generate_data <- function(sample_size = 100){
  a <- runif(1, -3, 3)
  noise <- rnorm(sample_size, mean = 0, sd = 7)
  df <- data.frame(hours = runif(sample_size, 1, 15), score=runif(sample_size, 30, 30))
  df$score = df$score + df$hours*a + noise
  df_shuffled <- df[sample(nrow(df)),]
  return(df_shuffled)
  }
  





