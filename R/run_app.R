#' Application UI
#' 
#' @export
#' @import shiny
#' @import shinydashboard
app_ui <- function()
{
  dashboardPage(
    ##### Header #####
    dashboardHeader(title = 'My Shiny Project'),
    
    ##### Sidebar #####
    dashboardSidebar(
      sidebarMenu(
        menuItem('Hello World', tabName = 'HelloWorld')
      )
    ),
    
    ##### Body #####
    dashboardBody(tabItems(
      hello_ui()
    ))
  )
}

#' Application server-side
#' 
#' @param input,output,session Internal parameters for {shiny}. 
#' 
#' @export
app_server <- function(input, output, session){
  hello_srv(input, output, session)
}


#' Run a local instance of my shiny app
#' 
#' This function will start up a local instance of my shiny app from within RStudio.
#'
#' @export
#' @importFrom shiny shinyApp
run_app <- function()
{
  shinyApp(ui = app_ui(),
           server = app_server)
}