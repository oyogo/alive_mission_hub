#' The application User-Interface
#'
#' @param request Internal parameter for `{shiny}`.
#'     DO NOT REMOVE.
library(shiny.react)
library(shiny.semantic)
library(dplyr)
library(ggplot2)
library(glue)
library(plotly)
library(sass)
library(shiny)
library(shiny.fluent)
library(shiny.router)
library(calendR)
library(leaflet)
library(sf)
library(flipdownr)
library(ShinyDash) #remotes::install_github("trestletech/ShinyDash")
library(htmlwidgets)
library(htmltools)
library(flexdashboard)


#library(fullcalendar)


source("R/mod_home.R")
source("R/mod_butere_mission.R")
source("R/mod_kamila_mission.R")
source("R/mod_budalangi_mission.R")

makePage <- function (title, subtitle, contents) {
  tagList(div(
    class = "page-title",
    span(title, class = "ms-fontSize-32 ms-fontWeight-semibold", style =
           "color: #323130"),
    span(subtitle, class = "ms-fontSize-14 ms-fontWeight-regular", style =
           "color: #605E5C; margin: 14px;")
  ),
  contents)
}


HorizontalStack <- function(...) {
  shiny.fluent::Stack(
    horizontal = TRUE,
    tokens = list(childrenGap = 10),
    ...
  )
}

f <- list(
  family = "Lato",
  size = "3rem",
  color = "white"
)


header <- tagList(
    img(src = "alive_logo1.jpeg", class = "logo"),
    div(Text(variant = "xLarge", "Mission Hub"), class = "title"),
    CommandBar(
        items = list(
            CommandBarItem("Resources", "Download", subitems = list(
                CommandBarItem("Download user manual", "Download", key = "download_usermanual"),
                CommandBarItem("Download mission booklet", "Download", key = "download_mbooklet")
            )),
            CommandBarItem("Upload request form", "Upload")#,
            #CommandBarItem("Share page", "Share"),
            #CommandBarItem("Download mission booklet", "Download")
        ),
        farItems = list(
            #CommandBarItem("Grid view", "Tiles", iconOnly = TRUE),
            CommandBarItem("Info", "Info", iconOnly = TRUE)
        ),
        style = list(width = "100%", color = "black")))


missions_page <- makePage(
    "Kasei mission",
    "statistics about the mission",
   h3("an overview of missions conducted")
)

kiwawa_page <- makePage(
  "Kiwawa mission",
  "statistics about the mission",
  h3("kasei details")
)

kacheliba_page <- makePage(
  "Kacheliba mission",
  "statistics about the mission",
  h3("kasei details")
)

# butere_page <- makePage(
#   "Butere mission",
#   "statistics about the mission",
#   h3("kasei details")
# )

projects_page <- makePage(
    "List of projects",
    "financial statistics",
    h3("project status")
)

mission_stories_page <- makePage(
    "Mission stories",
    "Filtered per mission",
    h3("Highlights from mission")
)





router <- make_router(
  #route("/", home_page),
  route("home", shiny::div(mod_home_ui("home_ui_1"))),
  route("missions_page", missions_page),
  route("budalangi_page", shiny::div(mod_budalangi_ui("budalangi_ui_1"))),
  route("kamila_page", shiny::div(mod_kamila_ui("kamila_ui_1"))),
  route("butere_page", div(mod_butere_ui("butere_ui_1"))),
  route("projects_page",projects_page),
  route("mission_stories_page",mission_stories_page))
navigation <- Nav(
    groups = list(
        list(links = list(
            list(name = 'Home', url = '#!/home', key = 'home', icon = 'Home'),
            list(name = 'Rural missions', url = '#!/missions_page', key = 'missions',
                 expandAriaLabel = "Expand Home section",
                 collapseAriaLabel = "Collapse Home section",
                 links = list(
                   list(
                     name = "Budalangi",
                     url = '#!/budalangi_page',
                     key = "budalangi"
                   ),
                   
                   list(
                     name = "Kamila",
                     url = '#!/kamila_page',
                     key = "kamila"
                   ),
                   
                   list(
                     name = "Butere",
                     url = '#!/butere_page',
                     key = "butere"
                   )
                 ),
                 isExpanded = TRUE),
            list(name = 'Projects', url = '#!/projects_page', key = 'projects', icon = 'GitGraph'),
            list(name = 'Mission stories', url = '#!/mission_stories_page', key = 'shinyreact', icon = 'GitGraph')
        ))
    ),
    initialSelectedKey = 'home',
    styles = list(
        root = list(
            height = '100%',
            boxSizing = 'border-box',
            overflowY = 'auto'
        )
    )
)


footer <- shiny.fluent::Stack(
    horizontal = TRUE,
    horizontalAlign = 'space-between',
    tokens = list(childrenGap = 20),
    Text(variant = "xLarge", "Built with ❤ by Insightful analytics", block=TRUE),
    Text(variant = "xLarge", nowrap = FALSE, "If you'd like to give towards mission, reach out to us at alivekenya@missions.com"),
    Text(variant = "xLarge", nowrap = FALSE, "All rights reserved.")
)



layout <- function(mainUI){
    div(class = "grid-container",
        div(class = "header", header),
        div(class = "sidenav", navigation),
        div(class = "main", mainUI),
        div(class = "footer", footer)
    )
}

shiny::addResourcePath("shiny.router", system.file("www", package = "shiny.router"))
shiny::addResourcePath("www", "www")

shiny_router_js <- file.path("shiny.router", "shiny.router.js")

# ---
app_ui <- function(request) {
  tagList(
    tags$script(HTML("
        Fluent = jsmodule['@fluentui/react']
        Fluent.loadTheme({
          defaultFontStyle: { fontFamily: 'Lato', fontWeight: 'regular' }
        })
      ")),
    # Leave this function for adding external resources
    # golem_add_external_resources(),
    # Your application UI logic
    fluentPage(
      title = "Alive M. Hub",
      suppressDependencies("bootstrap"),
      htmltools::htmlDependency(
        "office-ui-fabric-core",
        "11.0.0",
        list(href = "https://static2.sharepointonline.com/files/fabric/office-ui-fabric-core/11.0.0/css/"),
        stylesheet = "fabric.min.css"
      ),
      shiny::tags$body(
        class = "ms-Fabric",
        dir = "ltr",
        layout(router$ui)
      ),
      tags$head(
        tags$link(href = "style.css", rel = "stylesheet", type = "text/css"),
        shiny::tags$script(type = "text/javascript", src = shiny_router_js)
      )
    )
  )
}

# Define server logic required to draw a histogram
app_server <- function(input, output, session) {

    router$server(input, output, session)
   
  callModule(mod_home_server, "home_ui_1")
  callModule(mod_butere_server, "butere_ui_1")
  callModule(mod_kamila_server, "kamila_ui_1")
  callModule(mod_budalangi_server, "budalangi_ui_1")
  
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
                       text.pos = c(19:31), #bg.img = "www/pokot.jpg",
                       bg.col = "grey",
                       title.size = 10,orientation = "landscape", subtitle = "Mission dates")

    })

    output$missionsite.map <- renderLeaflet({

       leaflet() %>%
          addProviderTiles(providers$Stamen.TonerLite, options = providerTileOptions(noWrap = TRUE)) %>%
             addPolygons(data = m.locations)


    })
  
    # output$gauge_visitations <- flexdashboard::renderGauge({
    #   flexdashboard::gauge(40, min = 0, max = 100, symbol = "%", label = "Households visited")
    # })
    # 
    # output$gauge_literature_butere <- flexdashboard::renderGauge({
    #   flexdashboard::gauge(60, min = 0, max = 100, symbol = "%", label = "People reached \n with \n literature")
    # })
    
    
    # output$gauge_engagements_kamila <- flexdashboard::renderGauge({
    #   flexdashboard::gauge(200, min = 0, max = 500,  symbol = "",label = "Souls engaged \n public air meetings \n and door to door visitations")
    # })
    # 
    # output$gauge_literature_kamila <- flexdashboard::renderGauge({
    #   flexdashboard::gauge(12, min = 0, max = 500, symbol = "", label = "People reached \n with \n literature")
    # })
    
    
    output$gauge_visitations_budalangi <- renderPlotly({
      
      fig <- plot_ly(
        
        type = "indicator",
        
        mode = "gauge+number",
        
        value = 200,
        
        gauge = list(
          
          axis = list(range = list(NULL, 4113), tickwidth = 1, tickcolor = "darkblue"),
          
          bar = list(color = "darkblue"),
          
          bgcolor = "white",
          
          borderwidth = 2,
          
          bordercolor = "gray",
          threshold = list(
            
            line = list(color = "green", width = 6),
            
            thickness = 1,
            
            value = 4113)
       )) 
      
      fig <- fig %>% plotly::layout(
          
          margin = list(l=20,r=30),
          
          paper_bgcolor = "#E7E8E8",
          
          font = list(color = "darkblue", family = "Arial", size = 10))
      
      
      fig
    })
    
    output$gauge_literature_budalangi <- renderPlotly({
      fig <- plot_ly(
        
        type = "indicator",
        
        mode = "gauge+number",
        
        value = 420,
        
        #title = list(text = "Number of people reached with literature", font = list(size = 10)),
        
        #delta = list(reference = 400, increasing = list(color = "RebeccaPurple")),
        
        gauge = list(
          
          axis = list(range = list(NULL, 4113), tickwidth = 1, tickcolor = "darkblue"),
          
          bar = list(color = "darkblue"),
          
          bgcolor = "white",
          
          borderwidth = 2,
          
          bordercolor = "gray",
          threshold = list(
            
            line = list(color = "green", width = 6),
            
            thickness = 1,
            
            value = 4113)
          
          
          
       )) 
      
      fig <- fig %>% plotly::layout(
          
          margin = list(l=20,r=30),
          
          paper_bgcolor = "#E7E8E8",
          
          font = list(color = "darkblue", family = "Arial", size = 10))
      
      
      fig
    })
    
    output$gauge_visitations_kamila <- renderPlotly({
      
      fig <- plot_ly(
        
        type = "indicator",
        
        mode = "gauge+number",
        
        value = 200,
        
        gauge = list(
          
          axis = list(range = list(NULL, 500), tickwidth = 1, tickcolor = "darkblue"),
          
          bar = list(color = "darkblue"),
          
          bgcolor = "white",
          
          borderwidth = 2,
          
          bordercolor = "gray",
          threshold = list(
            
            line = list(color = "green", width = 6),
            
            thickness = 1,
            
            value = 500)
        )) 
      
      fig <- fig %>% plotly::layout(
        
        margin = list(l=20,r=30),
        
        paper_bgcolor = "#E7E8E8",
        
        font = list(color = "darkblue", family = "Arial", size = 10))
      
      
      fig
    })
    
    output$gauge_literature_kamila <- renderPlotly({
      fig <- plot_ly(
        
        type = "indicator",
        
        mode = "gauge+number",
        
        value = 12,
        
        #title = list(text = "Number of people reached with literature", font = list(size = 10)),
        
        #delta = list(reference = 400, increasing = list(color = "RebeccaPurple")),
        
        gauge = list(
          
          axis = list(range = list(NULL, 500), tickwidth = 1, tickcolor = "darkblue"),
          
          bar = list(color = "darkblue"),
          
          bgcolor = "white",
          
          borderwidth = 2,
          
          bordercolor = "gray",
          threshold = list(
            
            line = list(color = "green", width = 6),
            
            thickness = 1,
            
            value = 500)
          
          
          
        )) 
      
      fig <- fig %>% plotly::layout(
        
        margin = list(l=20,r=30),
        
        paper_bgcolor = "#E7E8E8",
        
        font = list(color = "darkblue", family = "Arial", size = 10))
      
      
      fig
    })
    
    
    
    output$gauge_visitations_butere <- renderPlotly({
      
      fig <- plot_ly(
        
        type = "indicator",
        
        mode = "gauge+number",
        
        value = 150,
        
        gauge = list(
          
          axis = list(range = list(NULL, 3000), tickwidth = 1, tickcolor = "darkblue"),
          
          bar = list(color = "darkblue"),
          
          bgcolor = "white",
          
          borderwidth = 2,
          
          bordercolor = "gray",
          threshold = list(
            
            line = list(color = "green", width = 6),
            
            thickness = 1,
            
            value = 3000)
        )) 
      
      fig <- fig %>% plotly::layout(
        
        margin = list(l=20,r=30),
        
        paper_bgcolor = "#E7E8E8",
        
        font = list(color = "darkblue", family = "Arial", size = 10))
      
      
      fig
    })
    
    output$gauge_literature_butere <- renderPlotly({
      fig <- plot_ly(
        
        type = "indicator",
        
        mode = "gauge+number",
        
        value = 40,
        
        #title = list(text = "Number of people reached with literature", font = list(size = 10)),
        
        #delta = list(reference = 400, increasing = list(color = "RebeccaPurple")),
        
        gauge = list(
          
          axis = list(range = list(NULL, 3000), tickwidth = 1, tickcolor = "darkblue"),
          
          bar = list(color = "darkblue"),
          
          bgcolor = "white",
          
          borderwidth = 2,
          
          bordercolor = "gray",
          threshold = list(
            
            line = list(color = "green", width = 6),
            
            thickness = 1,
            
            value = 3000)
          
          
          
        )) 
      
      fig <- fig %>% plotly::layout(
        
        margin = list(l=20,r=30),
        
        paper_bgcolor = "#E7E8E8",
        
        font = list(color = "darkblue", family = "Arial", size = 10))
      
      
      fig
    })
} 

# Run the application 
shinyApp(ui = app_ui, server = app_server)
