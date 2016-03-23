library(shiny)
library(ggplot2)

rawdata <- read.csv("totals.csv")
rates <- data.frame(year = rawdata$year,
                    pop = rawdata$population,
                    attain = 100 * rawdata$total_with_assoc / rawdata$population)

attain.growth.model <- lm(attain ~ year, rates)

pop.growth.model <- nls(pop ~ P*exp(r*year), 
                        rates, 
                        start = list(P = 1, r = .005),
                        control = list(maxiter = 200, minFactor = 1/(2^14), warnOnly = TRUE))

# Start and end points for the projection
yr_start <- 2014
yr_end <- 2057
lumina_goal <- 60
attr_2014 <- rates$attain[rates$year == 2014] #actual vs. predict(attain.growth.model, data.frame(year = yr_start))
agr_0 <- as.numeric(attain.growth.model[[1]][2]) # predicted growth rate of attr_
attr_2020_0 <- as.numeric(predict(attain.growth.model, data.frame(year = 2020)))
pop_2020_0 <- as.numeric(predict(pop.growth.model, data.frame(year = 2020)))
att_2020_0 <- attr_2020_0 * pop_2020_0 / 100  # predicted number of pop with degree 2020



# What year Lumina goal acheived
success.year <- function(agr) {
  yr <- (lumina_goal - attr_2014)/agr + yr_start
}

p <- ggplot(rates, aes(x = year, y = attain)) +
  geom_line() +
  scale_y_continuous(limits = c(30, 70), 
                     breaks = c(30, 40, 50, 60, 70),
                     labels = c("30%", "40%", "50%", "60%", "70%"),
                     name = "Attainment rate") +
  xlim(2007,2057) +
  xlab("Year") +
  geom_hline(yintercept = 60, color = "red") +
  theme(axis.title.x = element_text(face = "bold", size = "14")) +
  theme(axis.title.y = element_text(face = "bold", size = "14"))



shinyServer(function(input, output, session) {
  agr <- reactive({
    delta_colg <- input$colg_input - colg_2014 + input$migr_input
    attr_2020 <- (att_2020_0 + delta_colg) / (pop_2020_0 + input$migr_input) * 100
    agr_t <- (attr_2020 - attr_2014) / (2020 - 2014)
    return(agr_t)
  })

  
  observe({
    hsgr_new <- input$hsgr_input
    enrl_new <- isolate(input$enrl_input) + .40 * (hsgr_new - hsgr_old)   
    updateSliderInput(session, "enrl_input", value = enrl_new)
    hsgr_old <<- hsgr_new
  })
 
  observe({
    enrl_new <- input$enrl_input
    colg_new <- isolate(input$colg_input) + .45 * (enrl_new - enrl_old)
    updateSliderInput(session, "colg_input", value = colg_new)
    enrl_old <<- enrl_new
  })
  
   
  output$projection <- renderPlot(
    p + geom_segment(x = yr_start, 
                     y = attr_2014,
                     xend = yr_end,
                     yend = attr_2014 + agr()*(yr_end - yr_start),
                     linetype = "dashed",
                     color = "grey50")
      + annotate("point", 
                 x = success.year(agr()), 
                 y = lumina_goal, 
                 color = "red",
                 size = 3)
      + annotate("text", 
                 x = success.year(agr()), 
                 y = lumina_goal, 
                 label = round(success.year(agr())),
                 vjust = 1.25,
                 hjust = -.15,
                 size = 5)
    
  )
  #output$data <- renderTable(data.frame(agr(), 
  #                                      isolate(input$hsgr_input), 
  #                                      isolate(input$enrl_input), 
  #                                      isolate(input$colg_input), 
  #                                      isolate(input$migr_input)))
})
