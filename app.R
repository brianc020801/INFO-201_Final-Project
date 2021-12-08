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
      "The dataset used is a dataset containing all the movies available on 4 streaming services:
      Netflix, Hulu, Amazon Prime, Disney+. We are going to explore different relationships of the movie and its ratings,
      such as age recommended and rating, IMDB rating vs Rotten Tomatoes rating, or the year released and its ratings."
    ),
    tags$style(
      "p {color: black;
          font-style:bold;
          font-family: Rockwell;
          font-size: 20px}",
      ".navbar {background-color: white}",
      "body {background-color: #FF7E76; }"
    ),
    tags$img(
      src = "https://netbasequid.com/wp-content/uploads/streaming-services-market-landscape-hero737c.jpg",
      height = "90%",
      width = "90%"
    )
  ),
  tabPanel("Interactives",
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
                     value = c(1941, 2021)
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
             tabPanel(
               "Language vs Rating",
               sidebarLayout(sidebarPanel(
                 textInput("language", label = h3("Language"), value = "English")
               ),
               mainPanel(plotOutput("languageRatePlot"))),
               tags$img(
                 src = "https://mycroft.ai/wp-content/uploads/2018/05/languages-edited.png",
                 height = "70%",
                 width = "70%"
               )
             )
             
           )),
  tabPanel("Summary", tableOutput("table"))
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
    ggplot(data2(), aes(x = Age, y = AvgRating, fill = Age)) + geom_bar(stat = "identity") + xlab("Year") + ylab("Average IMDb Rating")
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
