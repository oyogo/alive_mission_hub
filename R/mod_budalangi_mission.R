
#' Budalangi UI Function
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

mod_budalangi_ui <- function(id) {
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
                makeCard("Budalangi - Mudembi | 12th - 31st, 2021", div( 
                  leafletOutput(ns("map_butere"), width = "100%"),
                  h3("Location: Kakamega county, 3Km from Butere lower market", style = "color: #59B755;"),
                  h3("Households: 2470", style = "color: #59B755;"),
                  h3("Population: 4113", style = "color: #59B755;"),
                  h3("Economic activities: Majority are farmers, keeping animals and growing subsistence crops.", style = "color: #59B755;"),
                  h3("Religion: Christianity takes the lead, having ACK as the dominant church followed by other evangelical believers. 
                     Islamic also takes a good number of the locals.", style = "color: #59B755;")
                  
                ), style = "width: 800px;"
                )
                
                
          ),
          
          Stack(
            horizontal = FALSE,
            tokens = list(childrenGap = 1),
            makeCard( #class = "card",
                 "Visitation and literature coverage",
                 div( 
                   
                   Stack( 
                     horizontal = TRUE,
                     tokens = list(childrenGap = 1),
                   Stack( 
                     horizontal = FALSE,
                     tokens = list(childrenGap = 30),
                     div(h4("Souls engaged at \n public air meetings \n and door to door visitations"),
                         plotlyOutput("gauge_visitations_budalangi", height = "190px", width = "300px"))
                   ),
                   Stack( 
                     horizontal = FALSE,
                     tokens = list(childrenGap = 30),
                     div(h4("Number of people reached with literature"),plotlyOutput("gauge_literature_budalangi", height = "190px", width = "300px"))
                   )
                   
                 )
                 ) ,style = "margin-left: 10px; margin-right: 10px; width: 650px; text { fill: red; }"
            ),
            makeCard( #class = "card_skyblue4",
                 h3("Children ministry"),
                 div( 
                   Stack( 
                     horizontal = TRUE,
                     tokens = list(childrenGap = 30),
                     
                     h2("23 - 40 : Average attendance")
                   )
                 ) ,style = "margin-left: 10px; margin-right: 10px; width: 650px; text { fill: blue; }"
            ),
            makeCard( #class = "card_green", 
                 "Bible study class",
                 div( 
                   Stack( 
                     horizontal = FALSE,
                     tokens = list(childrenGap = 30),
                     h2("6: Baptisms")
                   )
                 ) ,style = "margin-left: 10px; margin-right: 10px; width: 650px; text { fill: red; }"
            )
            
          )
        )
        
      )
    )
  )
}


#' Budalangi Server Functions
#'
#' @noRd
#' @export
mod_budalangi_server <- function(input, output, session) {
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