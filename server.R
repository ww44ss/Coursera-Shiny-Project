
library(shiny)



datafile = "SFPD_Incidents_-_Current_Year__2014_.csv"
data <- read.csv(datafile)

##fix day of week order
data$DayOfWeek <- factor(data$DayOfWeek, levels= c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"))

##for simplicity keep only complete cases
data<-data[complete.cases(data),]

data$Date<-as.Date(as.character(data$Date), "%m/%d/%Y")

#had to be a little clever with the time , basically trick everything to think it is the same day.
#data$Time<-as.POSIXct(paste("1970-01-01", as.character(data$Time)), format="%Y-%m-%d %H:%M")

##while the above works. I found the analysis looks easier just hacking out the hour....

##Alternate method is just to that the hh and convert to a number.
##this proved reliable and not too complicated.
data$Time <- as.numeric(substring(as.character(data$Time),1,2))

ddata<-dim(data)


require(ggmap)
require(mapproj)

##Subset data by crime
## here focus on only top crimes
PlotTheft <-data[data$Category=="LARCENY/THEFT", ]
PlotVehicle<-data[data$Category=="VEHICLE THEFT", ]
PlotAssault<-data[data$Category=="ASSAULT", ] 
PlotVandalism<-data[data$Category=="VANDALISM", ] 

##get map data
map <- get_map(source="google", maptype="roadmap", location = 'San Francisco', zoom = 13)
##generate map
map1 <- ggmap(map) 
map2<-map1 + geom_point(aes(x = PlotTheft$X, y = PlotTheft$Y), data = PlotTheft, alpha = .1, color="red", size = 3)
#map3<-map2 + geom_point(aes(x = PlotAssault$X, y = PlotAssault$Y), data = PlotAssault, alpha = .1, color="blue", size = 3)
#if (input$id2=="Assault") map2<-map2 + geom_point(aes(x = PlotVehicle$X, y = PlotVehicle$Y), data = PlotVehicle, alpha = .2, color="darkgreen", size = 3)

#map2<-map1


shinyServer(
        function(input, output) {
                
                output$oid2 <- renderPrint({input$id2})
                
                
                
                ## 
                #map2<-map1
                
                #print(input$id2)
                #if (input$id2=="Theft") map2<-map2 + geom_point(aes(x = PlotTheft$X, y = PlotTheft$Y), data = PlotTheft, alpha = .1, color="red", size = 3)
                #if (input$id2=="Vehicle") map2<-map2 + geom_point(aes(x = PlotAssault$X, y = PlotAssault$Y), data = PlotAssault, alpha = .1, color="blue", size = 3)
                #if (input$id2=="Assault") map2<-map2 + geom_point(aes(x = PlotVehicle$X, y = PlotVehicle$Y), data = PlotVehicle, alpha = .2, color="darkgreen", size = 3)
                
                #map2<-hist(rnorm(100))

                output$newHist <- renderPlot({
                        map2
                        
                })
        }
)