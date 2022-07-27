#' Server code for our hello world shiny app
#' 
#' This contains boiler plate code from https://shiny.rstudio.com/gallery/#demos
#' 
#' @param input,output,session Internal parameters for {shiny}. 
#' 
#' @export
#' @import shiny
#' @importFrom graphics hist
#' @importFrom graphics lines
#' @importFrom graphics rug
#' @importFrom stats density
hello_srv <- function(input, output, session)
{
  # boiler plate code, copied and pasted from https://github.com/rstudio/shiny-examples/blob/main/083-front-page/server.R
  output$main_plot <- renderPlot({
    
    hist(faithful$eruptions,
         probability = TRUE,
         breaks = as.numeric(input$n_breaks),
         xlab = "Duration (minutes)",
         main = "Geyser eruption duration")
    
    if (input$individual_obs) {
      rug(faithful$eruptions)
    }
    
    if (input$density) {
      dens <- density(faithful$eruptions,
                      adjust = input$bw_adjust)
      lines(dens, col = "blue")
    }
  })
}


#' UI code for our hello world shiny app
#' 
#' This contains boiler plate code from https://shiny.rstudio.com/gallery/#demos
#' 
#' @export
#' @import shiny
#' @import shinydashboard
hello_ui <- function()
{
  tabItem(tabName = 'HelloWorld',
          
          # boiler plate code copied and pasted from https://github.com/rstudio/shiny-examples/blob/main/083-front-page/ui.R
          selectInput(inputId = "n_breaks",
                      label = "Number of bins in histogram (approximate):",
                      choices = c(10, 20, 35, 50),
                      selected = 20),
          
          checkboxInput(inputId = "individual_obs",
                        label = strong("Show individual observations"),
                        value = FALSE),
          
          checkboxInput(inputId = "density",
                        label = strong("Show density estimate"),
                        value = FALSE),
          
          plotOutput(outputId = "main_plot", height = "300px"),
          
          # Display this only if the density is shown
          conditionalPanel(condition = "input.density == true",
                           sliderInput(inputId = "bw_adjust",
                                       label = "Bandwidth adjustment:",
                                       min = 0.2, max = 2, value = 1, step = 0.2)
          )
  )
}
