adding_new_train <- function(p, data,  model){
  y <- data$score
  x <- data$hours
  ix <- sort(data$hours,index.return=T)$ix
  pred_y <- predict(model, newdata = data) 
  
  degree <- length(model$coefficients) - 1
  mse <- mean(model$residuals^2)
  text <- paste(c("Degree =", degree, "MSE:", mse), collapse = " ") 
  p1 <- p + geom_line(aes(x =x[ix],y = pred_y[ix]),color = 'darkseagreen', size = 2)+
    annotate ("text",
              x = 10,
              y = 9,
              label = text,
              color ='darkseagreen',
              size = 4)
  
  return(p1)}



