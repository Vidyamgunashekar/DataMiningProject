# Get 5 random Numbers from 5 to 99
floor(runif(9, min=1, max=9))

#install.packages("magrittr") # package installations are only needed the first time you use it
#install.packages("dplyr")  # alternative installation of the %>%
#install.packages("plotly") 
library(magrittr) # needs to be run every time you start R and want to use %>%
library(dplyr) 
library(plotly)


songs.df <- read.csv("songs_updated_v3.csv", stringsAsFactors = TRUE)
summary(songs.df)
colnames(songs.df)
#Cloning Dataset to avoid tampering
Spotify <- songs.df


#Number of songs in the year 1998,1999 and 2020
nrow(Spotify[Spotify$year < 2000,]) +nrow(Spotify[Spotify$year == 2020,])
#42

#Number of songs with popularity score < 10
nrow(Spotify[Spotify$popularity < 10,])
#179

#which year they belong
group_by(Spotify[Spotify$popularity < 10,])
Pop10 <- Spotify[Spotify$popularity < 10,] %>% group_by(year)
Pop10  %>% arrange(year)
Pop10$year

#popularity score across each year
library(dplyr)
selected.var <- c(3,5,6,7,8,9,10,11,12,13,14,15,16,17)

year_average.df=Spotify[selected.var]
year_average.df

year_average <- year_average.df %>% group_by(year) %>% 
  summarise(Total_Popularity=sum(popularity))
print(year_average)
View(year_average)


# Grouped
ggplot(year_average, aes(fill=Total_Popularity, y=Total_Popularity, x=year)) + 
  geom_bar(position="dodge", stat="identity")
