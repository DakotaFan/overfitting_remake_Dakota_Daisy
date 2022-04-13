model_formula<- function(x, model){
  if (length(model$coefficients) == 2){
    y_pred <- model$coefficients[1] + model$coefficients[2]* x }
  else if (length(model$coefficients) == 3){
    y_pred <- model$coefficients[1] + model$coefficients[2]* x + 
      model$coefficients[3]* x^2 }
  else if (length(model$coefficients) == 4){
    y_pred <- model$coefficients[1] + model$coefficients[2]* x + 
      model$coefficients[3]* x^2 +  model$coefficients[4]* x^3
  }
  else if (length(model$coefficients) == 5){
    y_pred <- model$coefficients[1] + model$coefficients[2]* x + 
      model$coefficients[3]* x^2 +  model$coefficients[4]* x^3+
      model$coefficients[5]* x^4
  }else if (length(model$coefficients) == 6){
    y_pred <- model$coefficients[1] + model$coefficients[2]* x + 
      model$coefficients[3]* x^2 +  model$coefficients[4]* x^3+
      model$coefficients[5]* x^4 + model$coefficients[6]* x^5
  }else if (length(model$coefficients) == 7){
    y_pred <- model$coefficients[1] + model$coefficients[2]* x + 
      model$coefficients[3]* x^2 +  model$coefficients[4]* x^3+
      model$coefficients[5]* x^4 + model$coefficients[6]* x^5 +
      model$coefficients[7]* x^6}   
  else if (length(model$coefficients) == 8){
    y_pred <- model$coefficients[1] + model$coefficients[2]* x + 
      model$coefficients[3]* x^2 +  model$coefficients[4]* x^3+
      model$coefficients[5]* x^4 + model$coefficients[6]* x^5 +
      model$coefficients[7]* x^6 + model$coefficients[8]* x^7}
  else if (length(model$coefficients) == 9){
    y_pred <- model$coefficients[1] + model$coefficients[2]* x + 
      model$coefficients[3]* x^2 +  model$coefficients[4]* x^3+
      model$coefficients[5]* x^4 + model$coefficients[6]* x^5 +
      model$coefficients[7]* x^6 + model$coefficients[8]* x^7 +model$coefficients[9]* x^8 }



  return(y_pred)}