kamula_page <- Stack(
  tokens = list(childrenGap = 10),
  
  
  br(),
  br(),
  #h3("kamula...")
  #card_intro,
  Stack(
    horizontal = TRUE,
    tokens = list(childrenGap = 30),
    Stack(horizontal = FALSE,
          tokens = list(childrenGap = 10),
          makeCard("About Kamula", div( 
            leafletOutput("map2", width = "300px"),
            h3("2863: Total population", style = "color: #59B755;"),
            h3("234: Households", style = "color: #59B755;"),
            h3("4: Primary schools", style = "color: #59B755;"),
            h3("6: Churches", style = "color: #59B755;"),
            h3("Denominations: Anglican,Pentecostal", style = "color: #59B755;")
          )),
          
          
    ),
    br(),
    br(),
    Stack(
      horizontal = FALSE,
      tokens = list(childrenGap = 1),
      #h3("Guide text"),
      # makeCard("2021 Mission Site",  ShinyDash::gaugeOutput("gauge_visitations")),
      # makeCard("2021 Mission Site",  ShinyDash::gaugeOutput("gauge_literature"))
      makeCard( 
        "Visitation and literature coverage",
        div( 
          Stack( 
            horizontal = TRUE,
            tokens = list(childrenGap = 30),
            flexdashboard::gaugeOutput("gauge_visitations", width = "300px"),
            flexdashboard::gaugeOutput("gauge_literature", width = "300px")
          )
        )
      ),
      makeCard( 
        "Children ministry",
        div( 
          Stack( 
            horizontal = TRUE,
            tokens = list(childrenGap = 30),
            
            
          )
        )
      ),
      makeCard( 
        "Bible study class",
        div( 
          Stack( 
            horizontal = TRUE,
            tokens = list(childrenGap = 30),
            h2("34: Class attendance"),
            h2("20: Baptisms")
          )
        )
      )
      # h4("how many were enrolled for baptism"),
      # h4("baptised")
      
    )
  )#,
  
  # Stack( 
  #   horizontal = TRUE,
  #   tokens = list(childrenGap = 30),
  #   
  #   
  #   
  # )
  
)