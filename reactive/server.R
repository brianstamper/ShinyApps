library(shiny)

shinyServer(function(input, output, session) {
  vals <- reactive({
    df <- data.frame(a = input$sliderA,
                     b = input$sliderB,
                     c = input$sliderC)
  })
  
  observe({
    a_new <- input$sliderA
    print(paste("a_new:", a_new, "a_old:", a_old))
    b_new <- isolate(input$sliderB) + 2 * (a_new - a_old)
    updateSliderInput(session, "sliderB", value = b_new)
    a_old <<- a_new
  })
  
  observe({
    b_new <- input$sliderB
    print(paste("b_new:", b_new, "b_old:", b_old))
    c_new <- isolate(input$sliderC) + 2 * (b_new - b_old)
    updateSliderInput(session, "sliderC", value = c_new)
    b_old <<- b_new
  })
  
  output$mytable <- renderTable({
    data.frame(vals())
  })

})


