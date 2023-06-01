movies_df <- read.csv("Downloads/info_201_code/IMDB-Movie-Data.csv")

library(dplyr)
library(ggplot2)
library(plotly)

# Average movie rating per year
avg_rating <- movies_df %>% 
  group_by(Year) %>% 
  summarise(avg_rating = mean(Rating, na.rm = TRUE))

# Maximum movie rating 
max_rating <- movies_df %>% 
  group_by(Runtime..Minutes.) %>% 
  summarise(max_rating = max(Rating, na.rm = TRUE))

server <- function(input, output){
  output$plot_1 <- renderPlotly({
    # line graph
    avg_rating_plot <- ggplot(data = avg_rating) +
      geom_line(mapping = aes(x = Year,
                              y = avg_rating)) +
      coord_cartesian(xlim=input$movie_year)
      labs(title = "Average IMDB Movie Ratings from 2006-2016", x = "Year", 
           y = "Average Rating")
    
    avg_rating_plotly <- ggplotly(avg_rating_plot, tooltip = "y")
    
    return(avg_rating_plotly)
  })
  output$plot <- renderPlotly({
    filtered_data <- movies_df %>% 
      filter(Runtime..Minutes.>= input$movie_runtime[1] & Runtime..Minutes. <= input$movie_runtime[2])
    runtime_plot <- ggplot(data = filtered_data) +
      geom_line(mapping = aes(
        x = Runtime..Minutes.,
        y = Rating)) +
      labs(title = "Runtime vs. Movie Rating", x = "Runtime (Minutes)", y = "Rating")
    
    runtime_plotly <- ggplotly(runtime_plot, tooltip = "y")
    
    return(runtime_plotly)
  })
  
}