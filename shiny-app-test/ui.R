
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(fluidPage(

  # Application title
  titlePanel("Movable line"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      sliderInput("m",
                  "Slope",
                  min = -10,
                  max = 10,
                  value = .3,
                  step = .1),
      sliderInput("b",
                  "Intercept",
                  min = -20,
                  max = 80,
                  value = 20)
    ),

    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("distPlot")
    )
  )
))
