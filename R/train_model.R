train_model <- function(data, degree){
  y <- data$score
  x <- data$hours
  model <-  lm(y ~ poly(x, degree, raw = TRUE), data = data)
  return(model)
}

