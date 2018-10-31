library(shiny)
library(ggplot2)
library(raster)
library(maptools)
library(rgdal)
library(leaflet)
library(tmap)

ui <- fluidPage(
  fluidPage(column(4,offset = 5, titlePanel("지도를 그려보자"))),
  fluidRow(
    column(6,
           radioButtons("view", "View Type:",
                        c("인구" = "인구", "경찰총원"="경찰정원","1인당 담당인구"="x1인당담당인구"), 
                        selected = "인구")
           
    )
  ),
  fluidRow(
    column(6,leafletOutput("Plot")),
    column(6,plotOutput("Plot2")),
    column(12, plotOutput("Plot3"))
    
  )  
)  

server <- function(input, output) {
  police<- read.csv("data/경찰청_전국지역별_경찰관_1인당_담당_인구수_2017.csv",
                    stringsAsFactors = FALSE)
  police$정.원<-gsub(",","",police$정.원)
  police$인.구<-gsub(",","",police$인.구)
  police$정.원<-as.integer(police$정.원)
  police$인.구<-as.integer(police$인.구)
  police$지방청<- as.factor(police$지방청)
  police$id <- 0:16
  korea<- shapefile("map/TL_SCCO_CTPRVN.shp")
  korea<-spTransform(korea,CRS("+proj=longlat"))
  korea$인구 <- police$인.구
  korea$경찰정원 <- police$정.원
  korea$x1인당담당인구 <- police$X1인당.담당인구
  
  
  output$Plot <- renderLeaflet({
    tmap_mode("view")
    tm<-tm_shape(korea) +
      tm_polygons(input$view, id="CTP_KOR_NM")
    tmap_leaflet(tm)
    
  })
  output$Plot2 <- renderPlot({
    tmap_mode("plot")
    tm_shape(korea) +
      tm_polygons(input$view,legend.show = FALSE) +
      tm_facets(by = "CTP_KOR_NM", free.coords=TRUE, drop.shapes=TRUE)+
      tm_text("CTP_KOR_NM", size = 2 , shadow =TRUE)
    
  })
  output$Plot3 <- renderPlot({
    names(police) <- c("지방청", "경찰정원","인구", "x1인당담당인구","id")
    g<- ggplot(police, aes_string(x= "지방청", y= input$view))
    g +geom_bar(stat = 'identity', fill = 'gold', col='red') + theme(axis.text.x=element_text(angle=45, hjust=1))
    
  })
  
}

shinyApp(ui, server)
