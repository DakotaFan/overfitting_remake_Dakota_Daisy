library(shiny)
library(ggplot2)

## Function that Make linear regression formula
make_lm_formula = function(x,y, power){
  if (power>1){
    
    return(paste0(y, '~', 'poly(',x,',', 'degree=',power,')'))
  }else{
    return(paste0(y, '~', x))
  }
  
}

MSE = function(y_true, y_predict){
  return ((1/length(y_true))*sum((y_true - y_predict)**2))
  
}

evaluate_model = function(train_data, model_name, test_data, outcome){
  model = lm(as.formula(model_name), data = train_data)
  new = data.frame(x = test_data)
  y_pred = predict(model,  new)
  return (MSE(test_data[[outcome]], y_pred))
}




shinyServer(function(input, output,session) {
  store <- reactiveValues()
  
  #Go to overview Button
  observeEvent(input$goover, {
    updateTabItems(session, "tabs", "over")
  })
  #Explore Button
  observeEvent(input$explore, {
    updateTabItems(session, "tabs", "first")
  })

    #the generate data
  observeEvent(input$plot, {
    store$data <- generate_data()
    store$Train_data <- store$data[1:80,]
    store$Test_data <- store$data[81:100,]
    
  })
  

  
  ## Plot train dataset
  output$train <- renderPlot({
    if (length(store$data) != 0){
      p <- ggplot(store$Train_data, aes(x = hours, y = score)) +
        geom_point()+geom_smooth(method = 'lm')
    }else{
      p <- place_holder()
    }
    return(p)
  })
  
  ## Plot test dataset
  output$test <- renderPlot({
    if (length(store$data) != 0){
      p <- ggplot(store$Test_data, aes(x = hours, y = score)) +
        geom_point()+geom_smooth(method = 'lm')
    }else{
      p <- place_holder()
    }
    return(p)
  })
  

  
  ## Plot linear regression after clicking 'Fitting the linear function' button
  ## 1. Create model after clicking button
  model_name = eventReactive(input$validate,{
    make_lm_formula('x', 'y', power = input$Degree)
  })
  
  ## 2. Fit data with model
  output$LM_train = renderPlot({
    req(model_name())
    # print(model_name())
    if (length(store$data) != 0){
      p <- ggplot(store$Train_data,aes(x = hours, y = score))+
        geom_point()+
        geom_smooth(method = 'lm', formula = as.formula(model_name()))
    }else{
      p <- place_holder()
    }
    return(p)
    })
  
  output$LM_test = renderPlot({
    req(model_name())
    if (length(store$data) != 0){
      p <- ggplot(store$Test_data, mapping=aes(x = hours, y = score))+
        geom_point()+
        geom_smooth(method = 'lm', formula = as.formula(model_name()))
    }else{
      p <- place_holder()
    }
    return(p)
  })
  
  
  # ## Calculate MSE
  # MSE = reactive({
  #   req(model_name())
  #   evaluate_model(store$Train_data(), model_name(), store$Test_data(), 'score')
  # })
  
  # ## Print mean square error
  # output$MSE <- renderPrint({
  #   req(MSE())
  #   print(paste0('Mean Squared Error: ', MSE()))
  # })
  
  
  
    
  
  
 
  
})
