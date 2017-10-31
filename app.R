#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(dplyr)
library(ggplot2)
library(shiny)

source('functions.R')

socks <- read.csv("socks.csv", stringsAsFactors = F)
socks$date <- as.Date(socks$date)
min_date <- min(socks$date)
max_date <- max(socks$date)

# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("Will's Socks"),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
        sliderInput("Date",
                    "Date",
                    min = as.Date(min_date,"%m/%d/%y"),
                    max = as.Date(max_date,"%m/%d/%y"),
                    value=as.Date(max_date),
                    timeFormat="%m/%d/%y")
      ),
      
      # Show a plot of the generated distribution
      mainPanel(
         plotOutput("distPlot")
      )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
   
   output$distPlot <- renderPlot({
     sock_histogram(socks, input$Date)
   })
}

# Run the application 
shinyApp(ui = ui, server = server)
