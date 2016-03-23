
library(plotly)
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyServer(function(input, output) {
  
  newdata <- function(x) {
    data.frame(year = yr_start:yr_end, attain = xi_0 + model.fun(x)*(yr_start:yr_end - yr_start)) 
  }
  output$projection <- renderPlotly(
    p %>%
      add_trace(data = newdata(input), 
                x = year, 
                y = attain, 
                text = paste0(round(newdata(input)$attain, 1), "%"), 
                hoverinfo = "x+text", 
                line = list(color = "#555555", dash = "3")) %>%
      add_trace(x = success.year(model.fun(input)), 
                y = lumina_goal, 
                hoverinfo = "none", 
                marker = list(color = "#FF0000", size = 8)) %>%
      layout(annotations = list(x = success.year(model.fun(input)), 
                                y = lumina_goal, 
                                text = floor(success.year(model.fun(input))), 
                                arrowhead = 0))
  )
})
