library(shiny)
library(ggplot2)
library(plotly)

rawdata <- read.csv("totals.csv")
rates <- data.frame(year = rawdata$year,
                    #pop = rawdata$population,
                    attain = 100 * rawdata$total_with_assoc / rawdata$population)#,
                    #award = rawdata$award_total / rawdata$population,
                    #enrolled = rawdata$enrolled / rawdata$population,
                    #hsgrads = rawdata$hsgrads / rawdata$population)

attain.growth.model <- lm(attain ~ year, rates)

# Start and end points for the projection
yr_start <- 2014
yr_end <- 2057
lumina_goal <- 60
xi_0 <- rates$attain[rates$year == 2014] #predict(attain.growth.model, data.frame(year = yr_start))
agr <- attain.growth.model[[1]][2]
goal_yr <- success.year(agr)
df <- data.frame(year = 2014:2057, attain = xi_0 + agr*(yr_start:yr_end - yr_start))

xax <- list(
  title = "Year",
  dtick = 5,
  range = list(2004, 2056),
  fixedrange = TRUE,
  titlefont = list(family = "arial, sans-serif", size = 14)
)

yax <- list(
  title = "Attainment rate",
  ticksuffix = "%",
  range = list(29, 71),
  fixedrange = TRUE,
  titlefont = list(family = "arial, sans-serif", size = 14)
)

model.fun <- function(input) {
  input$agr*input$fac1*input$fac2*input$fac3
}

# What year Lumina goal acheived
success.year <- function(agr) {
  (lumina_goal - xi_0)/agr + yr_start
}

p <- plot_ly(rates, 
             x = year, 
             y = attain, 
             text = paste0(rates$year, "<br>", round(rates$attain, 1), "%"), 
             hoverinfo = "text") %>%
  add_trace(x = c(2000: 2060), 
            y = rep(60, 60), 
            line = list(color = "#FF0000"), 
            hoverinfo = "none") %>%
  layout(xaxis = xax, 
         yaxis = yax, 
         showlegend = FALSE, 
         hovermode = "closest",
         font = list(family = "arial, sans-serif")) %>%
  config(showLink = FALSE, 
         displayModeBar = FALSE)

