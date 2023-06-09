<<<<<<< HEAD
library(shiny)
library(bslib)
library(ggplot2)
library(plotly)
library(dplyr)
library(tidyverse)

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



# Average movie rating per year
avg_rating <- movies_df %>% 
  group_by(Year) %>% 
  summarise(avg_rating = mean(Rating, na.rm = TRUE))

# Maximum movie rating 
max_rating <- movies_df %>% 
  group_by(Runtime..Minutes.) %>% 
  summarise(max_rating = max(Rating, na.rm = TRUE))
=======
movies_df <- read.csv("Data/IMDB-Movie-Data")

library(shiny)
library(bslib)
library(dplyr)
library(ggplot2)
library(plotly)
library(tidyr)
>>>>>>> fee599d1886e1e3c038289a8db4b2e1913d8dd6f


my_theme <- bs_theme(bg = "#fcf9dc",
                     fg = "#120800",
                     primary = "#a89f99"
                     )

ui <- navbarPage(
  theme = my_theme,
  title = "Exploring IMDb HollyWood Movies from 2006 to 2016",
  id = "nav",
  tabPanel("Introduction",
    fluidPage(
     mainPanel(
       img(src = "imdb_pic.jpeg"),
       h1("Introduction"),
       p("Media continues to play an active role in the development and ",
       "evolution of society to date. Because of our severe advancements ",
       "in technology, streaming popular movies is easier than ever. Media ",
       "is now more accessible than ever and",
       tags$a(href="https://www.imdb.com/", "IMDB"),
       " plays a major role in today's media data. Now that more and more people are ",
       "having access to content on the internet, it is important to take ",
       "notice of which movies are being preferred, rated, and consistently ",
       "viewed. We are hoping to answer some main questions: 1) What is the average
       movie ratings per year? What years have the highest and lowest average? 2) Is 
       there a relationship between the runtime (in minutes)
       and the movie ratings?, 3) What genres are the most frequently shown?"),
       br(),
       p("Our team analyzed the dataset,",
       tags$a(href="https://www.kaggle.com/datasets/PromptCloudHQ/imdb-data)", em("IMDB Data drom 2006 to 2016,")),
       "to answer these questions. In this dataset, ",
       "we will continue to monitor genre, revenue, actors, and metascore, ",
       "in order to accurately assess whether the most popular and highly ",
       "ranked movies are made by the same director, as well as the same actors."),
       h3("The Dataset"),
       p("This dataset displays 1000 of the most popular movies on ",
         "IMDB in the years 2006-2016.The data was posted and created by PromtCloud and was collected ",
         "from the IMDB website. PromptCloud is a web data crawling and ",
         "extraction company. According to the company's LinkedIn, ",
         "PromtCloud uses cloud computing and machine-lerning techniques ",
         "to collect their data. The data set contains 1000 observations ",
         "(rows) of the movies and 12 features (columns). The features ",
         "include: Rank, Movie Title, Genre, Movie Description, ",
         "Director, Actors, Year, Runtime in Minutes, User Rating, and ",
         "Number of Votes. Any data set can somehow be improved, so ",
         "there are some potential limitations or problems with this ",
         "data. Some of the features could be elaborated more. For example, ",
         "it may be helpful to adreess the clear definitions and distinguish ",
         "between the Ratings vs. Metascore features. Additionally, this data ",
         "is outdated as it was posted six years ago on Kaggle. ",
         "Furthermore, the Revenue and Metascore columns include some NA values. ",
         "However, even with these limitations, it is an interesting ",
         "and fitting data set to be utilized for this project."),
       h4("Implications"),
       p("This dataset does not include all Hollywood movies made ",
         "from 2006 to 2016. With this in mind, we cannot accurately ",
         "conclude if the summary statistics, found above, actually apply ",
         "to cinema as a whole. Any biases, implications, or agendas that ",
         "the data collectors of this dataset used during the collection, ",
         "cleaning, and publishing of this dataset, are not usually ",
         "noticeable to the naked eye, considering the amount of observations ",
         "found in this dataset. It is important to note that there may be a ",
         "skewed amount of genres, directors, and actors featured in this ",
         "dataset, making it difficult to fully conclude the highest rated ",
         "and least rated Hollywood movies and genres. This will also make ",
         "it difficult to draw connections based on the year, genre, and ",
         "ranking for each observation found in this dataset."),
       h4("Limitations & Challenges"),
       p("With any dataset, it can be difficult to interpret data ",
         "without actually collecting it. When we analyze data sets as ",
         "strangers, we are not aware of possible biases that were used and ",
         "assumed when reviewing research on specific data that we did not ",
         "collect. By not knowing how certain data was cleaned, we run the ",
         "risk of making incorrect assumptions, based on the data we were ",
         "presented. Because of this, a concrete and factual answer to our main ",
         "hypothesis will be difficult to attain. Another possible limiting factor ",
         "would be that the dataset we are using is solely referencing 1,000 movies ",
         "out of the thousands of movies that have been made, during the 10-year range ",
         "that was being studied. This lowers the margin of error for the ",
         "probability of finding gender bias in the audience of certain movies ",
         "and in certain genres since the data set does not encompass ",
         "all movies made from 2006 to 2016."),
       h4("Related Work"),
       p("According to 'IMDb Announces Top 10 Movies and Series of 2022' ",
         "from Business Wire, IMDb is the most popular website for ",
         "information about movies, shows, and celebrities. IMDb ",
         "determines their ranking lists based on page views of visitors ",
         "to IMDb. IMDbPro movie and TV rankings collects data and updates ",
         "weekly throughout the year. IMDb has lists for the top 10 movies of ",
         "2022 as well as TV and streaming series. In the Kaggle dataset ",
         "'IMDB Movies Dataset' by Harshit Shankhdhar, features linked ",
         "include the poster link to the movie, name of the movie, year ",
         "released, certificate of the movie, runtime, genre, IMDb rating, ",
         "overview, metascore, and director name. This dataset does not ",
         "have the ranking like the 'IMDB data from 2006 to 2016' dataset ",
         "but both datasets have a column for rating, runtime, year, ",
         "director name, description, genre, and name. According to ",
         "'What Is IMDb?' by Stacy Fisher of Lifewire, movie and TV ",
         "show pages on IMDb include features such as plot synopsis, ",
         "plot summary, storyline, cast information, review scores, ",
         "tagged genres, images, videos, nominations, similar titles, ",
         "box office details, runtime, trivia, frequently asked questions, ",
         "user reviews, quotes, and others. Users may also build their own ",
         "watchlists to organize movies and shows they are interested in. ",
         "Overall, IMDb is a large hub that contains a variety of ",
         "information relating to movies and TV shows. The database 'IMDB ",
         "data from 2006 to 2016' will be used to analyze data that users ",
         "have contributed to (rating and votes).",
       p("Fisher, Stacy. “What Is IMDb?” Lifewire, Lifewire, 20 Sept 2022",
           tags$a(href="https://www.lifewire.com/internet-movie-database-3482288", "https://www.lifewire.com/internet-movie-database-3482288.")),
       p("'IMDb Announces Top 10 Movies and Series of 2022.” Business ",
           "Wire, 12 Dec. 2022, ",
           tags$a(href="https://www.lifewire.com/internet-movie-database-3482288", "https://www.lifewire.com/internet-movie-database-3482288."))
     )
    )
    )
  ),
  tabPanel("Average Ratings",
    fluidPage(
      h1("Average IMDB Movie Ratings over Time"),
      p("This line graph below displays how the average rating of IMDB movies change 
            over time from 2006-2016. The plot shows that 2007 is the year with the highest 
            average movie rating while 2016 is the year with the lowest average movie 
            rating. We can observe that as the year increases, the average IMDB movie ratings
            decreases. In other words, there is a negative relationship between the year and
            the average rating of IMDB movies. Feel free to use the slider tool below to 
            get a closer look between years!"),
      sidebarLayout(
        sidebarPanel(
          sliderInput("movie_year",
                      "Year:",
                      value = c(min(movies_df$Year), max(movies_df$Year)),
                      min = min(movies_df$Year),
                      max = max(movies_df$Year),
                      step = 1),
          ),
        mainPanel(
          plotlyOutput(outputId = "plot_1")
        )
      )
    )
  ),
  tabPanel("Runtime vs. Ratings",
    fluidPage(
      h1("Runtime of the Highest Ranked Movies"),
      p("The graph below displays runtime of the highest ranked movies in the IMDb 
      dataset from 2006 to 2016. With this graph, we are able to observe a positive 
      relationship between the highest ranked Hollywood movies, and movies with 
      longer runtime, in minutes."),
      sidebarLayout(
        sidebarPanel(
          sliderInput("movie_runtime", "Select Runtime: ",
          min = min(movies_df$Runtime..Minutes.),
          max = max(movies_df$Runtime..Minutes.),
          value = c(min(movies_df$Runtime..Minutes.), max(movies_df$Runtime..Minutes.))
          ),
        actionButton("update_button", "Update Plot"
                     ),
        ),
        mainPanel(
         plotlyOutput(outputId = "plot_2")
        )
      )
    )
  ),
  tabPanel("Genres",
    fluidPage(
      h1("Most Loved Genres of Hollywood Movies, 2006-2016"),
      p("This graph shows how often genres show up in movies found on IMDB from 
        2006-2016. This will tell us what types of movies coming out of Hollywood 
        are the most popular. There is not much diversity regarding genres as most 
        Hollywood movies are Action, drama, or comedy movies. "),
     sidebarLayout(
       sidebarPanel(
         sliderInput("frequency_threshold", "Frequency Threshold: ",
                     min = 0, max = max(unique_genres$frequency),
                     value = 50),
         actionButton("update_button", "Update Plot")
       ),
       mainPanel(
         plotlyOutput(outputId = "plot_3")
       )
     )
    )
  ),
  tabPanel("Conclusion",
    fluidPage(
      mainPanel(
        h1("Summary Takeaways"),
<<<<<<< HEAD
        p("First, we found that the highest-rated movie is _The ",
          "Dark Knight_, while _Disaster Movie_ is the lowest-rated movie ",
          "on IMDB from 2006-2016. Interestingly, both of those movies were ",
          "released in 2008. Next, we discovered that the year with the ",
          "highest average IMDB movie rating is 2007 while the lowest is 2016. ",
          "Next, we found that Thrillers are the most highly ranked genre. ",
          "We also noticed that Adam Wingard is the director that is most ",
          "frequently seen in this dataset. "),
=======
        p("After our analysis, we are able to answer our three main questions. 
        Our first graph shows the average IMDB movie ratings per year, answering 
        our ", strong("first question."), "The year with the highest average movie 
        rating is 2007 while 2016 is the year with the lowest. There seems to be a 
        negative relationship between the year and average movie ratings. We 
        thought this was an interesting finding because some would expect the 
        opposite. You would think that more recent movies have more technology 
        to work with. Our second graph shows that there is a positive relationship 
        between the movie runtime in minutes and the movie ratings. This answers 
        our ", strong("second question."), "The trend displays that the longer a 
        movie is, the higher the ratings are generally. This was also surprising 
        to us considering that longer movies could really be dragging. However, 
        it could be that more money and effort is put into a movie that has a 
        longer runtime in minutes. Lastly, our third graph shows that Action movies are the 
        most frequent and the most popular movie genre, while romance is the 
        least popular. This answers our", strong("third question."), "The action 
        movie genre is on the data set with a frequency of 293, following Drama 
        with 193, and comedy with 175. It makes sense that action is a very 
        frequent movie genre as it seems like it is also the most talked about 
        usually. Furthermore, our analysis shows that the highest-rated movie 
        is", em("The Dark Knight"), " while the lowest-rated movie is", em("The 
        Disaster Movie"), "Interestingly, both of those movies were released 
        in the year 2008."),
>>>>>>> fee599d1886e1e3c038289a8db4b2e1913d8dd6f
         h1("Analysis Discussion"),
        p("Interpreting the results and contextualizing the conclusions of",
          "a data analysis requires a familiarity with the dataset. In this",
          "case that means understanding the part that the IMDB website plays", 
          "in the wider cinematic landscape. The IMDB ratings are user",
          "generated and are subject to the usual forces that influence all",
          "kinds of internet reviews. Since users must search up a specific",
          "movie on the internet they are much more likely to leave a review", 
          "on a movie they have strong feelings (positive or negative) for,",
          "compared to a movie they thought was just okay. This trend toward", 
          "very positive and very negative reviews can be seen almost",
          "everywhere on the internet, and it is certainly something will",
          "affect any analysis of IMDB movie ratings. Another factor in a", 
          "movie's placementis the number of reviews and the amount of traffic", 
          "an IMDB movie page receives. Movies with broad appeal and a less",
          "restrictive age rating will be seen and reviewed by a larger",
          "audience, which could in turn impact the genre frequencies we",
          "look at with our analysis."),
        h1("Broader Implications"),
        p("Cinema is a form of art that often reflects the values of the",
          "society which produces it. Often movies are used by their",
          "creators to shine a light on a particular aspect of our ",
          "society, or on a specific character and their place",
          "in the world. Because movies are a from of art—with the",
          "usual subjectivity accompanying creative pursuits—it is difficult",
          "to rate them with a purely numeric scale. Though our group looked",
          "at many facets of the data in the set, like genre, actors and",
          "directors, year of release, in addition to ratings, it is", 
          "still very difficult to draw conclusions about gender bias.",
          "For example, if a particular male director appears in the dataset",
          "numerous times, is that due to gender biases in the way we produce",
          "and consume cinema, or is that simply an artist",
          "being rewarded with more opportunity as a result of their",
          "previous success?")
        )
      )
  )
)
