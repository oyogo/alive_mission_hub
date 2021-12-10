
#' Butere UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
#' @export

mod_butere_ui <- function(id) {
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
                makeCard("Masaba - Butere", div( 
                  leafletOutput(ns("map_butere"), width = "100%"),
                  h3("Location: Kakamega county, 3Km from Butere lower market", style = "color: #59B755;"),
                  h3("Economic activities: Majority are farmers, keeping animals and growing subsistence crops.", style = "color: #59B755;"),
                  h3("Religion: Christianity takes the lead, having ACK as the dominant church followed by other evangelical believers. 
                     Islamic also takes a good number of the locals.", style = "color: #59B755;")
                 
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
                  flexdashboard::gaugeOutput("gauge_visitations", width = "300px"),
                  flexdashboard::gaugeOutput("gauge_literature_butere", width = "300px")
                )
              )
            ),
            makeCard( 
              "Children ministry",
              div( 
                Stack( 
                  horizontal = TRUE,
                  tokens = list(childrenGap = 30),
                  
                  h2("40 - 60 : Average attendance")
                )
              )
            ),
            makeCard( 
              "Bible study class",
              div( 
                Stack( 
                  horizontal = FALSE,
                  tokens = list(childrenGap = 30),
                  h2("6: Baptisms")
                )
              )
            )
            
          )
        )
        
      )
    )
  )
}


#' Butere Server Functions
#'
#' @noRd
#' @export
mod_butere_server <- function(input, output, session) {
  ns <- session$ns
  
  
  output$map_butere <- renderLeaflet({
    
    leaflet() %>%
      setView(lat = 0.19841,lng = 34.45989,zoom = 9) %>%
      addTiles() %>%
      addMarkers(lng = 34.45989,
                 lat = 0.19841, label = "Masaba",
                 labelOptions = labelOptions(noHide = T, direction = "bottom")) %>%
      
      addMiniMap(width = 90,height = 80) 
    
    
  })
  
  
  
}