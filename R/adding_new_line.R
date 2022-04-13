adding_new_train <- function(p, data, model){
  y <- data$score
  x <- data$hours
  ix <- sort(data$hours,index.return=T)$ix
  pred_y <- predict(model, newdata = data) 
  p1 <- p + geom_line(aes(x =x[ix],y = pred_y[ix]))
return(p1)}
