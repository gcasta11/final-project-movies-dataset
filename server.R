movies_df <- read.csv("https://raw.githubusercontent.com/info-201b-sp23/exploratory-analysis-ayudha00/main/IMDB-Movie-Data.csv?token=GHSAT0AAAAAACAWKOPLZDDCEALPSFWLNT5SZDYGEDQ")

library(dplyr)
library(ggplot2)
library(plotly)

# Average movie rating per year
avg_rating <- movies_df %>% 
  group_by(Year) %>% 
  summarise(avg_rating = mean(Rating, na.rm = TRUE))


server <- function(input, output){

  output$year_range <- renderText(input$movie_year)
  
  # Generate a plot of the data ----
  # Also uses the inputs to build the plot label. Note that the
  # dependencies on the inputs and the data reactive expression are
  # both tracked, and all expressions are called in the sequence
  # implied by the dependency graph.
  output$plot <- renderPlotly({
    # line graph
    avg_rating_plot <- ggplot(data = avg_rating) +
      geom_line(mapping = aes(x = Year,
                              y = avg_rating)) +
      coord_cartesian(xlim=input$movie_year)
      labs(title = "Average IMDB Movie Ratings from 2006-2016", x = "Year", y = "Average Rating")
    
    avg_rating_plotly <- ggplotly(avg_rating_plot, tooltip = "y")
    
    return(avg_rating_plotly)
  })
}


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
