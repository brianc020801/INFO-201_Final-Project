#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library("dplyr")
library(ggplot2)


movieData <- read.csv("MoviesOnStreamingPlatforms_updated.csv")
movieData <- movieData %>%
  mutate(IMDb = as.numeric(substr(na.omit(IMDb), 0, 3)),
         Rotten.Tomatoes = as.numeric(substr(na.omit(Rotten.Tomatoes), 0, 2)))

ui <- shinyUI(navbarPage(
  "Movies On Streaming Services",
  tabPanel(
    "Introduction",
    h3("Introduction:"),
    p(
      "The dataset that we used on the project contains all movies available on the four main 4 streaming services which are:
      Netflix, Hulu, Amazon Prime, and Disney+. This dataset contains 9515 movies all of which stream to at least one of the four main streaming services. Most however were only one one
      streaming service with only 7 movies being on all streaming services. We are going to explore different relationships and stats with the movies,
      such as recommend age, rating, IMDB rating, Rotten Tomatoes rating, the difference between the two ratings, and the year released."
    ),
    p("The three interactives for this project are,
      a comparison between a movie age recommendation and the rating that movie received on IMDb. 
      A comparison between the year the movie came out and its IMDb rating.
      With the last one being a comparison between the language the movie was in and its IMDb rating."),
    p("The Age vs Rating interactive allows users to select two age ratings from the list provided and then can see and compare the average IMDb rating from a movie with that rating.
      The Year vs Rating interactive allows users to select a range of years with the earliest year being 1941 and the latest year being 2021, users then will select what streaming service they want to see compared.
      This will show viewers a scatterplot of movies with the year they came out being the x-axis and the IMDb rating they reviewed being the y axis.
      The final interactive of Language vs Rating allows users to type in a language and see in a scatterplot a comparison of IMDb and Rotten Tomatoes ratings of the movies in that language."),
    p("Finally the project attempts to look into and analyze comparisons between different features of a movie and what ratings it achieved.
      The first interactive of Age vs Rating attempts to see how age recommendations affect movie ratings, like will movies made for adults be rated higher than movies made for kids?
      The second interactive looks to see how movies are rated compared to the year they came out, we can use this to see if movies in a specific year or decade were rated higher or lower and can look for reasons why.
      Finally, the last interactive looks to see if a movie language affects its rating in both IMDb and Rotten Tomatoes."),
    tags$style(
      "p {color: black;
          font-style:bold;
          font-family: Rockwell;
          font-size: 20px}",
      ".navbar {background-color: white}",
      "body {background-color: #FF7E76; }"
    ),
    tags$img(
      src = "https://editor.analyticsvidhya.com/uploads/58713tvshows1.jpeg",
      height = "90%",
      width = "90%"
    )
  ),
  tabPanel(
    "Interactives",
    tabsetPanel(
      tabPanel(
        "Age vs Rating",
        sidebarLayout(
          sidebarPanel(
            selectInput(
              "age",
              label = h3("Age Rating 1"),
              choices = movieData$Age
            ),
            selectInput(
              "age2",
              label = h3("Age Rating 2"),
              choices = movieData$Age
            )
          ),
          
          mainPanel(plotOutput("ageRatePlot"))
        ),
        tags$img(
          src = "https://www.mmobomb.com/file/2018/02/ESRB-ratings.jpg",
          height = "70%",
          width = "70%"
        )
      ),
      tabPanel(
        "Year vs Rating",
        sidebarLayout(
          sidebarPanel(
            sliderInput(
              "year",
              label = h3("Year"),
              min = 1941,
              max = 2021,
              value = c(1941, 2021), 
              sep = ""
            ),
            radioButtons(
              "service",
              label = h3("Services"),
              choices = list(
                "Netlix" = 1,
                "Hulu" = 2,
                "Amazon" = 3,
                "Disney+" = 4
              ),
              selected = 1
            )
          ),
          mainPanel(plotOutput("yearRatePlot"))
        ),
        tags$img(
          src = "https://upload.wikimedia.org/wikipedia/commons/6/69/IMDB_Logo_2016.svg",
          height = "70%",
          width = "70%"
        )
      ),
      tabPanel("Language vs Rating",
               sidebarLayout(
                 sidebarPanel(textInput(
                   "language", label = h3("Language"), value = "English"
                 )),
                 mainPanel(plotOutput("languageRatePlot"))
               ), tags$img(
                 src = "https://mycroft.ai/wp-content/uploads/2018/05/languages-edited.png",
                 height = "70%",
                 width = "70%"
               ))
    )
  ),
  tabPanel("Summary", 
      tableOutput("table"),
          h3("Summary:"),
           p("The goal of this project was to compare different aspects of movies and how those aspects affect ratings.
             The dataset that we found for this project gave us 9515 movies from the four major streaming services of Netflix, Amazon Prime, Hulu, and Disney Plus.
             The dataset also gave us key aspects of the movie, like what year it came out, the rating it received on IMDb and Rotten Tomatoes, the language of the movie, the age rating of the movie, and more.
             "),
          p("From the first interactive the thing that we took away was that the age rating of the movie has very little effects on the rating that movie gets.
            All categories of age ratings had similar average movie ratings with it being around an average of 6/10 on IMDb.
            Age probably does not have a huge effect on movies ratings as people who rate movies probably rate movies with the intended audience in mind, as well have people in the age rating of the movie give their opinions.
            "),
          p("Some takeaways from the second interactive are that most of the movies in this dataset come from more modern times and within the last 20 years.
            This makes sense as almost all movies released now will eventually end up on one of the streaming platforms. 
            This is not the case with movies that came out before the streaming era and now many movies besides very popular ones or ones owned by the streaming service, will not be available to stream.
            For the number of movies, it looks like Amazon has the most movies on its streaming service and has the oldest movies available on the platform.
            Then comes the other three which have a similar number of movies available, with Disney plus having more old movies and Hulu and Netflix having more new movies.
            In terms of comparing a movie release date to its IMDb rating, it is really hard to make any substantial analysis from the data.
            First, it is hard to compare movie rating with the year it was released in this dataset due to the limited amount of old movies on streaming services.
            So more recent years will show a lot more films but also a bigger range of films compared to their IMDb rating.
            Finally, throughout the years' movie ratings have been similar with a lot of movies being in a range of 4.5 to 7.5 with only a few exceptions every year/couple of years.
            "),
            p("For the last interactive some takeaways that we got is that English has the most movies with Spanish coming in second.
              Also as this interactive compares IMDb rating to Rotten Tomatoes rating we can see differences between the ratings.
              When looking at the differences it shows that most movies are similarly rated between the two platforms with a lot being within a 10-15 difference range.
              Finally, it shows that most movies are within a range of 4/40 to 7.5/75 rating which means that most movies are rated very mid or average with very few being rated above 8/80.
              "),
      tags$style(
        "p {color: black;
          font-style:bold;
          font-family: Rockwell;
          font-size: 20px}",
        ".navbar {background-color: white}",
        "body {background-color: #FF7E76; }"
      ),
      tags$img(
        src = "https://www.howtogeek.com/wp-content/uploads/2020/12/person-hold-a-remote-while-streaming-movies.jpg?width=1198&trim=1,1&bg-color=000&pad=1,1",
        height = "90%",
        width = "90%")
           )
))
server <- function(input, output) {
  data <- reactive({
    m <- movieData %>% filter(
      Year >= input$year[1],
      Year <= input$year[2],
      Netflix == input$service |
        Hulu == input$service |
        Prime.Video == input$service | Disney. == input$service
    )
  })
  
  output$yearRatePlot <- renderPlot({
    ggplot(data(), aes(x = Year, y = IMDb)) + geom_point(size = 2, colour = "orange") + xlab("Year") + ylab("IMDb Rating")
  })
  
  data2 <- reactive({
    req(input$age)
    m2 <-
      movieData %>% filter(Age == input$age |
                             Age == input$age2) %>% group_by(Age) %>% summarise(AvgRating = mean(na.omit(IMDb)))
  })
  
  output$ageRatePlot <- renderPlot({
    ggplot(data2(), aes(x = Age, y = AvgRating, fill = Age)) + geom_bar(stat = "identity") + xlab("Recommended Age") + ylab("Average IMDb Rating")
  })
  
  data3 <- reactive({
    req(input$language)
    m3 <-
      movieData %>% filter(tolower(Language) %in% tolower(input$language))
  })
  
  output$languageRatePlot <- renderPlot({
    ggplot(data3(), aes(x = Rotten.Tomatoes, y = IMDb)) + geom_point(size = 1.5, colour = "#CE94FF") + xlab("Rotten Tomatoes Rating") + ylab("IMDb Rating")
  })
}

# Run the application
shinyApp(ui = ui, server = server)
