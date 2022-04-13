plot_test_model <- function(data, model){
  newdata <- data[order(data$hours),]
  y <- newdata$score
  x <- as.vector(newdata$hours)
  pred_y <- lapply(x, model_formula, model)
  
  mse <- sum((newdata$score - data.frame(pred_y))^2)/length(y)
  text <- paste(c("Linear MSE:", mse), collapse = " ") 
  p <- ggplot(newdata, aes(x = hours, y = score)) +
    geom_point() +
    geom_line(aes(x = x,y = unlist(pred_y)),color = 'cornflowerblue', size = 2)+
    ggtitle("Testing data") + 
    annotate ("text",
                                      x = 10,
                                      y = 7,
                                      label = text,
                                      color = 'cornflowerblue',
                                      size = 4) +
    theme(plot.title = element_text(hjust = 0.5))
    
  
  #p <- p + geom_smooth(method = "lm", formula = y ~ poly(x, degree), se = FALSE)
  return(p)}

