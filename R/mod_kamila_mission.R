
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


makeCard <- function(title, content, size = 12, style = "") {
  div(
    class = glue("card ms-depth-8 ms-sm{size} ms-xl{size}"),
    style = style,
    Stack(
      tokens = list(childrenGap = 5),
      Text(variant = "large", title, block = TRUE),
      content
    )
  )
}

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
          ), style = "width: 800px;"
          ),
          
          
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
            tokens = list(childrenGap = 1),
            Stack( 
              horizontal = FALSE,
              tokens = list(childrenGap = 30),
              div(h4("Souls engaged at \n public air meetings \n and door to door visitations"),
                  plotlyOutput("gauge_visitations_kamila", height = "190px", width = "300px"))
            ),
            Stack( 
              horizontal = FALSE,
              tokens = list(childrenGap = 30),
              div(h4("Number of people reached with literature"),plotlyOutput("gauge_literature_kamila", height = "190px", width = "300px"))
            )
            
          )
        ),style = "margin-left: 10px; margin-right: 20px; width: 600px; .text { fill: green; }"
      ),
      makeCard( 
        "Children ministry",
        div( 
          Stack( 
            horizontal = TRUE,
            tokens = list(childrenGap = 30),
            
            h3("8: Average daily class attendance")
          )
        ),
        style = "margin-left: 10px; margin-right: 20px; width: 600px;"
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
        ),
        style = "margin-left: 10px; margin-right: 20px; width: 600px;"
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
      setView(lat = 1.7863481,lng = 35.0553031,zoom = 9) %>%
      addTiles() %>%
      addMarkers(lng = 35.0553031,
                 lat = 1.7863481, label = "Kamila",
                 labelOptions = labelOptions(noHide = T, direction = "bottom")) %>%
      
      addMiniMap(width = 90,height = 80) 
    
    
  })
  
  
 
  
}