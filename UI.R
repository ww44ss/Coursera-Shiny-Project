## This is the ui.R for the project in the Data Products Coursera series on Data Science
##
## The product displays different crime maps of San Francisco for both crime type and by year.
##

library(shiny)

shinyUI(pageWithSidebar(
        headerPanel("Things"),
        sidebarPanel(
                
                checkboxGroupInput("id2", "Checkbox",
                                   c("Theft" = "Theft",
                                     "Vehicle" = "Vehicle",
                                     "Assault" = "Assault")),
                #dateInput("date", "Date:"),
                submitButton('Submit')
        ),
        mainPanel(
                h1('Crime Maps'),
                h3('Data for 2014'),
                h4('You entered'),
                verbatimTextOutput("oid2"),
                
                
                plotOutput('newHist')
        )
))

