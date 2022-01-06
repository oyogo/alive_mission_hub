FROM rocker/shiny-verse:latest

USER root

WORKDIR /shiny/dashboard
COPY ./www/ /shiny/dashboard/www/

COPY app.R /shiny/dashboard/
COPY ./markdown/ /shiny/dashboard/markdown/
COPY DESCRIPTION/ /shiny/dashboard/
COPY ./data/ /shiny/dashboard/data/
COPY ./R/ /shiny/dashboard/R/


RUN apt-get update -y && apt-get install apt-utils libmagick++-dev libudunits2-dev libgdal-dev libgeos-dev libproj-dev lbzip2 libsodium-dev libv8-dev -y --no-install-recommends 


RUN R -e "devtools::install_version('shiny.semantic', dependencies=T)"
RUN R -e "devtools::install_version('dplyr', dependencies=T)"
RUN R -e "devtools::install_version('ggplot2', dependencies=T)"
RUN R -e "devtools::install_version('glue', dependencies=T)"
RUN R -e "devtools::install_version('leaflet', dependencies=T)"
RUN R -e "devtools::install_version('plotly', dependencies=T)"
RUN R -e "devtools::install_version('sass', dependencies=T)"
RUN R -e "devtools::install_version('calendR', dependencies=T)"
RUN R -e "devtools::install_version('sf', dependencies=T)"
RUN R -e "devtools::install_version('flipdownr', dependencies=T)"
RUN R -e "devtools::install_version('htmlwidgets', dependencies=T)"
RUN R -e "devtools::install_version('htmltools', dependencies=T)"

# Install github packages


RUN R -e "devtools::install_github('Appsilon/shiny.react', dependencies=T)"
RUN R -e "devtools::install_github('Appsilon/shiny.fluent', dependencies=T)"
RUN R -e "devtools::install_github('Appsilon/shiny.router', dependencies=T)"
RUN R -e "devtools::install_github('trestletech/ShinyDash', dependencies=T)"
RUN R -e "devtools::install_github('mnbram/gggibbous', dependencies=T)"
RUN R -e "devtools::install_github('R-CoderDotCom/calendR', dependencies=T)"
RUN R -e "devtools::install_version('flexdashboard', dependencies=T)"


ENV PORT=3838
CMD R -e 'shiny::runApp("/shiny/dashboard", port = as.numeric(Sys.getenv("PORT")), host = "0.0.0.0")'
