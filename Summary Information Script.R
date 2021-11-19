library(dplyr)
library(stringr)
streaming_data <- read.csv("Documents/Info201/final-project/data/MoviesOnStreamingPlatforms_updated.csv")
View(streaming_data)


num_observations <- nrow(streaming_data)
most_movies_location_number <- sort(table(streaming_data$Country),decreasing=TRUE)[1:1]
most_movies_location <- tail(names(sort(table(streaming_data$Country))), 1)
print(paste0("There are ", num_observations, " rows in this dataset and the most number of movies in a country is the "
               , most_movies_location, " with ", most_movies_location_number, " movies."))


least_movies_location_number <- sort(table(streaming_data$Country),increasing=TRUE)[1:1]
least_movies_location <- head(names(sort(table(streaming_data$Country))), 1)
print(paste0("The least number of movies in a country is the "
             , least_movies_location, " with ", least_movies_location_number, " movies."))

most_movies_year_number <- sort(table(streaming_data$Year),decreasing=TRUE)[1:1]
most_movies_year <- tail(names(sort(table(streaming_data$Year))), 1)
print(paste0("The year with the most number of movies is "
             , most_movies_year, " with ", most_movies_year_number, " movies."))

least_movies_year_number <- sort(table(streaming_data$Year),increasing=TRUE)[1:1]
least_movies_year <- head(names(sort(table(streaming_data$Year))), 1)
print(paste0("The year with the least number of movies is "
             , least_movies_year, " with ", least_movies_year_number, " movies."))

streaming_data$movies_on_all_services <- (streaming_data$Netflix == 1 & streaming_data$Hulu == 1 & streaming_data$Prime.Video == 1)
number_on_all_services <- table(streaming_data$movies_on_all_services)["TRUE"]
print(paste0("There are ", number_on_all_services, " movies that are on all streaming platforms excluding Disney plus"))

streaming_data$rating_difference <- streaming_data$Rotten.Tomatoes - streaming_data$Rotten.Tomatoes


streaming_data$IMDb_numeric_100 <- c(str_sub(streaming_data$IMDb, 1,3))
streaming_data$IMDb_numeric_100 <- as.numeric(streaming_data$IMDb_numeric_100)
streaming_data$IMDb_numeric_100 <- streaming_data$IMDb_numeric_100 * 10

streaming_data$RT_numeric_100 <- c(str_sub(streaming_data$Rotten.Tomatoes, 1,2))
streaming_data$RT_numeric_100 <- as.numeric(streaming_data$RT_numeric_100)

streaming_data$differences <- streaming_data$IMDb_numeric_100 - streaming_data$RT_numeric_100
streaming_data$differences <- abs(streaming_data$differences)
streaming_data$differences <- as.integer(streaming_data$differences)
max(streaming_data$differences, na.rn = 0)

most_difference_movie_name <- head(names(sort(table(streaming_data$Title[streaming_data$differences == 52 ]))), 1)
most_difference_movie_name
print(paste0("The Movie ", most_difference_movie_name, " has the highest difference between IMDb and Rotten Tomatoes with the difference being 52" ))

least_difference_movie_name <- tail(names(sort(table(streaming_data$Title[streaming_data$differences == 0 ]))), 1)
least_difference_movie_name
print(paste0("The Movie ", least_difference_movie_name, " is tied for the lowest difference between IMDb and Rotten Tomatoes with the difference being 0" ))
