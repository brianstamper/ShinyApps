
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(ggplot2)

shinyServer(function(input, output) {

  output$distPlot <- renderPlot({
    ggplot(data.frame()) +
      xlim(0, 20) +
      ylim(-20, 80) +
      geom_abline(intercept = input$b, slope = input$m,
                  size = 1,
                  color = "blue")
  })
  
})
