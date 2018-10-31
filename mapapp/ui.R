library(shiny)
library(ggplot2)
library(raster)
library(maptools)
library(rgdal)
library(leaflet)
library(tmap)


ui <- fluidPage(
  titlePanel("지도를 그려보자"),
  sidebarLayout(
    sidebarPanel(
      radioButtons("view", "View Type:",
                   c("인구" = "pop", "경찰총원"="police","1인당 담당인구"="popperpolice"), 
                   selected = "pop")
      
      )
    ),
    mainPanel(
      

      leafletOutput("Plot"),
      plotOutput("Plot2"),
      fluidRow(
        column(4, plotOutput("Plot3", width = 294, height = "100%"))
        )
    )
  )
  



