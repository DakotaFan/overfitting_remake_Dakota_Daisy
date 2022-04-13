adding_new_test <- function(p, data,  model){
  newdata <- data[order(data$hours),]
  y <- newdata$score
  x <- as.vector(newdata$hours)
  pred_y <- lapply(x, model_formula, model)
  degree <- length(model$coefficients) - 1
  
  mse <- sum((newdata$score - data.frame(pred_y))^2)/length(y)
  text <- paste(c("Degree =", degree, "MSE:", mse), collapse = " ") 
  p1 <- p + geom_line(aes(x = x,y = unlist(pred_y)),color = 'darkseagreen', size = 2)+
    annotate ("text",
              x = 10,
              y = 9,
              label = text,
              color ='darkseagreen',
              size = 4)
  
  return(p1)}



