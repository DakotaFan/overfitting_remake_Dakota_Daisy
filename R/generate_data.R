#generates random deviates of the uniform distribution
#is written as runif(n, min = 0, max = 1) 
generate_data <- function(sample_size = 100){
  a <- runif(1, -1, 1)

  noise <- rnorm(sample_size, mean = 0, sd = 4)
  b <- seq(1, sample_size)
  indices <- sample(b, 8, replace=FALSE)
  outlier <- runif(8, -10, 30)
  df <- data.frame(hours = runif(sample_size, min = 1, max = 20), score=runif(sample_size, 30, 30))
  df$score = df$score + df$hours*a  + noise
  df[indices,]$score <- df[indices,]$score + outlier
  df_shuffled <- df[sample(nrow(df)),]
  return(df_shuffled)
  }
  





