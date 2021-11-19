#loads the data file into a dataframe
data_df <- read.csv("data/MoviesOnStreamingPlatforms_updated.csv")

#Mutates the rating rows into data types that are easy for calculations
data_df <- data_df %>% 
  mutate(IMDb = as.double(substr(na.omit(IMDb), 0, 3)), Rotten.Tomatoes = as.double(substr(na.omit(Rotten.Tomatoes), 0, 2)))

#Groups the data by movies that are on Netflix and summaries the data
data_netflix_df <- data_df %>%
  group_by(Netflix) %>%
  summarise(Provider = "Netflix", 
            Avg_IMDb = mean(na.omit(IMDb)), 
            Avg_Rotten_Tomatoes = mean(na.omit(Rotten.Tomatoes)), 
            Avg_Runtime = mean(na.omit(Runtime)), 
            Total_Movies = n()) %>%
  filter(Netflix == 1) %>% 
  select(Provider, Total_Movies, Avg_IMDb, Avg_Rotten_Tomatoes, Avg_Runtime)

#Groups the data by movies that are on Amazon Prime and summaries the data
data_amazon_df <- data_df %>%
  group_by(Prime.Video) %>%
  summarise(Provider = "Amazon", 
            Avg_IMDb = mean(na.omit(IMDb)), 
            Avg_Rotten_Tomatoes = mean(na.omit(Rotten.Tomatoes)), 
            Avg_Runtime = mean(na.omit(Runtime)), 
            Total_Movies = n()) %>%
  filter(Prime.Video == 1) %>% 
  select(Provider, Total_Movies, Avg_IMDb, Avg_Rotten_Tomatoes, Avg_Runtime)

#Groups the data by movies that are on Hulu and summaries the data
data_hulu_df <- data_df %>%
  group_by(Hulu) %>%
  summarise(Provider = "Hulu", 
            Avg_IMDb = mean(na.omit(IMDb)), 
            Avg_Rotten_Tomatoes = mean(na.omit(Rotten.Tomatoes)), 
            Avg_Runtime = mean(na.omit(Runtime)), 
            Total_Movies = n()) %>%
  filter(Hulu == 1) %>% 
  select(Provider, Total_Movies, Avg_IMDb, Avg_Rotten_Tomatoes, Avg_Runtime)

#Groups the data by movies that are on Disney+ and summaries the data
data_disney_df <- data_df %>%
  group_by(Disney.) %>%
  summarise(Provider = "Disney", 
            Avg_IMDb = mean(na.omit(IMDb)), 
            Avg_Rotten_Tomatoes = mean(na.omit(Rotten.Tomatoes)), 
            Avg_Runtime = mean(na.omit(Runtime)), 
            Total_Movies = n()) %>%
  filter(Disney. == 1) %>% 
  select(Provider, Total_Movies, Avg_IMDb, Avg_Rotten_Tomatoes, Avg_Runtime)

#Joins the 4 rows together into one table
data_movies_df <- full_join(data_netflix_df, full_join(data_amazon_df, full_join(data_hulu_df, data_disney_df)))