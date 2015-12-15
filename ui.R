library(shiny)

# Define UI for dataset viewer application
shinyUI(pageWithSidebar(
  
  # Application title
  headerPanel("Statistics of Titanic passengers"),
  

  # Sidebar with controls to select a dataset and specify the number
  # of observations to view
  sidebarPanel(
    
    
    
    selectInput("param1", "Choose a parameter:", 
                choices = c("Class", "Sex", "Age")),
    
    htmlOutput("selectUI"),
    #selectInput("value", "Choose a value:",
    #           choices = c("1st", "2nd", "3rd")),
    
    
    selectInput("param2", "Choose a Status:", 
                choices = c("Any", "Survived", "Dead")),
    
    numericInput("obs", "Number of passengers to display:", 10),
    checkboxInput("summary", "Show Summary", FALSE),
    
    
    submitButton("Update View")
    
    
  ),
  
  # Show a summary of the dataset and an HTML table with the requested
  # number of observations
  mainPanel(
    div("* This application works with build in dataset Titanic and displayes output based on selected 
             parametes and their values, hit Update View button for refresh cascade parameters and view results",
    style = "color:blue"),
  br(),
    textOutput("text"),
    tableOutput("tbl"),
    verbatimTextOutput("summary")
  )
))