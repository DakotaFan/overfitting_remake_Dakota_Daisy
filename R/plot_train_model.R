plot_train_model <- function(data, model){
  y <- data$score
  x <- data$hours
  ix <- sort(data$hours,index.return=T)$ix
  pred_y <- predict(model, newdata = data) 
  mse <- mean(model$residuals^2)
  #mse <- mean((x - pred_y)^2)
  text <- paste(c("Linear MSE:", mse), collapse = " ") 
  p <- ggplot(data, aes(x = hours, y = score)) +
    geom_point() +
    #+ geom_smooth(method="loess")
    geom_line(aes(x =x[ix],y = pred_y[ix]), color = 'cornflowerblue', size = 2) +
    ggtitle("Training data") +  annotate ("text",
                                           x = 10,
                                           y = 7,
                                           label = text,
                                          color = 'cornflowerblue',
                                          size = 4)+
    theme(plot.title = element_text(hjust = 0.5))
    
    
    
  #p <- p + geom_smooth(method = "lm", formula = y ~ poly(x, degree), se = FALSE)
  return(p)}





