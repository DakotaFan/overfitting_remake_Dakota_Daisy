library(shiny)
library(ggplot2)



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
  observeEvent(input$plot, {
    store$data <- generate_data()
    store$Train_data <- store$data[1:80,]
    
  })
  
  observeEvent(input$validate, {
    store$data <- generate_data()
    store$Test_data <- store$data[81:100,]
    
  })
  
  
  output$train <- renderPlot({
    if (length(store$Train_data) != 0){
      p <- ggplot(store$Train_data, aes(x = hours, y = score)) +
        geom_point()
    }else{
      p <- place_holder()
    }
    return(p)
  })
  
  
  output$test <- renderPlot({
    if (length(store$Test_data) != 0){
      p <- ggplot(store$Test_data, aes(x = hours, y = score)) +
        geom_point()
    }else{
      p <- place_holder()
    }
    return(p)
  })
  
    
  
  
 
  
})