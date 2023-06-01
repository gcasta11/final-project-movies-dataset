movies_df <- read.csv("https://raw.githubusercontent.com/info-201b-sp23/exploratory-analysis-ayudha00/main/IMDB-Movie-Data.csv?token=GHSAT0AAAAAACAWKOPLZDDCEALPSFWLNT5SZDYGEDQ")

library(shiny)

ui <- fluidPage(
  # App title ----
  titlePanel("Exploring IMDb Hollywood Movies from 2006 to 2016"),
  
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    
    # Sidebar panel for inputs ----
    sidebarPanel(
      
      # Input: Slider for the number of observations to generate ----
      sliderInput("movie_year",
                  "Year:",
                  value = c(min(movies_df$Year), max(movies_df$Year)),
                  min = min(movies_df$Year),
                  max = max(movies_df$Year),
                  step = 1)
    ),
    
    # Main panel for displaying outputs ----
    mainPanel(
      
      plotlyOutput(outputId = "plot")
      
    )
  )
)