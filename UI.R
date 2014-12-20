## This is the ui.R for the project in the Data Products Coursera series on Data Science
##
## The product displays different crime maps of San Francisco for both crime type and by year.
##

library(shiny)

shinyUI(
        pageWithSidebar(
                # Application title
                headerPanel("Crime Mapping"),
                sidebarPanel(
                        numericInput('glucose', 'Glucose mg/dl', 90, min = 50, max = 200, step = 5),
                        submitButton('Submit')
                ),
                mainPanel(
                        h3('Results of prediction'),
                        h4('You entered'),
                        verbatimTextOutput("inputValue"),
                        h4('Which resulted in a prediction of '),
                        verbatimTextOutput("prediction")
                )
        )
)