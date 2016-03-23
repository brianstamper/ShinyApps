
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(fluidPage(
  sidebarLayout(
    sidebarPanel(
      sliderInput("hsgr_input", "High School Graduates", min = hsgr_2014 - 20000, max = hsgr_2014 + 20000, value = hsgr_2014),
      sliderInput("enrl_input", "Higher Ed Enrollment",  min = enrl_2014 - 50000, max = enrl_2014 + 50000, value = enrl_2014),
      sliderInput("colg_input", "Higher Ed Graduates",   min = colg_2014 - 20000, max = colg_2014 + 20000, value = colg_2014),
      sliderInput("migr_input", "Degreed Migration",     min = migr_2014 - 20000, max = migr_2014 + 20000, value = migr_2014)
    ),
    mainPanel(
      plotOutput("projection")#,      tableOutput("data")
    )
  )
))
