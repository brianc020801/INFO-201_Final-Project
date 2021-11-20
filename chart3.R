library(tidyverse)
library(ggplot2)
#loads the data file into a dataframe
data_df <- read.csv("data/MoviesOnStreamingPlatforms_updated.csv")

movie_total <- c(3695, 4113, 1047, 922)
platform <- c("Netflic", "Prime", "Hulu", "Disney")
pie(movie_total, labels = platform, main="Pie Chart of The amount of movies on each platform")
