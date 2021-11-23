library(tidyverse)
library(ggplot2)
#loads the data file into a dataframe
data_df <- read.csv("data/MoviesOnStreamingPlatforms_updated.csv")

movie_total <- c(3695, 4113, 1047, 922)
platform <- c("Netflix", "Prime", "Hulu", "Disney")

create_chart_3 <- function(){
  pie(movie_total, labels = platform, main="Pie Chart of The amount of movies on each platform")
}
