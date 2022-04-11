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

# lm_model = function(lm_formula, data){
#   lm_formula = as.formula(lm_formula)
#   lm_model = lm(lm_formula, data = data)
#   return(lm_model)
# }

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
        geom_point()
    }else{
      p <- place_holder()
    }
    return(p)
  })
  
  ## Plot test dataset
  output$test <- renderPlot({
    if (length(store$data) != 0){
      p <- ggplot(store$Test_data, aes(x = hours, y = score)) +
        geom_point()#+geom_smooth(method='lm')
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
  
  
  
    
  
  
 
  
})
