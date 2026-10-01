library(shiny)
library(leaflet)

# ---------------------------------------------------------
# Read station data
# ---------------------------------------------------------

stations <- read.csv(
  "RainList.csv",
  stringsAsFactors = FALSE
)

# ---------------------------------------------------------
# User interface
# ---------------------------------------------------------

ui <- fluidPage(
  
  leafletOutput(
    "map",
    width = "100%",
    height = "100vh"
  )
  
)

# ---------------------------------------------------------
# Server
# ---------------------------------------------------------

server <- function(input, output, session) {
  
  output$map <- renderLeaflet({
    
    leaflet(stations) %>%
      
      addTiles() %>%
      
      addCircleMarkers(
        lng = ~station_longitude,
        lat = ~station_latitude,
        radius = 8,
        stroke = TRUE,
        weight = 1,
        color = "black",
        fillOpacity = 0.8,
        
        popup = ~paste0(
          "<b>", station_name, "</b><br>",
          "Station ID: ", Label
        )
      )
  })
  
}

# ---------------------------------------------------------
# Run application
# ---------------------------------------------------------

shinyApp(
  ui = ui,
  server = server
)