#' The application User-Interface
#'
#' @param request Internal parameter for `{shiny}`.
#'     DO NOT REMOVE.
library(shiny.react)
library(shiny.semantic)
library(dplyr)
library(ggplot2)
library(glue)
library(leaflet)
library(plotly)
library(sass)
library(shiny)
library(shiny.fluent)
library(shiny.router)
library(calendR)
library(leaflet)
library(sf)
library(flipdownr)
library(ShinyDash)
library(htmlwidgets)
library(htmltools)
library(flexdashboard)


#library(fullcalendar)


source("R/mod_home.R")
source("R/mod_butere_mission.R")
source("R/mod_kamila_mission.R")


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
            CommandBarItem("New", "Add", subitems = list(
                CommandBarItem("Email message", "Mail", key = "emailMessage", href = "mailto:me@example.com"),
                CommandBarItem("Calendar event", "Calendar", key = "calendarEvent")
            )),
            CommandBarItem("Upload request form", "Upload"),
            #CommandBarItem("Share page", "Share"),
            CommandBarItem("Download mission booklet", "Download")
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


kasei_page <- makePage(
  "Kasei mission",
  "statistics about the mission",
  h3("kasei details")
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

map_page <- makePage(
    "Map of either potential sites",
    "dropdown select of mission sites",
    h3("Show spatial data on mission sites")
)




router <- make_router(
  #route("/", home_page),
  route("home", shiny::div(mod_home_ui("home_ui_1"))),
  route("missions_page", missions_page),
  #route("kasei_page", kasei_page),
  route("kamila_page", shiny::div(mod_kamila_ui("kamila_ui_1"))),
  route("kiwawa_page", kiwawa_page),
  route("butere_page", div(mod_butere_ui("butere_ui_1"))),
  route("kacheliba_page", kacheliba_page),
  route("projects_page",projects_page),
  route("mission_stories_page",mission_stories_page),
  route("map_page",map_page))

navigation <- Nav(
    groups = list(
        list(links = list(
            list(name = 'Home', url = '#!/home', key = 'home', icon = 'Home'),
            list(name = 'Rural missions', url = '#!/missions_page', key = 'missions',
                 expandAriaLabel = "Expand Home section",
                 collapseAriaLabel = "Collapse Home section",
                 links = list(
                   list(
                     name = "Kamila",
                     url = '#!/kamila_page',
                     #disabled = TRUE,
                     key = "kamila"
                     #target = "_blank"
                   ),
                   
                   list(
                     name = "Butere",
                     url = '#!/butere_page',
                     #disabled = TRUE,
                     key = "butere"
                     #target = "_blank"
                   ),
                     list(
                         name = "Kiwawa",
                         url = '#!/kiwawa_page',
                         #disabled = TRUE,
                         key = "kiwawa"
                         #target = "_blank"
                     ),
                     list(
                       name = "Kasei",
                       url = '#!/kasei_page',
                       #disabled = TRUE,
                       key = "kasei"
                       #target = "_blank"
                     ),
                     
                     list(
                       name = "Kacheliba",
                       url = '#!/kacheliba_page',
                       #disabled = TRUE,
                       key = "kacheliba"
                       #target = "_blank"
                     )
                     
                 ),
                 isExpanded = TRUE),
            list(name = 'Projects', url = '#!/projects_page', key = 'projects', icon = 'GitGraph'),
            list(name = 'Mission stories', url = '#!/mission_stories_page', key = 'shinyreact', icon = 'GitGraph'),
            list(name = 'Map', url = '#!/map_page', key = 'map_page', icon = 'WebAppBuilderFragment')
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
    
    # output$map2 <- renderLeaflet({
    #   
    #   leaflet() %>%
    #     setView(lat = 2.05696,lng = 35.10244,zoom = 9) %>%
    #     addTiles() %>%
    #     addMarkers(lng = 35.10244,
    #                lat = 2.05696, label = "Kamila",
    #                labelOptions = labelOptions(noHide = T, direction = "bottom")) %>%
    #    
    #     addMiniMap(width = 90,height = 80) 
    #   
    # })
    # 
    output$gauge_visitations <- flexdashboard::renderGauge({
      flexdashboard::gauge(40, min = 0, max = 100, symbol = "%", label = "Households visited")
    })

    output$gauge_literature_butere <- flexdashboard::renderGauge({
      flexdashboard::gauge(60, min = 0, max = 100, symbol = "%", label = "People reached \n with \n literature")
    })
    
    
    output$gauge_engagements_kamila <- flexdashboard::renderGauge({
      flexdashboard::gauge(200, min = 0, max = 500,  symbol = "",label = "Souls engaged \n public air meetings \n and door to door visitations")
    })
    
    output$gauge_literature_kamila <- flexdashboard::renderGauge({
      flexdashboard::gauge(12, min = 0, max = 500, symbol = "", label = "People reached \n with \n literature")
    })
    
    # 
    # output$children_class_hist <- renderPlot({
    #   
    #  
    #   df <- data.frame(
    #     attendance <- c(23,33,23,54,44,34,34,55,34,23,23,12,21,21,23,21,43,23,22,27,26,25,24,24,14,22)
    #   )
    #   
    #   ggplot(df,aes(x=attendance)) + geom_histogram(binwidth = 10)
    #   
    # })
    
} 

# Run the application 
shinyApp(ui = app_ui, server = app_server)
