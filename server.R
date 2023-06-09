<<<<<<< HEAD
=======
movies_df <- read.csv("Data/IMDB-Movie-Data")

>>>>>>> fee599d1886e1e3c038289a8db4b2e1913d8dd6f
library(dplyr)
library(ggplot2)
library(plotly)
library(shiny)
library(tidyverse)


# Additional Analyses
# What is the highest-rated movie in the dataset?
highest_rated_movie <- movies_df %>% 
  filter(Rating == max(Rating, na.rm = TRUE)) %>% 
  pull(Title)

# What year was the highest-rated movie released?
max_rating_year <- movies_df %>% 
  filter(Rating == max(Rating, na.rm = TRUE)) %>% 
  pull(Year)

# What is the lowest rated movie in the dataset?
lowest_rated_movie <- movies_df %>% 
  filter(Rating == min(Rating, na.rm = TRUE)) %>% 
  pull(Title)

# What year was the lowest-rated movie released?
min_rating_year <- movies_df %>% 
  filter(Rating == min(Rating, na.rm = TRUE)) %>% 
  pull(Year)

server <- function(input, output){
  movies_df <- read.csv("IMDB-Movie-Data.csv")
  
  # Calculate the frequency of each genre
  genre_frequency <- movies_df %>% 
    count(Genre)
  
  # Seperate each genre
  separated_genres <- genre_frequency %>% 
    separate(Genre, into = c("genre1"), sep = "\\,")
  
  unique_genres <- separated_genres %>% 
    group_by(genre1) %>% 
    summarise(frequency = sum(n))
  
  filtered_data <- reactive ({
    unique_genres %>% 
    filter(frequency >= input$frequency_threshold)
})
  
  # Average movie rating per year
  avg_rating <- movies_df %>% 
    group_by(Year) %>% 
    summarise(avg_rating = mean(Rating, na.rm = TRUE))
  
  # Maximum movie rating 
  max_rating <- movies_df %>% 
    group_by(Runtime..Minutes.) %>% 
    summarise(max_rating = max(Rating, na.rm = TRUE))
  
  output$plot_1 <- renderPlotly({
    # line graph
    avg_rating_plot <- ggplot(data = avg_rating) +
      geom_line(mapping = aes(x = Year,
                              y = avg_rating)) +
      coord_cartesian(xlim=input$movie_year) +
      labs(title = "Average IMDB Movie Ratings from 2006-2016", x = "Year", 
           y = "Average Rating")
    
    avg_rating_plotly <- ggplotly(avg_rating_plot, tooltip = "y")
    
    return(avg_rating_plotly)
  })
  output$plot_2 <- renderPlotly({
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
  
  output$plot_3 <- renderPlotly({
    unique_genres <- separated_genres %>% 
      group_by(genre1) %>% 
      summarise(frequency = sum(n))
    
    filtered_data <- filtered_data()
    
    filtered_plot <- ggplot(data = filtered_data) +
      geom_col(mapping = aes(x = reorder(genre1, -frequency), y = frequency, fill = genre1)) +
      labs (title = "How Often Genres Show Up in IMDb Movies 2006-2016",
            x = "Genre",
            y = "Frequency") +
      theme(axis.text.x = element_text(angle = 60, hjust = 1)) +
      scale_y_continuous(breaks = seq(0, max(unique_genres$frequency), 50))
    
    genres_plotly <- ggplotly(filtered_plot, tooltip = "y")
    
    return(genres_plotly)
  })
  
}