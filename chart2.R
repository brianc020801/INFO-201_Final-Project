library(tidyverse)
library(ggplot2)
#loads the data file into a dataframe
data_df <- read.csv("data/MoviesOnStreamingPlatforms_updated.csv")

onlyNetflix <- data_df %>%
  select(Year, Netflix) %>%
  filter(Netflix == 1) %>%
  summarize(
  Year,
  Platform = "Netflix"
)


onlyPrime <- data_df %>%
  select(Year, Prime.Video) %>%
  filter(Prime.Video == 1) %>%
  summarize(
  Year,
  Platform = "Prime"
)


onlyHulu <- data_df %>%
  select(Year, Hulu) %>%
  filter(Hulu == 1) %>%
  summarize(
    Year,
    Platform = "Hulu"
  )

combined <- rbind.data.frame(onlyHulu,onlyNetflix,onlyPrime)

create_chart_2 <- function(){
  ggplot(combined, aes(Platform, Year))+
    geom_boxplot()+
    labs(title = "Box plot of the years of the movies on each platform")
}