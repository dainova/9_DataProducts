library(shiny)
library(datasets)

# Define server logic required to summarize and view the selected dataset
shinyServer(function(input, output) {
  

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
  
  
 
  
  output$tbl <- renderTable({
    t <- data.frame(Titanic)
          
         if (input$param2 == 'Survived') { head(subset(t,   Survived == 'Yes',n = input$obs))}
    else if (input$param2 == 'Dead')     { head(subset(t,   Survived == 'No',n = input$obs))}
    else                                 { head(subset(t,  get(input$param1) == input$value),n = input$obs)}
     
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
  
  output$text <- renderText({ 
    c("Selected Param: ", input$param1 , "....Status: ",  input$param2, ".....Value=", input$value )  })
 
  output$ryba <- renderUI({
    str1 <- paste("Selected Param=", input$param1)
    str2 <- paste("Value=",  input$value)
    str3 <- paste("Status=",  input$param2)
                
    HTML(paste(str1, str2, str3, sep = '<br/>'))
    
  })
  
  
  
   
})
