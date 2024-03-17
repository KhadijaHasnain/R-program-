library(readr)
library(tidyverse)
library(shiny)
library(lubridate)

cpi <- read.csv("cpi.csv")
cpi$iss_period <- as.Date(cpi$iss_period, format = "%m/%d/%Y")

ui <- fluidPage(
  tabsetPanel(
    tabPanel("CPI Evolution",
             dateInput(inputId = "base_date", label = "Base Period", min = min(cpi$iss_period), max = max(cpi$iss_period), value = min(cpi$iss_period)),
             dateInput(inputId = "current_date", label = "Current Period", min = min(cpi$iss_period), max = max(cpi$iss_period), value = max(cpi$iss_period)),
             numericInput(inputId = "dollar_amount", label = "Enter Dollar Amount:", value = 100),
             actionButton(inputId = "convert_button", label = "Convert"),
             textOutput("conversion_result")
    )
  )
)

server <- function(input, output) {
  converted_amount <- eventReactive(input$convert_button, {
    base_cpi <- cpi$cpi[cpi$iss_period == input$base_date]
    current_cpi <- cpi$cpi[cpi$iss_period == input$current_date]
    conversion <- input$dollar_amount * (current_cpi / base_cpi)
    paste0("$", round(conversion, 2))
  })
  
  output$conversion_result <- renderText({
    converted_amount()
  })
}

shinyApp(ui = ui, server = server)
