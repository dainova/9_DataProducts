library(shiny)
library(datasets)

# Define server logic required to summarize and view the selected dataset
shinyServer(function(input, output) {
  
  # Return the requested dataset
  datasetInput <- reactive({
    switch(input$dataset,
           "Class" = rock,
           "Sex" = pressure,
           "Age" = cars)
  })
  
  
  cascade<- reactive({         ##
    t <- data.frame(Titanic)
    temp <- quote(input$param1)
    m <- unique(t[,eval(temp), drop=F])
    sapply(m [, eval(temp)], as.character)
  })
  
  #searchResult()[,1]
  output$selectUI <- renderUI({ 
    selectInput("value", "Choose a value:",  cascade())       
  })
  
  
  output$text <- renderText({ 
    c("Selected Param: ", input$param1, "...value=", input$value )  })
  
  output$tbl <- renderTable({
    t <- data.frame(Titanic)
    #head(subset(t, Class =='1st'), n = input$obs)
    head(subset(t,  get(input$param1) == input$value),n = input$obs)
  })
  #subset(t, Class ==inputvalue)    ## OK
  #subset(t, get(inputparam) ==inputvalue)    ## <@>><   doesn't work !!!!!
  #t[ t[colnames(t)==inputparam]==inputvalue, ]
  #eval(parse( text=paste0("subset(t, ", inputparam, "=='", inputvalue, "')") ))
  #t[ t[[inputparam]] ==inputvalue, ] 
  
  # Generate a summary if check box = TRUE
  output$summary <- renderPrint({
    if (input$summary)  ## == TRUE )
    {
    dataset <- data.frame(Titanic)
    summary(dataset)  }
  })
})
