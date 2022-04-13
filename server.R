library(shiny)
library(ggplot2)
library(caret)


shinyServer(function(input, output,session) {
  store <- reactiveValues()
  store$train <- 0

  
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
    store$m_train <- NULL
    store$poly_model <- NULL
    #store$mse_plot <- NULL
    store$data <- generate_data(100)
    store$Train_data <- store$data[1:40,]
    store$Test_data <- store$data[40:50,]
    store$m_train <- train_model(store$Train_data, 1)
    store$mse_plot <- plot_mse(store$data, 15, 5)

    })
  
 observeEvent(input$validate, {
   store$poly_model <- train_model(store$Train_data, input$degree)
 })

# observeEvent(input$MSE,{
  # store$mse_plot <- TRUE
 #})

 # output$train <- renderPlot({
   # if (length(store$data) != 0){
     # p <- ggplot(store$Train_data, aes(x = hours, y = score)) +
      #  geom_point()
  #  }else{
     # p <- place_holder()
   # }
  #  return(p)
 # })
  
  
#  output$test <- renderPlot({
    #if (length(store$data) != 0){
      #p <- ggplot(store$Test_data, aes(x = hours, y = score)) +
        #geom_point()
  #  }else{
     # p <- place_holder()
   # }
  #  return(p)
  #})
  
  
   output$train <- renderPlot({
   if (length(store$m_train) != 0){if (length(store$poly_model) != 0){
     p1 <- plot_train_model(store$Train_data, store$m_train) 
     p <- adding_new_train(p1, store$Train_data, store$poly_model)
   }else{
   p <- plot_train_model(store$Train_data, store$m_train)} 
     }
     
  else{
   p <- place_holder()
   }
   return(p)
  })   
  
   
    output$test <- renderPlot({
   if (length(store$m_train) != 0){if (length(store$poly_model) != 0){
   p1 <- plot_test_model(store$Test_data, store$m_train)
   p <- adding_new_test(p1, store$Test_data,store$poly_model)}else{
     p<- plot_test_model(store$Test_data, store$m_train)
   }
     }else{
    p <- place_holder()
    }
    return(p)
   })
    
    output$mse <- renderPlot({
      if (length(store$data) != 0){
        p <- store$mse_plot
        }
      else{
        p <- place_holder()
      }
      return(p)
    })
 
  
})
