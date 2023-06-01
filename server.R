movies_df <- read.csv("https://raw.githubusercontent.com/info-201b-sp23/exploratory-analysis-ayudha00/main/IMDB-Movie-Data.csv?token=GHSAT0AAAAAACAWKOPLZDDCEALPSFWLNT5SZDYGEDQ")

library(dplyr)
library(ggplot2)
library(plotly)

# Average movie rating per year
avg_rating <- movies_df %>% 
  group_by(Year) %>% 
  summarise(avg_rating = mean(Rating, na.rm = TRUE))


server <- function(input, output){
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