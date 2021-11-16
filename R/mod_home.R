#' home UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
#' @export

mod_home_ui <- function(id) {
  ns <- NS(id)
  tagList(
    fluentPage(
      
      Stack(
        tokens = list(childrenGap = 10),
        div(
          class = "ms-Grid", dir = "ltr",
          
              div(
                class = "ms-Grid-row", 
           
                 div(class = "title",
                   h2("Welcome to ALIVE Kenya missions hub!"),
                      h3("The missions department of ALIVE Kenya is charged with seeing to it that outreach activities 
                      to those without the faith are well planned for and executed in response to Christ’s injunction 
                      'Go ye therefore, and teach all nations, baptizing them in the name of the Father, and of the Son, and of the Holy Ghost.' Matt 28:19.")
            ),
     
       div(
         class = "ms-Grid-row",
         Stack(horizontal = TRUE,
               tokens = list(childrenGap = 30),
               h1("23: Missions conducted", style = "color: #59B755;"), 
               h1("23423: Souls reached", style = "color: #59B755;"),
               h1("453: Baptised", style = "color: #59B755;")
         )
       ),
        div(
          class = "card_skyblue4",
           h2("Next move : 2021 Rural mission"),
          
          div(
            class = "ms-Grid-row",
           
           #  div( class = "card",
           # h4("Count down to 2021 Mission"),
           #      uiOutput('count_down'),
           #     ),
            
            div( class = "ms-Grid-row",
                 div(
                   class = "ms-Grid-col ms-sm12 ms-md6 ms-lg6",   
                        div(
                          class = "card",
                          uiOutput('count_down'),
                           br(),
                            plotOutput('calendar'),
                            div(
                              
                              class = "scroll-left",
                              p("I will go with the everlating gospel!!"),
                              )
                            )
              ),
              
              div(
                class = "ms-Grid-col ms-sm12 ms-md6 ms-lg6",
                div(
                  class = "card",
                  h4("Site: Budalangi", style = "color: #59B755;"),
                  h4("Registration fee: KShs 3000 ", style = "color: #59B755;"),
                  h4("Register ",tags$a(href="www.rstudio.com", "here"),style = "color: #59B755;"),
                  leafletOutput(ns("missionsite.map"))
                )
              )
            )
            
           
            
           
            
          )
        ),
     
     div(
       class = "card",
       
       h2("so far...."),
       
       div(
         class = "ms-Grid-row",
         
         leafletOutput(ns("retrospect_map"))
         
         )
       
        )
       )
      )
     )
    )
  )
}

#' home Server Functions
#'
#' @noRd
#' @export
mod_home_server <- function(input, output, session) {
  ns <- session$ns
  
  
  # read shapefile
  m.locations <- sf::st_read("data/shp/County.shp") %>%
    st_transform(crs = 4326)
  
  
  output$count_down <- renderUI({
    
    flipdownr::flipdown(downto = "2021-12-19", id = "c1", theme = "dark")
  })
  
  output$missions_conducted <- renderPlotly({
    
    fig <- plot_ly(
      x = c("Kitelakapel", "Kangoletiang", "Kasei","Kiwawa"),
      y = c(20, 14, 23,45),
      name = "SF Zoo",
      type = "bar"
    ) %>% plotly::layout(title = "Mission sites and souls baptised")
    
    fig
    
  })
  
  
  output$calendar <- renderPlot({
    
    calendR::calendR(year = 2021, month = 12,special.days = c(19:31),special.col = "#C9A664",
                     text = c("Travelling","Day 1","Day 2","Day 3","Fasting","Day 5","Sabbath","c.outreach",
                              "Day 8","Day 9","Day 10","Day 11","Prep.day"),
                     text.pos = c(9:31), #bg.img = "www/pokot.jpg",
                     bg.col = "grey",
                     title.size = 10,orientation = "landscape", subtitle = "Mission dates")
    
  })
  
  output$missionsite.map <- renderLeaflet({
    
    leaflet() %>%
      setView(lat = 0.14, lng = 34.0266, 9) %>%
      addTiles() %>%
      addPolygons(data = m.locations) %>%
      addMarkers(lng = 34.0266, lat = 0.14) %>%
      addMiniMap(position = "bottomright")
    
    
  })
  
  output$retrospect_map <- renderLeaflet({
    
    leaflet() %>%
      addProviderTiles(providers$Stamen.TonerLite, options = providerTileOptions(noWrap = TRUE)) %>%
      addPolygons(data = m.locations)
    
    
  })
  
}