
library(plotly)
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(fluidPage(
  sidebarLayout(
    sidebarPanel(
      sliderInput("agr", "Some important factor", min = -.5, max = 1.5, value = slope.init, step = .01),
      sliderInput("fac1", "Another factor 1", min = 0, max = 2, value = 1, step = .1),
      sliderInput("fac2", "Another factor 2", min = 0, max = 2, value = 1, step = .1),
      sliderInput("fac3", "Another factor 3", min = 0, max = 2, value = 1, step = .1)
    ),
    mainPanel(
      plotlyOutput("projection")
    )
  )
))
