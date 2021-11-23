library(tidyverse)
library(ggplot2)
#loads the data file into a dataframe
data_df <- read.csv("data/MoviesOnStreamingPlatforms_updated.csv")

#Mutates the rating rows into data types that are easy for calculations
data_df <- data_df %>% 
  mutate(IMDb = as.double(substr(na.omit(IMDb), 0, 3)), Rotten.Tomatoes = as.double(substr(na.omit(Rotten.Tomatoes), 0, 2)))

## Netflix rotten tomato ratings
Netflix_certifiedFresh <- data_df %>%
  group_by(Netflix) %>%
  summarise(Provider = "Netflix",
            rating_certifiedFresh = Rotten.Tomatoes > 75) %>%
  filter(rating_certifiedFresh == TRUE) %>%
  filter(Netflix == 1) %>%
  nrow() #279

Netflix_fresh <- data_df %>%
  group_by(Netflix) %>%
  summarise(Provider = "Netflix",
            over_60 = Rotten.Tomatoes > 60 & Rotten.Tomatoes < 75) %>%
  filter(over_60 == TRUE) %>%
  filter(Netflix == 1) %>%
  nrow() #813

Netflix_rotten <- data_df %>%
  group_by(Netflix) %>%
  summarise(Provider = "Netflix",
            rating_rotten = Rotten.Tomatoes < 59) %>%
  filter(rating_rotten == TRUE) %>%
  filter(Netflix == 1) %>%
  nrow() #2355

## Amazon Prime rotten tomato ratings
Prime_certifiedFresh <- data_df %>%
  group_by(Prime.Video) %>%
  summarise(Provider = "Amazon Prime",
            rating_certifiedFresh = Rotten.Tomatoes > 75) %>%
  filter(rating_certifiedFresh == TRUE) %>%
  filter(Prime.Video == 1) %>%
  nrow() #105

Prime_fresh <- data_df %>%
  group_by(Prime.Video) %>%
  summarise(Provider = "Amazon Prime",
            over_60 = Rotten.Tomatoes > 60 & Rotten.Tomatoes < 75) %>%
  filter(over_60 == TRUE) %>%
  filter(Prime.Video == 1) %>%
  nrow() #663

Prime_rotten <- data_df %>%
  group_by(Prime.Video) %>%
  summarise(Provider = "Amazon Prime",
            rating_rotten = Rotten.Tomatoes < 59) %>%
  filter(rating_rotten == TRUE) %>%
  filter(Prime.Video == 1) %>%
  nrow() #3145

## Hulu rotten ratings
Hulu_certifiedFresh <- data_df %>%
  group_by(Hulu) %>%
  summarise(Provider = "Amazon Prime",
            rating_certifiedFresh = Rotten.Tomatoes > 75) %>%
  filter(rating_certifiedFresh == TRUE) %>%
  filter(Hulu == 1) %>%
  nrow() #104

Hulu_fresh <- data_df %>%
  group_by(Hulu) %>%
  summarise(Provider = "Hulu",
            over_60 = Rotten.Tomatoes > 60 & Rotten.Tomatoes < 75) %>%
  filter(over_60 == TRUE) %>%
  filter(Hulu == 1) %>%
  nrow() #394

Hulu_rotten <- data_df %>%
  group_by(Hulu) %>%
  summarise(Provider = "Hulu",
            rating_rotten = Rotten.Tomatoes < 59) %>%
  filter(rating_rotten == TRUE) %>%
  filter(Hulu == 1) %>%
  nrow() #466
  
## this is a dumb way doing it, but sorta ran out of time
arranging = data.frame(
  platform = c('Netflix', 'Netflix', 'Netflix', 'Prime', 'Prime', 'Prime','Hulu', 'Hulu', 'Hulu'),
  ratings = c('Certified Fresh','Fresh','Rotten','Certified Fresh','Fresh','Rotten','Certified Fresh','Fresh','Rotten'),
  numbers = c(Netflix_certifiedFresh, Netflix_fresh, Netflix_rotten, 
              Prime_certifiedFresh, Prime_fresh, Prime_rotten,
              Hulu_certifiedFresh, Hulu_fresh, Hulu_rotten)
)

create_chart_1 <- function(){
  ggplot(arranging, aes(x =ratings, y = numbers, fill = platform))+
    geom_bar(stat = 'identity', position = 'dodge')+
    labs(title = "Rotten Tomato Rating Distribution from each service", x = "Ratings", y = "Number of Movies")
}










