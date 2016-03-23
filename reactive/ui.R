
library(shiny)

shinyUI(fluidPage(
  sidebarLayout(
    sidebarPanel(
      sliderInput("sliderA",
                  "A:",
                  min = -50,
                  max = 50,
                  value = a_new),
      sliderInput("sliderB",
                  "B:",
                  min = -50,
                  max = 50,
                  value = b_new),
      sliderInput("sliderC",
                  "C:",
                  min = -50,
                  max = 50,
                  value = c_new)
    ),

    mainPanel(
      tableOutput("mytable")
    )
  )
))
