
#' Kamila UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
#' @export

mod_kamila_ui <- function(id) {
  ns <- NS(id)
  tagList(
    fluentPage(
  
  Stack(
  tokens = list(childrenGap = 10),
  
  
  br(),
  br(),
  Stack(
    horizontal = TRUE,
    tokens = list(childrenGap = 30),
    Stack(horizontal = FALSE,
          tokens = list(childrenGap = 10),
          makeCard("About Kamila", div( 
            leafletOutput(ns("map_kamila"), width = "100%"),
            h3("The center is located approximately 2Okm from Kiwawa", style = "color: #59B755;"),
            h3("500: Approximate residents of the area (mostly consentrated around the market)", style = "color: #59B755;"),
            h3("Occupation: largely pastoralist with some running businesses at the market centre.", style = "color: #59B755;"),
            h3("Social amenities: Bore-hole, dispensary and schools", style = "color: #59B755;"),
            h3("Religion: AIC, Catholic, Full gospel and ACCK", style = "color: #59B755;")
          )),
          
          
    ),
    br(),
    br(),
    Stack(
      horizontal = FALSE,
      tokens = list(childrenGap = 1),
      makeCard( 
        "Visitation and literature coverage",
        div( 
          Stack( 
            horizontal = TRUE,
            tokens = list(childrenGap = 30),
            flexdashboard::gaugeOutput("gauge_engagements_kamila", width = "100%"),
            flexdashboard::gaugeOutput("gauge_literature_kamila", width = "100%")
            
          ),
          Stack(
            horizontal = TRUE,
            h2("64: Homes visited during door to door evangelism")
          )
        )
      ),
      makeCard( 
        "Children ministry",
        div( 
          Stack( 
            horizontal = TRUE,
            tokens = list(childrenGap = 30),
            
            h3("8: Average daily class attendance")
          )
        )
      ),
      makeCard( 
        "Bible study class",
        div( 
          Stack( 
            horizontal = TRUE,
            tokens = list(childrenGap = 30),
            #h2("34: Class attendance"),
            h2("11: Baptised souls")
          )
        )
      )
      
    )
  )
  
)
)
)
}

#' kamila Server Functions
#'
#' @noRd
#' @export
mod_kamila_server <- function(input, output, session) {
  ns <- session$ns
  
  
  output$map_kamila <- renderLeaflet({
    
    leaflet() %>%
      setView(lat = 0.19841,lng = 34.45989,zoom = 9) %>%
      addTiles() %>%
      addMarkers(lng = 34.45989,
                 lat = 0.19841, label = "Kamila",
                 labelOptions = labelOptions(noHide = T, direction = "bottom")) %>%
      
      addMiniMap(width = 90,height = 80) 
    
    
  })
  
  
 
  
}